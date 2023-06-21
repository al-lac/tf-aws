resource "aws_s3_bucket" "alex" {
  bucket = "tf-controller-alex-bucket"

  tags = {
    Name        = "Alex Test"
    Environment = "Dev"
  }
}
