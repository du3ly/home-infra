#!/bin/bash
python3 -m venv ~/.venv
echo "alias venv='source ~/.venv/bin/activate'" >> ~/.zshrc
source ~/.zshrc
venv
pip3 install -r requirements.txt
