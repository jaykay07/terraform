### This file contains Variable mentiond in terraform scripts ###

variable "region" {
  default= "ap-south-1"
}

variable "shared_credentials_file" {
  default = "/root/.aws/credentials"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "ami_nginx" {
  default = "ami-068d43a544160b7ef"
}

variable "ami_docker" {
  default = "ami-068d43a544160b7ef"
}

variable "key_path" {
  default = "/root/.ssh/id_rsa.pub"
}


### Output  ###

output "nginx_dns_name" {
  value = aws_instance.nginx.public_dns
}
output "Worker-node1_Private_IP" {
  value = aws_instance.dockerhost1.private_ip
}
output "Worker-node2_Private_IP" {
  value = aws_instance.dockerhost2.private_ip
}

