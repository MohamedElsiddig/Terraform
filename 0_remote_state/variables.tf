variable "aws_region" {
    default     =  "eu-west-3"
    description = "AWS Region to deploy S3 Remote state"
}

variable "remote_bucket" {
    type = string
    default = "terraform-tfstate"
}