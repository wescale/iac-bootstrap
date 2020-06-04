
resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "${var.group}-${var.env}-${var.region}-tfstate"
  acl    = "private"
  region = var.region

  versioning {
    enabled = true
  }

  tags = {
    Name = "${var.group}-${var.env}-${var.region}-tfstate"
  }
}
data "aws_elb_service_account" "main" {}

resource "aws_s3_bucket" "elb_logs" {
  bucket = "${var.group}-${var.env}-${var.region}-logs"
  acl    = "private"

  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.group}-${var.env}-${var.region}-logs/AWSLogs/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY
}



resource "aws_dynamodb_table" "tfstate_lock" {
  name           = "${var.group}-${var.env}-${var.region}-tfstate-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name = "${var.group}-${var.env}-${var.region}-tfstate-lock"
  }
}
