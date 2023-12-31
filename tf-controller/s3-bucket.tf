resource "aws_s3_bucket" "alex" {
  bucket = "tf-controller-alex-bucket"

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

  bucket         = aws_s3_bucket.alex.id
  key            = "github-aws.png"
  #content_base64 = "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"
  source         = "${path.module}/content/github-aws.png"
  acl            = "public-read"
}

resource "aws_s3_object" "index" {
  depends_on = [
    aws_s3_bucket_acl.alex,
  ]

  bucket         = aws_s3_bucket.alex.id
  key            = "index.html"
  #content_base64 = "PCFET0NUWVBFIGh0bWw+CjxodG1sIGxhbmc9ImVuIj4KCjxoZWFkPgogICAgPG1ldGEgY2hhcnNldD0iVVRGLTgiPgogICAgPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xLjAiPgogICAgPHRpdGxlPlFSIENvZGUgRGlzcGxheTwvdGl0bGU+CiAgICA8c3R5bGU+CiAgICAgICAgYm9keSB7CiAgICAgICAgICAgIGRpc3BsYXk6IGZsZXg7CiAgICAgICAgICAgIGZsZXgtZGlyZWN0aW9uOiBjb2x1bW47CiAgICAgICAgICAgIGp1c3RpZnktY29udGVudDogY2VudGVyOwogICAgICAgICAgICBhbGlnbi1pdGVtczogY2VudGVyOwogICAgICAgICAgICBtaW4taGVpZ2h0OiAxMDB2aDsKICAgICAgICAgICAgbWFyZ2luOiAwOwogICAgICAgICAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjZjhmOWZhOwogICAgICAgICAgICBmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7CiAgICAgICAgICAgIHRleHQtYWxpZ246IGNlbnRlcjsKICAgICAgICB9CgogICAgICAgIGltZyB7CiAgICAgICAgICAgIHdpZHRoOiA4MCU7CiAgICAgICAgICAgIC8qIEFkanVzdCB0aGlzIHRvIG1ha2UgdGhlIGltYWdlIGxhcmdlciBvciBzbWFsbGVyICovCiAgICAgICAgICAgIGhlaWdodDogYXV0bzsKICAgICAgICAgICAgbWF4LXdpZHRoOiA2MDBweDsKICAgICAgICAgICAgLyogTWF4aW11bSB3aWR0aCBvZiB0aGUgaW1hZ2UgKi8KICAgICAgICB9CgogICAgICAgIEBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1pbi13aWR0aDogNzY4cHgpIHsKICAgICAgICAgICAgaW1nIHsKICAgICAgICAgICAgICAgIHdpZHRoOiA2MDBweDsKICAgICAgICAgICAgICAgIC8qIEZpeGVkIHdpZHRoIG9uIGxhcmdlciBzY3JlZW5zICovCiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICA8L3N0eWxlPgo8L2hlYWQ+Cgo8Ym9keT4KICAgIDxoMT5MaW5rIHRvIFRlcnJhZm9ybSBHaXRPcHMgUmVwb3NpdG9yeSAtIERlcGxveWVkIGJ5IEZsdXggVGVycmFmb3JtIENvbnRyb2xsZXI8L2gxPgogICAgPGltZyBzcmM9ImdpdGh1Yi1hd3MucG5nIiBhbHQ9IkdpdGh1YiBBV1MgUVIgQ29kZSI+CjwvYm9keT4KCjwvaHRtbD4="
  source         = "${path.module}/content/index.html"
  acl            = "public-read"
  content_type   = "text/html"
}

resource "aws_s3_object" "error" {
  depends_on = [
    aws_s3_bucket_acl.alex,
  ]

  bucket         = aws_s3_bucket.alex.id
  key            = "error.html"
  source         = "${path.module}/content/error.html"
  acl            = "public-read"
  content_type   = "text/html"
}
