FROM ubuntu:20.04

#Install base softvare deps
RUN apt update && DEBIAN_FRONTEND=noninteractive \
    apt install -y apt-transport-https ca-certificates gnupg sudo curl \
    groff less zip software-properties-common locales && \
    locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

#Add docker repo
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#Add gcloud repo
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

#Add tailscale repo
RUN curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/$(lsb_release -cs).gpg | apt-key add - &&  \
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/$(lsb_release -cs).list | \
    tee /etc/apt/sources.list.d/tailscale.list

#Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

#Install CircleCI CLI
# CIRCLECI_CLI_TOKEN
RUN curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | bash

#Install Docker compose
RUN curl -o /usr/local/bin/docker-compose -fsSL \
    https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-$(uname -m) && \
    chmod +x /usr/local/bin/docker-compose

#Update and install other sortware
RUN apt update && apt install -y google-cloud-sdk google-cloud-cli-gke-gcloud-auth-plugin  \
    google-cloud-cli-kubectl-oidc kubectl docker-ce docker-ce-cli containerd.io tailscale \
    jq vim

# Gitpod user
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/bash -p gitpod gitpod \
    && sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers && \
    usermod -aG docker gitpod

ENV HOME=/home/gitpod
WORKDIR /home/gitpod

USER gitpod

# use sudo so that user does not get sudo usage info on (the first) login
RUN sudo echo "Running 'sudo' for Gitpod: success" && \
    # create .bashrc.d folder and source it in the bashrc
    mkdir -p /home/gitpod/.bashrc.d && \
    (echo; echo "for i in \$(ls -A \$HOME/.bashrc.d/); do source \$HOME/.bashrc.d/\$i; done"; echo) >> /home/gitpod/.bashrc
