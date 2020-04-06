FROM ubuntu:bionic

RUN apt update -y -qq && \
    apt install -y -qq --no-install-recommends \
        curl \
        dnsutils \
        iputils-ping \
        net-tools && \
    rm -rf /var/lib/apt/lists/*
