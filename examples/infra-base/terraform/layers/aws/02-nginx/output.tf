output "load_balancer" {
  value = aws_alb.alb.dns_name
}
output "asg_nginx" {
  value = module.nginx.id
}
output "sg_bastion" {
  value = aws_security_group.bastion.name
}
output "sg_nginx" {
  value = aws_security_group.nginx.name
}
output "sg_alb" {
  value = aws_security_group.alb.name
}
