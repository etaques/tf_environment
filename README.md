# terraform-aws

Basic environment to work with Hashicorp Terraform running on docker


<b>1- Install docker on your enviroment, making your system as docker host</b>

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

<b>2- Install docker-compose on your environment</b>

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04

<b>3- Create basic directory to host docker-compose persistent folder</b>

mkdir /storage-docker/

mkdir /storage-docker/ferramentas

<b>4- Clone this repository</b>

git clone https://github.com/etaques/tf_environment.git
cd tf_environment

<b>5- Stand up environment according your need</b></br>
<b>5.1- Standing up environment (portainer-ui + terraform_builder) without aws credentials</b>

docker-compose --project-name AWS_WORKPLACE up -d --build

<b>5.2- Standing up environment (portainer-ui + terraform_builder) injecting aws credentials</b>

aws_access_key_id=XXXXXXX aws_secret_access_key=XXXXXXXX docker-compose --project-name AWS_WORKPLACE up -d --build

<b>5.3- Standing up just terraform container (terraform_builder only) without aws credentials</b>

docker build -f terraform.dockerfile -t terraform_builder .

docker run -d --name terraform_builder_1 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /usr/local/bin/docker-compose:/usr/local/bin/docker-compose \
-v /storage-docker/ferramentas/terraform_data:/data \
terraform_builder

<b>6- Access portainer UI and work on your containers at http://localhost:9000 easier</b>

The folder /data inside terraform container is the persistent place to put your terraform project

Now you can work with terraform in various versions just changing terraform.dockerfile environment variables, 
also portainer UI can give your easy way to check whats running or access shell from a beauty interface


<b>Basic Terraform commands:</b>

Planning enviroment

<pre>~$ terraform plan</pre>

Creating enviroment

<pre>~$ terraform apply</pre>

Destroying enviroment

<pre>~$ terraform destroy</pre>
