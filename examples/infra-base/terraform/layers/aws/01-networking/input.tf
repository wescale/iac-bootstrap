variable "group" {}
variable "env" {}
variable "region" {}
variable "vpc_cidr" {}
variable "owner" {}
variable "firstname" {}
variable "lastname" {}
variable "public_subnet_count" {}
variable "private_subnet_count" {}
variable "cidr_block_private" {
  type = list(string)
}
variable "cidr_block_public" {
  type = list(string)
}


