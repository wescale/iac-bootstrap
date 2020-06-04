
output "vpc_id" {
  value = module.vpc-wsc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc-wsc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc-wsc.private_subnet_ids
}
