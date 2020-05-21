output "rds_url" {
  value = aws_db_instance.test-rds.endpoint
}
