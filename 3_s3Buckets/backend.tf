terraform {
    backend "s3" {
        bucket  = "stage-tfstate"
        key     = "s3_storage.tfstate"
        region  = "eu-west-3"
        encrypt = "true"
        # dynamodb_table = "hands-on-cloud-terraform-remote-state-dynamodb"
    }
}