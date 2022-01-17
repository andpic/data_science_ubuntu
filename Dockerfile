FROM ubuntu:latest
LABEL maintainer="apicciau@mail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

# Update and install build-essential
RUN apt-get update -q \
    && apt-get upgrade -yq \
    && apt-get install -yq \
        build-essential \
        curl \
        git \
        sudo \
        unzip \
        wget

# Install git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install git-lfs \
    && git lfs install

# Install miniconda
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh
RUN conda --version

# Configure conda
RUN conda config --set always_yes yes --set changeps1 no \
    && conda update -q conda \
    && conda info -a

# Create a new environmnent
RUN wget \
    https://raw.githubusercontent.com/andpic/data_science_ubuntu/main/environment.yml \
    && conda env create -f environment.yml \
    && rm environment.yml