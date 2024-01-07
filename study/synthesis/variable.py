import ttslearn
from nnmnkwii.io import hts
import joblib
import torch
from synth import LSTM

def model_valiable():
    binary_dict, numeric_dict = hts.load_question_set(ttslearn.util.example_qst_file())

    duration_in_scaler = joblib.load("./in_duration_scaler.joblib")
    duration_out_scaler = joblib.load("./out_duration_scaler.joblib")
    acoustic_in_scaler = joblib.load("./in_acoustic_scaler.joblib")
    acoustic_out_scaler = joblib.load("./out_acoustic_scaler.joblib")

    device = torch.device("cuda")
    duration_model = LSTM(in_dim=335, hidden_dim_1 = 50, hidden_dim_2 = 200, hidden_dim_3 = 400, hidden_dim_4 = 300, hidden_dim_5 = 200, hidden_dim_6 = 100, out_dim=1, num_layers=2).to(device)
    checkpoint_duration = torch.load("./duration_best_loss.pth", map_location=device)
    duration_model.load_state_dict(checkpoint_duration["state_dict"])
    duration_model.eval();

    acoustic_model = LSTM(in_dim=339, hidden_dim_1 = 50, hidden_dim_2 = 200, hidden_dim_3 = 400, hidden_dim_4 = 300, hidden_dim_5 = 200, hidden_dim_6 = 100, out_dim=127, num_layers=2).to(device)
    checkpoint_acoustic = torch.load("./acoustic_best_loss.pth", map_location=device)
    acoustic_model.load_state_dict(checkpoint_acoustic["state_dict"])
    acoustic_model.eval();

    return device, duration_model, duration_in_scaler, duration_out_scaler, acoustic_model, acoustic_in_scaler, acoustic_out_scaler, binary_dict, numeric_dict