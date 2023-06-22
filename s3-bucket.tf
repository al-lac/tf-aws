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

  bucket = aws_s3_bucket.alex.id
  key    = "github-aws.png"
  content_base64 = "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"
  acl    = "public-read"
}

resource "aws_s3_object" "index" {
  depends_on = [
    aws_s3_bucket_acl.alex,
  ]

  bucket       = aws_s3_bucket.alex.id
  key          = "index.html"
  content_base64 = "PCFET0NUWVBFIGh0bWw+CjxodG1sIGxhbmc9ImVuIj4KCjxoZWFkPgogICAgPG1ldGEgY2hhcnNldD0iVVRGLTgiPgogICAgPG1ldGEgbmFtZT0idmlld3BvcnQiIGNvbnRlbnQ9IndpZHRoPWRldmljZS13aWR0aCwgaW5pdGlhbC1zY2FsZT0xLjAiPgogICAgPHRpdGxlPlFSIENvZGUgRGlzcGxheTwvdGl0bGU+CiAgICA8c3R5bGU+CiAgICAgICAgYm9keSB7CiAgICAgICAgICAgIGRpc3BsYXk6IGZsZXg7CiAgICAgICAgICAgIGZsZXgtZGlyZWN0aW9uOiBjb2x1bW47CiAgICAgICAgICAgIGp1c3RpZnktY29udGVudDogY2VudGVyOwogICAgICAgICAgICBhbGlnbi1pdGVtczogY2VudGVyOwogICAgICAgICAgICBtaW4taGVpZ2h0OiAxMDB2aDsKICAgICAgICAgICAgbWFyZ2luOiAwOwogICAgICAgICAgICBiYWNrZ3JvdW5kLWNvbG9yOiAjZjhmOWZhOwogICAgICAgICAgICBmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7CiAgICAgICAgICAgIHRleHQtYWxpZ246IGNlbnRlcjsKICAgICAgICB9CgogICAgICAgIGltZyB7CiAgICAgICAgICAgIHdpZHRoOiA4MCU7CiAgICAgICAgICAgIC8qIEFkanVzdCB0aGlzIHRvIG1ha2UgdGhlIGltYWdlIGxhcmdlciBvciBzbWFsbGVyICovCiAgICAgICAgICAgIGhlaWdodDogYXV0bzsKICAgICAgICAgICAgbWF4LXdpZHRoOiA2MDBweDsKICAgICAgICAgICAgLyogTWF4aW11bSB3aWR0aCBvZiB0aGUgaW1hZ2UgKi8KICAgICAgICB9CgogICAgICAgIEBtZWRpYSBvbmx5IHNjcmVlbiBhbmQgKG1pbi13aWR0aDogNzY4cHgpIHsKICAgICAgICAgICAgaW1nIHsKICAgICAgICAgICAgICAgIHdpZHRoOiA2MDBweDsKICAgICAgICAgICAgICAgIC8qIEZpeGVkIHdpZHRoIG9uIGxhcmdlciBzY3JlZW5zICovCiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICA8L3N0eWxlPgo8L2hlYWQ+Cgo8Ym9keT4KICAgIDxoMT5MaW5rIHRvIEZsdXggR2l0T3BzIFJlcG9zaXRvcnk8L2gxPgogICAgPGltZyBzcmM9ImdpdGh1Yi1hd3MucG5nIiBhbHQ9IkdpdGh1YiBBV1MgUVIgQ29kZSI+CjwvYm9keT4KCjwvaHRtbD4="
  acl          = "public-read"
  content_type = "text/html"
}
