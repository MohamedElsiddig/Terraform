locals {
    prefix = "Private-staging"
    common_tags = {
        Environment = "Staging"
        Provision = "Terraform"
    }
}