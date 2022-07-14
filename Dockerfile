FROM ubuntu:20.04

RUN apt update && DEBIAN_FRONTEND=noninteractive \
    apt install -y apt-transport-https ca-certificates gnupg sudo curl \
    groff less zip

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

#USER gitpod