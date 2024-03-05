FROM pytorch/pytorch:latest

ARG UID
ARG GID

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    sudo \
    build-essential \
    git-all \
    libgl1-mesa-glx && \
    addgroup --gid $GID rdprice && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" rdprice && \
    echo 'rdprice ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    rm -rf /var/lib/apt/lists/*

ADD torchsig/ /build/torchsig

ADD pyproject.toml /build/pyproject.toml

RUN pip3 install /build

RUN pip3 install notebook jupyterlab pytest pytest-benchmark tensorboard pickleshare

USER rdprice

WORKDIR /home/rdprice/working