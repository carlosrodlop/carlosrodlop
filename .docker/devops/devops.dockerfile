FROM ubuntu:20.04 AS base
SHELL ["/bin/bash", "-c"]

LABEL   maintainer="Carlos Rodriguez Lopez <crodriguezlopez@cloudbees.com>" \
    version="1.1" \
    updated_at=2022-11-3

# Tooling
WORKDIR /root

ENV HD_BIND=0.0.0.0

RUN apt-get update -y && \
    # Installation additional repositories
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update -y && \
    # Installation common tools
    apt-get install -y --no-install-recommends \
    # https://brain2life.hashnode.dev/how-to-install-pyenv-python-version-manager-on-ubuntu-2004
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    git \
    zsh \
    unzip \
    gnupg \
    gpg-agent \
    parallel \
    vim \
    wget \
    less \
    ca-certificates \
    openssh-client \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir .antigen
RUN curl -L git.io/antigen > .antigen/antigen.zsh
COPY .zshrc .zshrc

RUN git clone --depth 1 https://github.com/asdf-vm/asdf.git .asdf
COPY .tool-versions .tool-versions
RUN source ~/.asdf/asdf.sh && \
    asdf plugin add awscli && \
    asdf plugin add eksctl && \
    asdf plugin add helm && \
    asdf plugin add helm-diff && \
    asdf plugin add helmfile && \
    asdf plugin add jq && \
    asdf plugin add yq && \
    asdf plugin add k9s && \
    asdf plugin add kubectl && \
    asdf plugin add velero && \
    asdf plugin add terraform && \
    asdf plugin add kubectx && \
    asdf plugin add python && \
    asdf plugin add gcloud && \
    asdf install && \
    helm plugin install https://github.com/komodorio/helm-dashboard.git

# Place into the mount with the Project Code
WORKDIR /root/labs

ENTRYPOINT ["/bin/zsh"]