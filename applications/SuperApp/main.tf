locals {
    prefix          = var.prefix_name
    remote_state_bucket_region    = var.aws_region
    remote_state_bucket           = var.remote_bucket
    alb_state_file                = var.alb_tfstate

}


data "terraform_remote_state" "alb" {
    backend = "s3"
    config = {
        bucket = local.remote_state_bucket
        region = local.remote_state_bucket_region
        key    = local.alb_state_file
    }
}

