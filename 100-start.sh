#!/bin/sh

# Start the SSH service
service ssh start

# Start the Jupyter Lab service
eval "$(conda shell.bash hook)"
conda activate base
jupyter lab