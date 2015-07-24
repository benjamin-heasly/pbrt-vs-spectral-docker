FROM ubuntu:14.04

MAINTAINER Ben Heasly <benjamin.heasly@gmail.com>

### pbrt dependencies
RUN apt-get update \
    && apt-get install -y \
    bison \
    build-essential \
    flex \
    git \
    gsl-bin \
    libgsl0-dev \
    libpng12-dev \
    libjpeg-dev \
    libilmbase-dev \
    libopenexr-dev \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove

### build and install PBRT
RUN git clone https://github.com/ydnality/pbrt-v2-spectral.git
WORKDIR pbrt-v2-spectral/src
RUN git checkout rendertoolbox
RUN make
RUN mkdir /pbrt-v2-spectral
RUN cp -r build/* /pbrt-v2-spectral

### make a script for running PBRT
RUN echo "LD_LIBRARY_PATH=/pbrt-v2-spectral /pbrt-v2-spectral/pbrt" > pbrt-v2-spectral \
    && chmod +x pbrt-v2-spectral
