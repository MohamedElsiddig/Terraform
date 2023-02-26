locals {
    prefix          = var.prefix_name
    remote_state_bucket_region    = var.aws_region
    remote_state_bucket           = var.remote_bucket
    network_state_file            = var.network_tfstate
    alb_state_file                = var.alb_tfstate
    s3_state_file                 = var.s3_tfstate

    common_tags     = data.terraform_remote_state.network.outputs.common_tags
    vpc_id          = data.terraform_remote_state.network.outputs.vpc_id
    public_subnets  = data.terraform_remote_state.network.outputs.public_subnets
    private_subnets = data.terraform_remote_state.network.outputs.private_subnets
}


data "terraform_remote_state" "alb" {
    backend = "s3"
    config = {
        bucket = local.remote_state_bucket
        region = local.remote_state_bucket_region
        key    = local.alb_state_file
    }
}



data "terraform_remote_state" "network" {
    backend = "s3"
    config = {
        bucket = local.remote_state_bucket
        region = local.remote_state_bucket_region
        key    = local.network_state_file
    }
}


data "terraform_remote_state" "s3" {
    backend = "s3"
    config = {
        bucket = local.remote_state_bucket
        region = local.remote_state_bucket_region
        key    = local.s3_state_file
    }
}