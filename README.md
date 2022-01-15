# terraform-aws

Basic environment to work with Hashicorp Terraform running on docker


1- Install docker on your enviroment, making your system as docker host

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04

2- Install docker-compose on your environment

https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04

3- Create basic directory to host docker-compose persistent folder

mkdir /storage-docker/

mkdir /storage-docker/ferramentas

4- Clone this repository

git clone https://github.com/etaques/tf_environment.git

5.1- Stand up environment without aws credentials

docker-compose --project-name AWS_WORKPLACE up -d --build

5.2- Stand up environment injecting aws credentials

aws_access_key_id=XXXXXXX aws_secret_access_key=XXXXXXXX docker-compose -f --project-name AWS_WORKPLACE up -d --build

6- Access portainer UI and to work on your containers at http://localhost:9000 easier

The folder /data inside terraform container is the persistent place to put your terraform project

Now you can work with terraform in various versions just changing terraform.dockerfile environment variables, 
also portainer UI can give your easy way to check whats running or access shell from a beauty interface


Basic Terraform commands:

Planning enviroment

<pre>~$ terraform plan</pre>

Creating enviroment

<pre>~$ terraform apply</pre>

Destroying enviroment

<pre>~$ terraform destroy</pre>
