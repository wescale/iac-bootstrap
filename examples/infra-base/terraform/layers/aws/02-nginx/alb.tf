# Load Balancer
resource "aws_alb" "alb" {
  name            = "${var.group}-${var.env}-nginx-alb"
  subnets         = [element(data.terraform_remote_state.vpc.outputs.public_subnet_ids, 0), element(data.terraform_remote_state.vpc.outputs.private_subnet_ids, 1)]
  security_groups = ["${aws_security_group.alb.id}"]
  tags = {
    Name           = "Load Balancer "
    owner          = var.owner
    account        = terraform.workspace
    createdBy      = var.firstname
    taggingVersion = "1.0.0"
  }
  access_logs {
    bucket = "${var.group}-${var.env}-${var.region}-logs"
    prefix = "alb-logs"
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.alb_target.arn
    type             = "forward"
  }
}
resource "aws_alb_target_group" "alb_target" {
  name     = "${var.group}-${var.env}-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Name           = "Auto scaling group "
    owner          = var.owner
    account        = terraform.workspace
    createdBy      = var.firstname
    taggingVersion = "1.0.0"
  }

}
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = module.nginx.id
  alb_target_group_arn   = aws_alb_target_group.alb_target.arn
}
