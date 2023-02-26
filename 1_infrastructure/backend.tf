terraform {
    backend "s3" {
        bucket  = "terrafrom-tfstate"
        key     = "network.tfstate"
        region  = "eu-west-3"
        encrypt = "true"
        # dynamodb_table = "hands-on-cloud-terraform-remote-state-dynamodb"
    }
}