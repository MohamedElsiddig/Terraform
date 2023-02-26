locals {

    remote_state_bucket_region    = var.aws_region
    remote_state_bucket           = var.remote_bucket
    network_state_file            = var.network_tfstate

    prefix          = data.terraform_remote_state.network.outputs.prefix
    common_tags     = data.terraform_remote_state.network.outputs.common_tags
    vpc_id          = data.terraform_remote_state.network.outputs.vpc_id
    public_subnets  = data.terraform_remote_state.network.outputs.public_subnets
    private_subnets = data.terraform_remote_state.network.outputs.private_subnets
    vpc_sg          = data.terraform_remote_state.network.outputs.vpc_security_group_ids
    db_subnets      = data.terraform_remote_state.network.outputs.db_subnets
}


data "terraform_remote_state" "network" {
    backend = "s3"
    config = {
        bucket = local.remote_state_bucket
        region = local.remote_state_bucket_region
        key    = local.network_state_file
    }
}