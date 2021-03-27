### This is main terraform file ###

### Provider ###

provider "aws" {
  region = var.region
  shared_credentials_file = var.shared_credentials_file
}


### Keypair ###

resource "aws_key_pair" "default" {
  key_name = "ec2-elb-key"
  public_key = file("${var.key_path}")
}

