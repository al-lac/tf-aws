resource "aws_s3_bucket" "alex" {
  bucket = "tf-cloud-alex-bucket"

  tags = {
    Name        = "Alex Test"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "alex" {
  bucket = aws_s3_bucket.alex.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "alex" {
  bucket = aws_s3_bucket.alex.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "alex" {
  bucket = aws_s3_bucket.alex.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "alex" {
  depends_on = [
    aws_s3_bucket_ownership_controls.alex,
    aws_s3_bucket_public_access_block.alex,
  ]

  bucket = aws_s3_bucket.alex.id
  acl    = "public-read"
}

resource "aws_s3_object" "qr" {
  depends_on = [
    aws_s3_bucket_acl.alex,
  ]

  bucket = aws_s3_bucket.alex.id
  key    = "github-aws.png"
  source = "${path.module}/content/github-aws.png"
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  depends_on = [
    aws_s3_bucket_acl.alex,
  ]

  bucket       = aws_s3_bucket.alex.id
  key          = "index.html"
  source       = "${path.module}/content/index.html"
  acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  depends_on = [
    aws_s3_bucket_acl.alex,
  ]

  bucket       = aws_s3_bucket.alex.id
  key          = "error.html"
  source       = "${path.module}/content/error.html"
  acl          = "public-read"
  content_type = "text/html"
}
