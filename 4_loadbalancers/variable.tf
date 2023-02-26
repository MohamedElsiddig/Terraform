variable "aws_region" {
    default     =  "eu-west-3"
    description = "AWS Region to deploy ALB"
}

variable "remote_bucket" {
    type = string
    default = "terraform-tfstate"
}
variable "network_tfstate" {
    type = string
    default = "network.tfstate"
}