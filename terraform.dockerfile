FROM golang:alpine
MAINTAINER "HashiCorp Terraform Team <terraform@hashicorp.com>"

# This is a HashiCorp Oficial image modified

ARG aws_access_key_id
ARG aws_secret_access_key
  
ENV TERRAFORM_VERSION=1.0.8

RUN apk add --update git bash openssh make g++ openssl python3 py3-pip docker-cli curl wget \
&& pip3 install --upgrade pip \
&& pip3 install awscli

#Aws-iam-authenticator
RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator \
&& chmod +x ./aws-iam-authenticator \
&& mkdir -p $HOME/bin \
&& cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator \
&& export PATH=$PATH:$HOME/bin

#Kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl \
&& chmod +x ./kubectl \
&& mv ./kubectl /usr/local/bin/kubectl \ 
&& kubectl version --client

#Helm
RUN git clone https://github.com/helm/helm.git \
&& cd helm \
&& make
  
ENV TF_LOG=TRACE
ENV TF_DEV=true
ENV TF_RELEASE=true
ENV AWS_ACCESS_KEY_ID=$aws_access_key_id
ENV AWS_SECRET_ACCESS_KEY=$aws_secret_access_key

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

WORKDIR $GOPATH
ENTRYPOINT ["tail", "-f", "/dev/null"]
