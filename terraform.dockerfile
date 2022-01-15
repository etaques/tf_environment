FROM golang:alpine
MAINTAINER "HashiCorp Terraform Team <terraform@hashicorp.com>"

ARG vpc_module=vpc
ARG branch=dev
ARG aws_access_key_id
ARG aws_secret_access_key
  
ENV TERRAFORM_VERSION=1.0.8

RUN apk add --update git bash openssh make g++ openssl python3 py3-pip docker-cli \
&& pip3 install --upgrade pip \
&& pip3 install awscli \
&& mkdir /data
  
RUN aws --version
  
COPY ./infra /data
COPY ./secrets-lambda /data/secrets-lambda
COPY ./terraform-entrypoint.sh /
  
RUN chmod a+x /terraform-entrypoint.sh
  
RUN cp -rpf /data/env/dev /data/env/$branch \
&& cp -rpf /data/deploy/env/dev /data/deploy/env/$branch \
&& mv /data/deploy/env/db.tfvars /data/deploy/env/$branch \
&& mv /data/env/db.tfvars /data/env/$branch

RUN sed -i -e "s/vpc_import/$vpc_module/g" /data/env/$branch/module.tf
  
RUN sed -i -e "s/ns1/$branch/g" /data/env/$branch/db.tfvars \
&& sed -i -e "s/ns1/$branch/g" /data/deploy/env/$branch/db.tfvars

ENV TF_DEV=true
ENV TF_RELEASE=true
ENV AWS_ACCESS_KEY_ID=$aws_access_key_id
ENV AWS_SECRET_ACCESS_KEY=$aws_secret_access_key

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh

WORKDIR $GOPATH
ENTRYPOINT ["/terraform-entrypoint.sh"]
