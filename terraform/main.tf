# Variables
# Allowed domains for public access to the bucket
variable "allowed_origins" {
  type = list(string)
  default = [
    "http://localhost:3000",
    "http://localhost:5173",
    "https://thomasabishop.github.io/eolas/"
  ]
}

provider "aws" {
  region = "eu-west-2"
}

# Create the S3 bucket
resource "aws_s3_bucket" "eolas_graph" {
  bucket = "eolas-graph"
}

resource "aws_s3_bucket_public_access_block" "allow_public_policy" {
  bucket                  = aws_s3_bucket.eolas_graph.id
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read_single_file" {
  depends_on = [aws_s3_bucket_public_access_block.allow_public_policy]
  bucket     = aws_s3_bucket.eolas_graph.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          "${aws_s3_bucket.eolas_graph.arn}/json/*",
          "${aws_s3_bucket.eolas_graph.arn}/js/*"
        ]
      },
      {
        Sid    = "EnsureSingleFilePerDirectory"
        Effect = "Allow"
        Principal = {
          AWS = data.aws_caller_identity.current.account_id
        }
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.eolas_graph.arn}/json/*",
          "${aws_s3_bucket.eolas_graph.arn}/js/*"
        ]
      }
    ]
  })
}

# Enable CORS for specified domains
resource "aws_s3_bucket_cors_configuration" "eolas_graph" {
  bucket = aws_s3_bucket.eolas_graph.id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = var.allowed_origins
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}


# Get the current AWS account ID
data "aws_caller_identity" "current" {}

# Create the directory structure using S3 objects
resource "aws_s3_object" "json_directory" {
  bucket  = aws_s3_bucket.eolas_graph.id
  key     = "json/"
  content = ""
}

resource "aws_s3_object" "js_directory" {
  bucket  = aws_s3_bucket.eolas_graph.id
  key     = "js/"
  content = ""
}

# Outputs
output "bucket_name" {
  value = aws_s3_bucket.eolas_graph.id
}

output "url" {
  value = "https://${aws_s3_bucket.eolas_graph.bucket_regional_domain_name}"
}
