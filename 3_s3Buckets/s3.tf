resource "aws_s3_bucket" "bucket" {
    # count = length(var.bucket_name)
    for_each = var.bucket_name
    bucket = each.value
    force_destroy = true
    tags = merge({
        Name = "S3 Bucket for ${each.key} WAR"
    },
    local.common_tags
    )
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
    # count = length(var.bucket_name)
    for_each = var.bucket_name
    bucket = aws_s3_bucket.bucket[each.key].id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
    for_each = var.bucket_name
    bucket = aws_s3_bucket.bucket[each.key].id
    rule {
        apply_server_side_encryption_by_default {
        # kms_master_key_id = "arn:aws:kms:eu-west-3:164940506138:alias/aws/s3" # Default key for aws s3 
        # sse_algorithm     = "aws:kms"
        sse_algorithm     = "AES256"
        }
    }
}

# resource "aws_s3_bucket_acl" "bucket_acl" {
#     for_each = var.bucket_name
#     bucket = aws_s3_bucket.bucket[each.key].id
#     acl    = "private"
    
# }

# resource "aws_s3_bucket_public_access_block" "bucket_public_block" {
#     for_each = var.bucket_name
#     bucket = aws_s3_bucket.bucket[each.key].id

#     block_public_acls       = true
#     block_public_policy     = true
#     ignore_public_acls      = true
#     restrict_public_buckets = true
# }

resource "aws_s3_object" "war" {
    for_each = var.bucket_name
    bucket = aws_s3_bucket.bucket[each.key].id
    key    = "war/"
}
