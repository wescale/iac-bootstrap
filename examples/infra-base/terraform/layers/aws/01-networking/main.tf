module "vpc-wsc" {
  source               = "mehdi-wsc/vpc-wsc/aws"
  version              = "0.0.3"
  group                = var.group
  env                  = var.env
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  cidr_block_private   = var.cidr_block_private
  cidr_block_public    = var.cidr_block_public
  firstname = var.firstname
  lastname = var.lastname
  owner= var.owner
}



