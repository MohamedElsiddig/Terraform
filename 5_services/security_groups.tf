locals {
    alb_security_group_id =  (var.lb_type == "frontend" ? data.terraform_remote_state.alb.outputs.fe_alb_security_group_id : data.terraform_remote_state.alb.outputs.be_alb_security_group_id)
}

resource "aws_security_group" "this_sg" {
    name        = "${local.prefix}-SG"
    description = "Allow inbound traffic for port ${var.app_ports} + ssh connection"
    vpc_id      = local.vpc_id

    dynamic "ingress" {
        for_each = var.inbound_rules
        content {
            description = ingress.value.description
            from_port   = ingress.value.from_port
            to_port     = ingress.value.to_port
            protocol    = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
            ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks 
            security_groups = ingress.value.security_groups
        }
    }

    dynamic "egress" {
        for_each = var.outbound_rules
        content {
            description = egress.value.description
            from_port   = egress.value.from_port
            to_port     = egress.value.to_port
            protocol    = egress.value.protocol
            cidr_blocks = egress.value.cidr_blocks
            ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
            security_groups = egress.value.security_groups
        }
    }
    tags = merge({
        Name = "${local.prefix}-SG"
    },
    local.common_tags
    )
}