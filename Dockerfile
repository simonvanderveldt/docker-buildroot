FROM debian:stretch

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
    graphviz \
    gzip \
    libelf-dev \
    libncurses5-dev \
    locales \
    make \
    patch \
    perl \
    python \
    python-matplotlib \
    rsync \
    sed \
    tar \
    unzip \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/^# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen && locale-gen && update-locale LANG=en_US.UTF-8

# Install buildroot
ENV BR_VERSION 2021.02.3

RUN wget -qO- http://buildroot.org/downloads/buildroot-$BR_VERSION.tar.gz \
 | tar xz && mv buildroot-$BR_VERSION /buildroot

WORKDIR /buildroot
