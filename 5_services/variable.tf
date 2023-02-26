variable "prefix_name" {
    description = "This Variable will be assigned to all resoures names"
    type = string
    default = ""
}
variable "aws_region" {
    default     =  "eu-west-3"
}

variable "remote_bucket" {
    type = string
    default = "terraform-tfstate"
}
variable "network_tfstate" {
    type = string
    default = "network.tfstate"
}

variable "alb_tfstate" {
    type = string
    default = "alb.tfstate"
}

variable "s3_tfstate" {
    type = string
    default = "s3_storage.tfstate"
}

#####################################################
#  S3 bucket name for IAM instance role
#####################################################
variable "bucket_name" {
    description = "S3 bucket name for IAM instance role"
    type = string
    default = ""
}

#####################################################
# Launch Template  + Auto Scaling Group Settings
#####################################################
variable "tomcat_image" {
    description = "Choose between different tomcat versions -- this value will be refrenced on launch template and it will use AMIS map variable to choose AMI"
    type = string
    default = ""

}
variable "AMIS" {
    type = map(string)
    default = {
        ami1   = "ami-hash"
        ami1   = "ami-hash"
        }
}

variable "key_name" {
    description = "SSH Key name to be used on the instance"
    type = string
    default = ""
}
variable "ec2_instance_type" {
    type = string
    default  = ""

}

variable "min_instance" {
    description = "Minimum instances for ASG + will be used for desired instance"
    type = string
    default = ""
}

variable "max_instance" {
    description = "Maximum instances for ASG + will be used for desired instance"
    type = string
    default = ""
}
variable "instance_volume_size" {
    description = "Instance volume size in GB"
    type = string
    default = ""
}

variable "launch_template_version" {
    description = "Launch template version acceptable values [$latest, $Default, number]"
    type = string
    default = ""
}
variable "subnet_key" {
    # 0,1,2 are for [21,22,23] FE subnets -------- 3,4,5 are for [31,32,33] BE subnets 
    description = "In which subnet Auto Scaling Group will be created  0,1,2 are for [21,22,23] FE subnets ---- 3,4,5 are for [31,32,33] BE subnets"
    type = list(number)
    default = []
    # default = [ 3,4,5 ]
}

variable "app_ports" {
    description = "This variable is for the listening port for the application,,,, will be used on Target Group"
    type = number
}
variable "health_check" {
    description = "Health check values for Target Group"
    type = map(any)
    default = {}
}
variable "lb_type" {
    type = string 
	description = "Which load balancer the target group will be associated with"
    # change it to backedn if you want to use backend load balancer for this resource
    # default = "frontend" 
    # default = "backend"
}

variable "domain_prefix" {
    description = "Prefix of domain name for host_header condition in ALB ex: app will produce app.example.com"
    type = string

}

variable "lb_listener" {
    type = bool
    default = true
}


variable "http_listener_rules" {
    type = any
    default = []
}


####################################################################
# Dynamic ingress rules for Security Groups
####################################################################

variable "inbound_rules" {
    type = list(object({
        description = string
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
        ipv6_cidr_blocks = list(string)
        security_groups = list(string)
    }))
}

variable "outbound_rules" {
    type = list(object({
        description = string
        from_port = number
        to_port = number
        protocol = string
        cidr_blocks = list(string)
        ipv6_cidr_blocks = list(string)
        security_groups = list(string)
    }))
}
