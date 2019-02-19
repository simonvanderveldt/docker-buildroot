FROM debian:jessie

# Install dependencies
# https://buildroot.org/downloads/manual/manual.html#requirement-mandatory
RUN apt-get update && apt-get install -y -q \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    ca-certificates \
    cpio \
    debianutils \
    file \
    g++ \
    gcc \
    git \
    gzip \
    libncurses5-dev \
    locales \
    make \
    patch \
    perl \
    python \
    rsync \
    sed \
    tar \
    unzip \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/^# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen && locale-gen && update-locale LANG=en_US.UTF-8

# Install buildroot
ENV BR_VERSION 2018.11.2

RUN wget -qO- http://buildroot.org/downloads/buildroot-$BR_VERSION.tar.gz \
 | tar xz && mv buildroot-$BR_VERSION /buildroot

WORKDIR /buildroot

# Fix issue with make failing because buildroot wants a hash for downloaded kernel patches
COPY buildroot-linux-dont-check-hashes-for-user-supplied-patches.patch .
RUN patch -p1 < buildroot-linux-dont-check-hashes-for-user-supplied-patches.patch

# Build all in-kernel overlays using the kernel's dtbs make target
COPY linux-build-dtbs-using-kernel-make-target.patch .
RUN patch -p1 < linux-build-dtbs-using-kernel-make-target.patch
