# terraform-aws-funland

Basic environment to fun with Hashicorp Terraform running on docker

This environment uses modified version of Hashicorp Terraform dockerfile following tools installed:

- [aws cli v2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [terraform 1.0.8](https://releases.hashicorp.com/terraform/)
- [aws iam authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [helm](https://helm.sh/docs/intro/install/)

Also docker is available inside container

- [docker](https://docs.docker.com/engine/install/) 

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

# Stand up environment according your need

<b>5.1- Standing up environment (portainer-ui + terraform_builder) without aws credentials</b>

<pre>docker-compose --project-name AWS_WORKPLACE up -d --build</pre>

<b>5.2- Standing up environment (portainer-ui + terraform_builder) injecting aws credentials</b>

<pre>aws_access_key_id=XXXXXXX aws_secret_access_key=XXXXXXXX docker-compose --project-name AWS_WORKPLACE up -d --build</pre>

<b>5.3- Standing up just terraform container (terraform_builder only) without aws credentials</b>

<pre>docker build -f terraform.dockerfile -t terraform_builder .</pre>

<pre>docker run -d --name terraform_builder_1 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /usr/local/bin/docker-compose:/usr/local/bin/docker-compose \
-v /storage-docker/ferramentas/terraform_data:/data \
terraform_builder</pre>

<b>6- Access portainer UI and work on your containers at http://localhost:9000 easier</b>

The folder /data inside terraform container is the persistent place to put your terraform project

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
