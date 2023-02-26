locals {
    remote_state_bucket_region    = var.aws_region
    remote_state_bucket           = var.remote_bucket
    network_state_file            = var.network_tfstate

    prefix          = data.terraform_remote_state.network.outputs.prefix
    common_tags     = data.terraform_remote_state.network.outputs.common_tags
}



data "terraform_remote_state" "network" {
    backend = "s3"
    config = {
        bucket = local.remote_state_bucket
        region = local.remote_state_bucket_region
        key    = local.network_state_file
    }
}