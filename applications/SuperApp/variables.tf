variable "prefix_name" {
    description = "This Variable will be assigned to all resoures names"
    type = string
    default = "SuperApp"
}
variable "aws_region" {
    default     =  "eu-west-3"
}

variable "remote_bucket" {
    type = string
    default = "terraform-tfstate"
}

variable "alb_tfstate" {
    type = string
    default = "alb.tfstate"
}


#####################################################
#  S3 bucket name for IAM instance role (bucket key)
#####################################################
variable "bucket_name" {
    description = "S3 bucket key name for IAM instance role ,,refer to 3_s3 outputs to get the right key for every app"
    type = string
    default = "bucket1"
}

#####################################################
# Launch Template  + Auto Scaling Group Settings
#####################################################
variable "tomcat_image" {
    description = "Choose between different tomcat versions -- this value will be refrenced on launch template and it will use AMIS map variable to choose AMI"
    type = string
    default = "tomcat8"
    # default = "tomcat9"
}
variable "AMIS" {
    type = map(string)
    default = {
        tomcat8   = "ami-0174f7b76e6cc9057"
        tomcat9   = "ami-00da2cae66c62e379"
        }
}

variable "key_name" {
    description = "SSH Key name to be used on the instance"
    type = string
    default = "some_key"
}
variable "ec2_instance_type" {
    type = string
    default  = "t2.micro"
}

variable "min_instance" {
    description = "Minimum instances for ASG + will be used for desired instance"
    type = string
    default = "2"
}

variable "max_instance" {
    description = "Maximum instances for ASG + will be used for desired instance"
    type = string
    default = "2"
}
variable "instance_volume_size" {
    description = "Instance volume size in GB"
    type = string
    default = "20"
}

variable "launch_template_version" {
    description = "Launch template version acceptable values [$latest, $Default, number]"
    type = string
    default = "$Latest"
}
variable "subnet_key" {
    # 0,1,2 are for [21,22,23] FE subnets -------- 3,4,5 are for [31,32,33] BE subnets 
    description = "In which subnet Auto Scaling Group will be created  0,1,2 are for [21,22,23] FE subnets ---- 3,4,5 are for [31,32,33] BE subnets"
    type = list(number)
    default = [ 0,1,2 ]
    # default = [ 3,4,5 ]
}

variable "app_ports" {
    description = "This variable is for the listening port for the application,,,, will be used on Target Group"
    type = number
    default = 8080
}
variable "health_check" {
    description = "Health check values for Target Group"
    type = map(any)
    default = {
        "healthy_threshold"    = 5
        "unhealthy_threshold"  = 2
        "timeout"              = 5
        "interval"             = 30
        "path"                 = "/"
        "matcher"              = "200"
    }
}
variable "lb_type" {
    type = string 
	description = "Which load balancer the target group will be associated with"
    # change it to backedn if you want to use backend load balancer for this resource
    default = "frontend" 
    # default = "backend"
}

variable "domain_prefix" {
    description = "Prefix of domain name for host_header condition in ALB ex: app will produce app.example.com"
    type = string
    default = "app"
}

variable "lb_listener" {
    type = bool
    default = true
}
