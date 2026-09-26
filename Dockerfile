# ==========================================
# 0. BAZA
# ==========================================
ARG UBUNTU_TAG=latest

# ==========================================
# 1. WARSTWA: RUNTIME BASE (common ground)
# ==========================================
FROM ubuntu:${UBUNTU_TAG} AS runtime-base
ENV DEBIAN_FRONTEND=noninteractive \
    NEEDRESTART_MODE=a \
    TERM=xterm-256color

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ==========================================
# 2. WARSTWA: DEV
# ==========================================
FROM runtime-base AS dev-env

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        tar \
        make \
        cmake \
        ninja-build \
        build-essential \
        gcc-arm-none-eabi \
        libnewlib-arm-none-eabi \
        libstdc++-arm-none-eabi-newlib \
        git \
        python3 \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
