resource "aws_s3_bucket" "bucket" {
    bucket = var.remote_bucket
    force_destroy = true
    object_lock_enabled = true
    
    tags = {
        Name = "S3 Remote Terraform State Store"
    }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
    bucket = aws_s3_bucket.bucket.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
    bucket = aws_s3_bucket.bucket.id
    rule {
        apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
        }
    }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
    bucket = aws_s3_bucket.bucket.id
    acl    = "private"
    
}

resource "aws_s3_bucket_public_access_block" "bucket_public_block" {
    bucket = aws_s3_bucket.bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}
