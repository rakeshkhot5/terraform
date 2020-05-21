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
