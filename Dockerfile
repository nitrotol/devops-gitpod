ARG DOCKER_COMPOSE_VERSION="2.6.1"
ARG BASE="ubuntu"
ARG BASE_TAG="20.04"

FROM ${BASE}:${BASE_TAG}

RUN apt update && DEBIAN_FRONTEND=noninteractive \
    apt install -y apt-transport-https ca-certificates gnupg sudo curl \
    groff less zip software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
    add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt install docker-ce docker-ce-cli containerd.io \
RUN curl -o /usr/local/bin/docker-compose -fsSL https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-$(uname -m) \
    && chmod +x /usr/local/bin/docker-compose

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && apt update && \
    apt install -y google-cloud-sdk google-cloud-cli-gke-gcloud-auth-plugin google-cloud-cli-kubectl-oidc \
    kubectl

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

# CIRCLECI_CLI_TOKEN
RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | bash

RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/$(lsb_release -cs).gpg | sudo apt-key add - \
    && curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/$(lsb_release -cs).list | sudo tee /etc/apt/sources.list.d/tailscale.list \
    && apt install -y tailscale

#USER gitpod