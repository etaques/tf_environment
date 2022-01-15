# terraform-aws

- Provisionar uma instância EC2 na AWS
- Criar as TAGS para a instância
- Execução de UserData com script de instalação e start do Nginx
- 2 Regras Security Group INBOUND, portas 80 e 22
- 1 Regra de Security Group OUTBOUND para a instância ter acesso à intern

Planning enviroment

<pre>~$ terraform plan</pre>

Creating enviroment

<pre>~$ terraform apply</pre>

Destroying enviroment

<pre>~$ terraform destroy</pre>
