FROM docker.io/debian:testing
COPY debian.sources /etc/apt/sources.list.d
RUN apt-get update && apt-get install -y \
    build-essential \
    python3.14 \
    python3.14-dev \
    pipx \
    pocl-opencl-icd \
    ocl-icd-libopencl1
RUN useradd -m worker
USER worker
