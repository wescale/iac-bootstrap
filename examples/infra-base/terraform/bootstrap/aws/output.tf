output "group" {
  value = var.group
}

output "env" {
  value = var.env
}

output "region" {
  value = var.region
}

output "tfstate_bucket_id" {
  value = aws_s3_bucket.tfstate_bucket.id
}
output "elb_bucket_id" {
  value = aws_s3_bucket.elb_logs.id
}
