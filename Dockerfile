FROM ubuntu:latest
LABEL maintainer="apicciau@mail.com"

ENV DEBIAN_FRONTEND noninteractive

# Update and install build-essential
RUN apt-get update -q \
    && apt-get upgrade -yq \
    && apt-get install -yq \
        build-essential \
        curl \
        git \
        unzip \
        wget

# Install git LFS
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
    && sudo apt-get install git-lfs \
    && git lfs install

# Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh; \
    && chmod +x miniconda.sh \
    && CONDA_PATH=$HOME/miniconda \
    && ./miniconda.sh -b -p $CONDA_PATH \
    && echo "export PATH=$CONDA_PATH/bin:$PATH" >> $BASH_ENV

# Configure conda
RUN conda config --set always_yes yes --set changeps1 no \
    && conda update -q conda \
    && conda info -a \
    && conda env create -n data-science -f environment.yml