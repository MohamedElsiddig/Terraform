terraform {
    backend "s3" {
        bucket  = "terraform-tfstate"
        key     = "alb.tfstate"
        region  = "eu-west-3"
        encrypt = "true"
        # dynamodb_table = "hands-on-cloud-terraform-remote-state-dynamodb"
    }
}