
variable "aws_region" {
  default     =  "eu-west-3"
  description = "AWS Region to deploy VPC"
}

variable "cidr_block" {
  description = "CIDR block for EC2"
  type  = map(string)
  default = { 
    vpc_cidr = "10.101.0.0/16"
  }
}

variable "vpc_name" {
  type = string
  default = "Private-staging"
}

