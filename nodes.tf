### This File is for creating EC2 instances on AWS ###

##(Dockerhost1)

resource "aws_instance" "dockerhost1" {
  ami = var.ami_docker                            
  instance_type = var.instance_type
  key_name = aws_key_pair.default.id
  subnet_id = aws_subnet.public-subnet.id
  security_groups = ["${aws_security_group.instancesg.id}"]
  associate_public_ip_address = true
  user_data = file("docker-run.sh")

  tags = {
    Name = "worker-node1"
  }
}

##(Dockerhost2)

resource "aws_instance" "dockerhost2" {
  ami = var.ami_docker
  instance_type = var.instance_type
  key_name = aws_key_pair.default.id
  subnet_id = aws_subnet.public-subnet.id
  security_groups = ["${aws_security_group.instancesg.id}"]
  associate_public_ip_address = true
  user_data = file("docker-run.sh")

  tags = {
    Name = "worker-node2"
  }
}

## ALB (Nginx LB)

resource "aws_instance" "nginxlb" {
  ami = var.ami_nginx
  instance_type = var.instance_type
  key_name = aws_key_pair.default.id
  subnet_id = aws_subnet.public-subnet.id
  security_groups = ["${aws_security_group.lbsg.id}"]
  associate_public_ip_address = true
  provisioner "remote-exec" {
    connection {
                   host = self.public_ip
                   type = "ssh"
                   user = "ec2-user"
                   private_key = file("~/.ssh/id_rsa")
                   timeout = "1m"
                   agent = "false"
      }
    inline = [
      "sudo sed -i -e '$a\\' -e '${aws_instance.server1.private_ip} dockerhost1' /etc/hosts",
      "sudo sed -i -e '$a\\' -e '${aws_instance.server2.private_ip} dockerhost2' /etc/hosts"
    ]
  }

  user_data = file("nginx-run.sh")
  tags = {
    Name = "nginx-node"
  }
}

