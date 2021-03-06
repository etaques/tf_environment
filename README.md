# terraform-aws-fun-land

Basic scheme to have fun with multiple and isolated Hashicorp Terraform versions in one machine. 
This can help you to have several build environments each one with own aws credentials to perform tasks without re-work and not dirtying your operating system overwriting with different packages versions.

This scheme uses modified version of official Hashicorp Terraform dockerfile plus following tools installed:

- [aws cli v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [terraform 1.0.8](https://releases.hashicorp.com/terraform/) (set any version you want inside dockerfile)
- [aws iam authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [helm](https://helm.sh/docs/intro/install/)
- [git](#)
- [curl](#)
- [make](#)
- [wget](#)
- [openssl](#)
- [g++](#)
- [python3](#)
- [py3-pip](#)

Also docker is available inside container by docker-cli installation and docker socket shared from docker host to container

- [docker-cli](https://docs.docker.com/engine/install/) 

# install-steps

<b>1- Install docker on your enviroment, making your operational system as docker host</b>

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

<b>2- Install docker-compose on your environment</b>

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04

<b>3- Create basic directory to persist files</b>

<pre>mkdir /storage-docker/

mkdir /storage-docker/ferramentas</pre>

<b>4- Clone this repository</b>

<pre>git clone https://github.com/etaques/tf_environment.git
cd tf_environment</pre>

# Stand up the environment according your need

Set on terraform.dockerfile variables if you want:
<pre>
ENV TERRAFORM_VERSION=1.0.8
ENV TF_LOG=TRACE
ENV TF_DEV=true
ENV TF_RELEASE=true
ENV AWS_ACCESS_KEY_ID=
ENV AWS_SECRET_ACCESS_KEY=
</pre>

<b>5.1- Standing up (portainer-ui + terraform_builder) without aws credentials</b>

<pre>environment=dev docker-compose --project-name AWS_FUN_PLACE_1_V108 up -d --build</pre>

<b>5.2- Standing up (portainer-ui + terraform_builder) injecting aws credentials</b>

<pre>aws_access_key_id=XXXXXXX aws_secret_access_key=XXXXXXXX environment=dev docker-compose --project-name AWS_FUN_PLACE_2_V108 up -d --build</pre>

<b>5.3- Standing up just terraform container (terraform_builder only) without aws credentials</b>

build:
<pre>docker build -f terraform.dockerfile -t terraform_builder_108 .</pre>

Pay attention on this line to complete with correct path to not share with any existent container, in this case mine is <b>dev</b>
<pre>-v /storage-docker/ferramentas/terraform_data_<b>dev</b>:/data \</pre>

run:
<pre>docker run -d --name AWS_FUN_PLACE_3_V108 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /usr/local/bin/docker-compose:/usr/local/bin/docker-compose \
-v /storage-docker/ferramentas/terraform_data_<b>dev</b>:/data \
terraform_builder108</pre>

<b>6- Access portainer UI and work on your containers at http://localhost:9000 easier</b>

The folder <b>/data</b> inside terraform container is the persistent place to put your terraform project. If you did step 3, this is mapped on your docker host at directory:

<pre>/storage-docker/ferramentas/terraform_data_dev</pre>

Now you can work with terraform in various versions just changing terraform.dockerfile environment variables, 
also portainer UI can give your easy way to check whats running or access shell from a beauty interface

Have fun!

<b>Basic Terraform commands:</b>

Planning enviroment

<pre>~$ terraform plan</pre>

Creating enviroment

<pre>~$ terraform apply</pre>

Destroying enviroment

<pre>~$ terraform destroy</pre>
