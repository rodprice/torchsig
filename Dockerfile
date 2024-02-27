FROM pytorch/pytorch:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    git-all \
    libgl1-mesa-glx && \
    rm -rf /var/lib/apt/lists/*

ADD torchsig/ /build/torchsig

ADD pyproject.toml /build/pyproject.toml

RUN pip3 install /build

RUN pip3 install notebook jupyterlab pytest

WORKDIR /workspace/code
