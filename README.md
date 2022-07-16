# DevOps toolkit for GitPod

[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-908a85?logo=gitpod)](https://gitpod.io/#https://github.com/nitrotol/devops-gitpod)
[![Nightly build](https://github.com/nitrotol/devops-gitpod/actions/workflows/nightly.yml/badge.svg)](https://github.com/nitrotol/devops-gitpod/actions/workflows/nightly.yml)
[![Release build](https://github.com/nitrotol/devops-gitpod/actions/workflows/release.yml/badge.svg)](https://github.com/nitrotol/devops-gitpod/actions/workflows/release.yml)

### This toolkit contains:
* Docker Image
* .gitpod.yml 

## DockerFile

[GitPod docs](https://www.gitpod.io/docs/config-docker) about using this Docker image.

You can use this image locally:
```
docker push nitrotol/devops-gitpod:latest
```

### Release plan
Releases of this image published when come some important changes. 

These releases tagged as `latest` and corresponding version number.

Also, for keep all software versions up-to-date scheduled monthly-based nightly builds. 
There are tagged as `nightly-latest` and `nightly-MM-YYYY`.
Publishing of new release also update current month nightly image.

#### Image based on Ubuntu 20.04

#### Contains:
* Docker
* Docker-compose v2.6.1
* GCloud CLI
* AWS CLI
* TailScale
* CircleCI CLI
* Kubectl
* JQ
* VIM

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/nitrotol/devops-gitpod)