FROM nvidia/cuda:12.2.0-devel-ubuntu22.04
COPY entrypoint.d/ /opt/nvidia/entrypoint.d/
COPY jupyter_lab_config.py /root/.jupyter/
ENV PATH /opt/conda/bin:$PATH
RUN apt update && \
apt install -y openssh-server wget && \
apt install -y rsync && \
mkdir /var/run/sshd && \
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
echo 'root: ' | chpasswd && \
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
bash Miniconda3-latest-Linux-x86_64.sh -p /opt/conda -b && \
rm Miniconda3-latest-Linux-x86_64.sh && \
/opt/conda/bin/conda clean -tipy && \
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
/bin/bash -c "source activate base" && \
pip3 install torch torchvision torchaudio -i https://pypi.tuna.tsinghua.edu.cn/simple && \
pip install jupyterlab -i https://pypi.tuna.tsinghua.edu.cn/simple && \
pip install jupyterlab-language-pack-zh-CN -i https://pypi.tuna.tsinghua.edu.cn/simple && \
conda install nb_conda_kernels && \
apt clean