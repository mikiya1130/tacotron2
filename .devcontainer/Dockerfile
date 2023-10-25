FROM nvidia/cuda:11.0.3-devel-ubuntu18.04
ARG PYTHON_VERSION=3.7

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV SHELL=/bin/bash

ARG USERNAME=${USERNAME}
ARG USER_UID=${USER_UID}
ARG USER_GID=${USER_GID}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python${PYTHON_VERSION}-dev \
        python3-pip \
        python3-setuptools \
        git \
        liblapack-dev \
        libxft-dev

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

RUN python${PYTHON_VERSION} -m pip install -U pip && \
    python${PYTHON_VERSION} -m pip --disable-pip-version-check --no-cache-dir install \
        wheel \
        packaging \
        torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html

RUN git clone https://github.com/NVIDIA/apex.git /tmp/apex && \
    cd /tmp/apex && \
    python${PYTHON_VERSION} -m pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --config-settings "--build-option=--cpp_ext" --config-settings "--build-option=--cuda_ext" ./

COPY ./requirements.txt /tmp/
RUN python${PYTHON_VERSION} -m pip --disable-pip-version-check --no-cache-dir install -r /tmp/requirements.txt

USER $USERNAME
WORKDIR /workspace

RUN echo 'alias python="python'${PYTHON_VERSION}'"' >> ~/.bashrc
RUN echo 'alias python3="python'${PYTHON_VERSION}'"' >> ~/.bashrc
RUN echo 'alias pip="python'${PYTHON_VERSION}' -m pip"' >> ~/.bashrc
RUN echo 'alias pip3="python'${PYTHON_VERSION}' -m pip"' >> ~/.bashrc
ENV PATH "$PATH:~/.local/bin"
