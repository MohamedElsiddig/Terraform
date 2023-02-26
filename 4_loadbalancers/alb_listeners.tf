###############################################################################
# Frontend ALB Listeners
###############################################################################
resource "aws_lb_listener" "alb_fe_ls_http" {
    load_balancer_arn = aws_alb.this_fe.arn
    port              = 80
    protocol          = "HTTP"
    default_action {
        type = "redirect"

        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
            }
        }
}



resource "aws_lb_listener" "alb_fe_ls_https" {
    load_balancer_arn = aws_alb.this_fe.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = aws_acm_certificate.cert.arn

    default_action {
        type = "fixed-response"
        fixed_response {
        content_type = "text/plain"
        message_body = "Not Found"
        status_code  = "404"
        }
    }
}



###############################################################################
# Backend ALB Listeners
###############################################################################

resource "aws_lb_listener" "alb_be_ls_http" {
    load_balancer_arn = aws_alb.this_be.arn
    port              = 80
    protocol          = "HTTP"
    default_action {
        type = "fixed-response"
        fixed_response {
        content_type = "text/plain"
        message_body = "Not Found"
        status_code  = "404"
        }
    }
}



resource "aws_lb_listener" "alb_be_ls_https" {
    load_balancer_arn = aws_alb.this_be.arn
    port              = 443
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = aws_acm_certificate.cert.arn

    default_action {
        type = "fixed-response"
        fixed_response {
        content_type = "text/plain"
        message_body = "Not Found"
        status_code  = "404"
        }
    }
}