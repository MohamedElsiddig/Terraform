variable "aws_region" {
    default     =  "eu-west-3"
    description = "AWS Region to deploy S3 Buckets"
}

variable "remote_bucket" {
    type = string
    default = "terrform-tfstate"
}

variable "network_tfstate" {
    type = string
    default = "network.tfstate"
}

variable "bucket_name" {
    type = map(string)
    default = {
        bucket1 = "bucket1"
        bucket2 = "bucket2"
        bucket3 = "bucket3"
        bucket4 = "bucket4"

    }
}