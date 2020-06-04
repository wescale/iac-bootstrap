#Key pair
resource "aws_key_pair" "pub_key" {
  key_name   = "${var.firstname}.${var.lastname}"
  public_key = file("../../../../configs/${var.group}/${var.env}/ssh/id_rsa.pub")
}
module "bastion" {

  source                    = "mehdi-wsc/asg-wsc/aws"
  version                   = "0.0.6"
  name                      = "${var.group}-${var.env}-bastion-asg"
  max_size                  = "1"
  min_size                  = "0"
  health_check_grace_period = "300"
  health_check_type         = "ELB"
  desired_capacity          = "1"
  force_delete              = true
  vpc_zone_identifier       = [element(data.terraform_remote_state.vpc.outputs.public_subnet_ids, 0)]
  name_config               = "${var.group}-${var.env}-bastion-lt"
  ami                       = data.aws_ami.debian.id
  instance_type             = "t2.micro"

  key             = "${var.firstname}.${var.lastname}"
  ip              = true
  security_groups = ["${aws_security_group.bastion.id}"]
  firstname                 = "${var.firstname}"
  lastname                  = "${var.lastname}"
  owner                     = "${var.owner}"


}
module "nginx" {

  source  = "mehdi-wsc/asg-wsc/aws"
  version = "0.0.6"

  name                      = "${var.group}-${var.env}-nginx-asg"
  max_size                  = "5"
  min_size                  = "2"
  health_check_grace_period = "300"
  health_check_type         = "ELB"
  desired_capacity          = "3"
  force_delete              = true
  vpc_zone_identifier       = "${data.terraform_remote_state.vpc.outputs.private_subnet_ids}"
  ami                       = data.aws_ami.debian.id
  name_config               = "${var.group}-${var.env}-nginx-lt"
  instance_type             = "t2.micro"
  key                       = "${var.firstname}.${var.lastname}"
  ip                        = false
  security_groups           = ["${aws_security_group.nginx.id}"]
  firstname                 = "${var.firstname}"
  lastname                  = "${var.lastname}"
  owner                     = "${var.owner}"

}
