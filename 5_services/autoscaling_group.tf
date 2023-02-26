resource "aws_autoscaling_group" "this_asg" {
    name = "${local.prefix}-ASG"
    min_size         = var.min_instance
    desired_capacity = var.min_instance
    max_size         = var.max_instance

    health_check_type = "ELB"

    target_group_arns    = [aws_lb_target_group.this_tg.arn]
    launch_template {
        name = aws_launch_template.this_lt.name
        version = var.launch_template_version
    }
    instance_refresh {
        strategy = "Rolling"
            preferences {
            min_healthy_percentage = 50
            }
            # triggers = ["tag"]
    }
    
    metrics_granularity = "1Minute"
    # vpc_zone_identifier = ["${local.private_subnets[0]}","${local.private_subnets[1]}","${local.private_subnets[2]}"]
    vpc_zone_identifier = ["${local.private_subnets[var.subnet_key[0]]}","${local.private_subnets[var.subnet_key[1]]}","${local.private_subnets[var.subnet_key[2]]}"]

    # Required to redeploy without an outage.
    lifecycle {
        create_before_destroy = true
    }

    tag {
        key                 = "Name"
        value               = "${local.prefix}"
        propagate_at_launch = true
    }

}