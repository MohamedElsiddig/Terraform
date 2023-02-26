locals {
    s3_bucket   = data.terraform_remote_state.s3.outputs.buckets[var.bucket_name]
}
resource "aws_iam_policy" "this" {
    name        = "${local.prefix}-S3-Policy"
    path        = "/"
    description = "${local.prefix} policy for accessing S3 Bucket"

    # policy = jsonencode({
    #     "Version" : "2012-10-17",
    #     "Statement" : [
    #     {
    #         "Sid" : "VisualEditor0",
    #         "Effect" : "Allow",
    #         "Action" : [
    #         # "s3:PutObject",
    #         "s3:GetObject",
    #         "s3:ListBucket",
    #         "s3:DeleteObject"
    #         ],
    #         "Resource" : [
    #         "arn:aws:s3:::${local.s3_bucket}",
    #         "arn:aws:s3:::${local.s3_bucket}/*"
    #         ]
    #     }
    #     ]
    # })
    policy = jsonencode(
        {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetLifecycleConfiguration",
                "s3:GetBucketTagging",
                "s3:GetInventoryConfiguration",
                "s3:GetObjectVersionTagging",
                "s3:ListBucketVersions",
                "s3:GetBucketLogging",
                "s3:ListBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetObjectVersionAttributes",
                "s3:GetBucketPolicy",
                "s3:GetObjectVersionTorrent",
                "s3:GetObjectAcl",
                "s3:GetEncryptionConfiguration",
                "s3:GetBucketObjectLockConfiguration",
                "s3:GetIntelligentTieringConfiguration",
                "s3:GetBucketRequestPayment",
                "s3:GetObjectVersionAcl",
                "s3:GetObjectTagging",
                "s3:GetMetricsConfiguration",
                "s3:GetBucketOwnershipControls",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketPolicyStatus",
                "s3:ListBucketMultipartUploads",
                "s3:GetObjectRetention",
                "s3:GetBucketWebsite",
                "s3:GetObjectAttributes",
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "s3:GetObjectLegalHold",
                "s3:GetBucketNotification",
                "s3:GetReplicationConfiguration",
                "s3:ListMultipartUploadParts",
                "s3:GetObject",
                "s3:GetObjectTorrent",
                "s3:GetBucketCORS",
                "s3:GetAnalyticsConfiguration",
                "s3:GetObjectVersionForReplication",
                "s3:GetBucketLocation",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::${local.s3_bucket}",
                "arn:aws:s3:::${local.s3_bucket}/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "s3:ListStorageLensConfigurations",
                "s3:ListAccessPointsForObjectLambda",
                "s3:GetAccessPoint",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "s3:ListAccessPoints",
                "s3:ListJobs",
                "s3:ListMultiRegionAccessPoints"
            ],
            "Resource": "*"
        }
    ]
    })
}
resource "aws_iam_role" "this_role" {
    name = "${local.prefix}-Role"

    # assume_role_policy = jsonencode({
    #     Version = "2012-10-17"
    #     Statement = [
    #     {
    #         Action = "sts:AssumeRole"
    #         Effect = "Allow"
    #         Sid    = ""
    #         Principal = {
    #         Service = "ec2.amazonaws.com"
    #         }
    #     },
    #     ]
    # })
    assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
    })
}

resource "aws_iam_policy_attachment" "this_pa" {
    name        = "${local.prefix}-policy-attachment"
    roles       = [aws_iam_role.this_role.name]
    policy_arn = aws_iam_policy.this.arn
}

    resource "aws_iam_instance_profile" "this_isp" {
        name = "${local.prefix}-instance-profile"
        role = aws_iam_role.this_role.name

    }