pip install dfcon
pip3 install --user cython
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
# pip3 install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121
# pip install -r requirements.txt
pip install pytorch_memlab
pip install pytorch_lightning
pip install wget
pip install text-unidecode
pip install wandb
pip install mecab-python3
sudo apt install libmecab-dev
# python -m pip install --use-pep517 git+https://github.com/NVIDIA/NeMo.git@r1.18.0#egg=nemo_toolkit[all]
python -m pip install git+https://github.com/NVIDIA/NeMo.git@r1.18.0#egg=nemo_toolkit[all]
# pip install fairscale
# conda install cudatoolkit