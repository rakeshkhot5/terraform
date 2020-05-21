resource "aws_dynamodb_table" "lock-table" {
  name           = "terraform-lock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    transition {
      storage_class = "STANDARD_IA"
      days          = 30
    }
  }

  tags = {
    Name = "mybucket"
  }
}
