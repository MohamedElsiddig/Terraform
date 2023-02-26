resource "aws_lb_target_group" "this_tg" {
    name     = "${local.prefix}-TG"
    port     = var.app_ports
    protocol = "HTTP"
    target_type  = "instance"
    vpc_id   = local.vpc_id

    health_check {
        healthy_threshold   = var.health_check["healthy_threshold"]
        unhealthy_threshold = var.health_check["unhealthy_threshold"]
        timeout             = var.health_check["timeout"]
        interval            = var.health_check["interval"]
        path                = var.health_check["path"]
        matcher             = var.health_check["matcher"] 
        
    }
}

# resource "aws_lb_target_group_attachment" "this_tga" {
#     count = length(aws_instance.this)
#     target_group_arn = aws_lb_target_group.this_tg.arn
#     target_id        = aws_instance.this[count.index].id
#     port             = 8080
# }