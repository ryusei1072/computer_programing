from ipywidgets import Textarea, FloatSlider, Button, HBox, VBox
from IPython.display import clear_output
import pyopenjtalk
import IPython
from IPython.display import Audio
from nnmnkwii.io import hts
from synth import out_voice

def synth_front(device, duration_model, duration_in_scaler, duration_out_scaler, acoustic_model, acoustic_in_scaler, acoustic_out_scaler, binary_dict, numeric_dict):
    tex = Textarea(value = "", placeholder='テキストを入力してください', rows = 8)
    gehin = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="下品な", readout_format=".1f")
    ama = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="甘えん坊の", readout_format=".1f")
    naki = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="泣き虫な", readout_format=".1f")
    genki = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="元気な", readout_format=".1f")
    taka = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="高飛車な", readout_format=".1f")
    sawa = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="爽やかな", readout_format=".1f")
    otona = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="大人っぽい", readout_format=".1f")
    houyou = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="包容力のある", readout_format=".1f")
    buai = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="無愛想な", readout_format=".1f")
    tume = FloatSlider(value=0, min=0, max=6.0, step=0.2, description="冷たい", readout_format=".1f")

    button = Button(description='生成')

    v1 = VBox([gehin, ama, naki, genki, taka])
    v2 = VBox([sawa, otona, houyou, buai, tume])
    h = HBox([tex, v1, v2])
    display(h, button)

    def on_click_callback(clicked_button: Button) -> None:
        clear_output()
        display(h, button)
        para = [gehin.value, ama.value, naki.value, genki.value, taka.value, sawa.value, otona.value, houyou.value, buai.value, tume.value]
        contexts = pyopenjtalk.extract_fullcontext(tex.value)
        labels = hts.HTSLabelFile.create_from_contexts(contexts)
        gen_wav = out_voice(device, labels, para, duration_model, duration_in_scaler, duration_out_scaler, acoustic_model, acoustic_in_scaler, acoustic_out_scaler, binary_dict, numeric_dict)
        IPython.display.display(Audio(gen_wav, rate=16000))
    button.on_click(on_click_callback)
