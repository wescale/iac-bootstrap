#Define security group
resource "aws_security_group" "bastion" {
  name        = "${var.group}-${var.env}-bastion-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  ingress {
    from_port = 22

    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.authorized_ips
  }
  tags = {
    Name           = "security group for bastion"
    owner          = var.owner
    account        = terraform.workspace
    createdBy      = var.firstname
    taggingVersion = "1.0.0"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "nginx" {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  name   = "${var.group}-${var.env}-nginx-sg"
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "TCP"
    security_groups = ["${aws_security_group.bastion.id}"]
  }
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "TCP"
    security_groups = ["${aws_security_group.alb.id}"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name           = "security group for nginx instances"
    owner          = var.owner
    account        = terraform.workspace
    createdBy      = var.firstname
    taggingVersion = "1.0.0"
  }



}
resource "aws_security_group" "alb" {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  name   = "${var.group}-${var.env}-alb-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name           = "security group for ALB"
    owner          = var.owner
    account        = terraform.workspace
    createdBy      = var.firstname
    taggingVersion = "1.0.0"
  }
}
