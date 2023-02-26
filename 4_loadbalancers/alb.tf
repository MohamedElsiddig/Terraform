
module "fe_alb_sg" {
    source = "terraform-aws-modules/security-group/aws"

    name        = "${local.prefix}-FE-ALB-SG"
    description = "Security group for FE ALB"
    vpc_id      = local.vpc_id
    ingress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules = ["all-all"]
    ingress_rules  = ["https-443-tcp","http-80-tcp","all-icmp"]
    tags = merge({
        Name = "${local.prefix}-FE-ALB-SG"
    },
    local.common_tags
    )

}

module "be_alb_sg" {
    source = "terraform-aws-modules/security-group/aws"

    name        = "${local.prefix}-BE-ALB-SG"
    description = "Security group for BE ALB"
    vpc_id      = local.vpc_id
    ingress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules = ["all-all"]
    ingress_rules  = ["https-443-tcp","http-80-tcp"]
    tags = merge({
        Name = "${local.prefix}-BE-ALB-SG"
    },
    local.common_tags
    )
}



resource "aws_alb" "this_fe" {
    name = "${local.prefix}-FE-ALB"
    load_balancer_type = "application"
    subnets = local.public_subnets
    security_groups = [module.fe_alb_sg.security_group_id]
    tags = merge({
        Name = "${local.prefix}-FE-ALB"
    },
    local.common_tags
    )

}

resource "aws_alb" "this_be" {

    name = "${local.prefix}-BE-ALB"
    load_balancer_type = "application"
    subnets = ["${local.private_subnets[3]}","${local.private_subnets[4]}","${local.private_subnets[5]}"]  #
    security_groups = [module.be_alb_sg.security_group_id]
    tags = merge({
        Name = "${local.prefix}-BE-ALB"
    },
    local.common_tags
    )
    
}