import torch
from torch import nn
from torch.nn.utils.rnn import pack_padded_sequence, pad_packed_sequence
from torch.utils import data as data_utils
import numpy as np
from nnmnkwii.frontend import merlin as fe
from nnmnkwii.postfilters import merlin_post_filter
from ttslearn.dnntts.multistream import get_windows, multi_stream_mlpg
from ttslearn.dnntts.multistream import get_static_stream_sizes
from ttslearn.dnntts.multistream import split_streams
import pysptk
import pyworld
import IPython
from IPython.display import Audio

class LSTM(nn.Module):
    def __init__(
        self, in_dim, hidden_dim_1, hidden_dim_2, hidden_dim_3, hidden_dim_4, hidden_dim_5, hidden_dim_6, out_dim, num_layers=1, bidirectional=True, dropout=0.5
    ):
        super(LSTM, self).__init__()
        self.num_layers = num_layers
        num_direction = 2 if bidirectional else 1
        self.fc1 = nn.Linear(num_direction * hidden_dim_3, hidden_dim_4)
        self.fc2 = nn.Linear(hidden_dim_4, hidden_dim_5)
        self.fc3 = nn.Linear(hidden_dim_5, hidden_dim_6)

        self.lstm1 = nn.LSTM(
            in_dim,
            hidden_dim_1,
            num_layers,
            bidirectional=bidirectional,
            batch_first=True,
            dropout=dropout,
        )
        self.lstm2 = nn.LSTM(
            num_direction * hidden_dim_1,
            hidden_dim_2,
            num_layers,
            bidirectional=bidirectional,
            batch_first=True,
            dropout=dropout,
        )
        self.lstm3 = nn.LSTM(
            num_direction * hidden_dim_2,
            hidden_dim_3,
            num_layers,
            bidirectional=bidirectional,
            batch_first=True,
            dropout=dropout,
        )
  
        self.hidden2out = nn.Linear(hidden_dim_6, out_dim)

    def forward(self, seqs, lens):

        seqs = pack_padded_sequence(seqs, lens, batch_first=True) 
        out, _ = self.lstm1(seqs)
        out, _ = self.lstm2(out)
        out, _ = self.lstm3(out)
        out, _ = pad_packed_sequence(out, batch_first=True)

        out= self.fc1(out)
        out= self.fc2(out)
        out= self.fc3(out)

        out = self.hidden2out(out)
        return out

class Dataset(data_utils.Dataset):
    def __init__(self, in_paths, out_paths):
        self.in_paths = in_paths
        self.out_paths = out_paths

    def __getitem__(self, idx):
        return np.load(self.in_paths[idx]), np.load(self.out_paths[idx])

    def __len__(self):
        return len(self.in_paths)

def predict_duration(
    device,  # cpu or cuda
    labels,  # フルコンテキストラベル
    para, #パラメーター
    duration_model,  # 学習済み継続長モデル
    duration_in_scaler,  # 言語特徴量の正規化用 StandardScaler
    duration_out_scaler,  # 音素継続長の正規化用 StandardScaler
    binary_dict,  # 二値特徴量を抽出する正規表現
    numeric_dict,  # 数値特徴量を抽出する正規表現
):
    # 言語特徴量の抽出
    in_feats = fe.linguistic_features(labels, binary_dict, numeric_dict).astype(np.float32)

    # 言語特徴量の正規化
    in_feats = duration_in_scaler.transform(in_feats)

    in_feats = np.concatenate([in_feats, np.tile(para, (in_feats.shape[0], 1))], 1) 


    # 継続長の予測
    x = torch.from_numpy(in_feats).float().to(device).view(1, -1, in_feats.shape[-1])
    pred_durations = duration_model(x, [x.shape[1]]).squeeze(0).cpu().data.numpy()

    # 予測された継続長に対して、正規化の逆変換を行います
    pred_durations = duration_out_scaler.inverse_transform(pred_durations)

    # 閾値処理
    pred_durations[pred_durations <= 0] = 1
    pred_durations = np.round(pred_durations)

    return pred_durations

def predict_acoustic(
    device,  # CPU or GPU
    labels,  # フルコンテキストラベル
    para,
    acoustic_model,  # 学習済み音響モデル
    acoustic_in_scaler,  # 言語特徴量の正規化用 StandardScaler
    acoustic_out_scaler,  # 音響特徴量の正規化用 StandardScaler
    binary_dict,  # 二値特徴量を抽出する正規表現
    numeric_dict,  # 数値特徴量を抽出する正規表現
    mlpg=True,  # MLPG を使用するかどうか
):
    # フレーム単位の言語特徴量の抽出
    in_feats = fe.linguistic_features(
        labels,
        binary_dict,
        numeric_dict,
        add_frame_features=True,
        subphone_features="coarse_coding",
    )

    # 正規化
    in_feats = acoustic_in_scaler.transform(in_feats)

    in_feats = np.concatenate([in_feats, np.tile(para, (in_feats.shape[0], 1))], 1) 

    # 音響特徴量の予測
    x = torch.from_numpy(in_feats).float().to(device).view(1, -1, in_feats.shape[-1])
    pred_acoustic = acoustic_model(x, [x.shape[1]]).squeeze(0).cpu().data.numpy()

    # 予測された音響特徴量に対して、正規化の逆変換を行います
    pred_acoustic = acoustic_out_scaler.inverse_transform(pred_acoustic)

    # パラメータ生成アルゴリズム (MLPG) の実行
    if mlpg:
        # (T, D_out) -> (T, static_dim)
        pred_acoustic = multi_stream_mlpg(
            pred_acoustic,
            acoustic_out_scaler.var_,
            get_windows(3),#acoustic_config.num_windows
            [120, 3, 1, 3], #acoustic_config.stream_sizes,
            [True, True, False, True]
            #["true", "true", "false", "true"]
        )

    return pred_acoustic

def gen_waveform(
    sample_rate,  # サンプリング周波数
    acoustic_features,  # 音響特徴量
    stream_sizes,  # ストリームサイズ
    has_dynamic_features,  # 音響特徴量が動的特徴量を含むかどうか
    num_windows=3,  # 動的特徴量の計算に使う窓数
    post_filter=False,  # フォルマント強調のポストフィルタを使うかどうか
):
    # 静的特徴量の次元数を取得
    if np.any(has_dynamic_features):
        static_stream_sizes = get_static_stream_sizes(
            stream_sizes, has_dynamic_features, num_windows
        )
    else:
        static_stream_sizes = stream_sizes

    # 結合された音響特徴量をストリーム毎に分離
    mgc, lf0, vuv, bap = split_streams(acoustic_features, static_stream_sizes)

    fftlen = pyworld.get_cheaptrick_fft_size(sample_rate)
    alpha = pysptk.util.mcepalpha(sample_rate)

    # フォルマント強調のポストフィルタ
    if post_filter:
        mgc = merlin_post_filter(mgc, alpha)

    # 音響特徴量を音声パラメータに変換
    spectrogram = pysptk.mc2sp(mgc, fftlen=fftlen, alpha=alpha)
    aperiodicity = pyworld.decode_aperiodicity(
        bap.astype(np.float64), sample_rate, fftlen
    )
    f0 = lf0.copy()
    f0[vuv < 0.5] = 0
    f0[np.nonzero(f0)] = np.exp(f0[np.nonzero(f0)])

    # WORLD ボコーダを利用して音声生成
    gen_wav = pyworld.synthesize(
        f0.flatten().astype(np.float64),
        spectrogram.astype(np.float64),
        aperiodicity.astype(np.float64),
        sample_rate,
    )

    return gen_wav

def out_voice(
    device,
    labels, 
    para, 
    duration_model, 
    duration_in_scaler, 
    duration_out_scaler, 
    acoustic_model, 
    acoustic_in_scaler,
    acoustic_out_scaler, 
    binary_dict, 
    numeric_dict
):
    durations = predict_duration(device,
                            labels, 
                            para, 
                            duration_model, 
                            duration_in_scaler, 
                            duration_out_scaler, 
                            binary_dict, 
                            numeric_dict)
    labels.set_durations(durations)
    out_feats = predict_acoustic(device, 
                            labels, 
                            para, 
                            acoustic_model, 
                            acoustic_in_scaler,
                            acoustic_out_scaler, 
                            binary_dict, 
                            numeric_dict)
    gen_wav = gen_waveform(
    sample_rate = 16000, 
    acoustic_features = out_feats, 
    stream_sizes = [120, 3, 1, 3], 
    has_dynamic_features = [True, True, False, True]
             )
    return gen_wav