variable "group" {}
variable "env" {}
variable "region" {}
variable "firstname" {}
variable "lastname" {}
variable "owner" {}


variable "vpc_cidr" {}
variable "authorized_ips" {
  type = list(string)
}

variable "instance_type" {
  default = "t2.micro"
}

data "aws_ami" "wordpress" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-wordpress-4.7.3-1-linux-debian-8-x86_64-frontend-rds-nami-hvm-ebs"]
  }

  owners = ["979382823631"]
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-stretch-hvm-x86_64-gp2*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["379101102735"] # Debian Project
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "${var.group}-${var.env}-${var.region}-tfstate"
    key    = "01-networking.tfstate"
    region = var.region
  }
}

data "aws_availability_zones" "all" {}
