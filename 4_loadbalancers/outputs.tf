output "fe_alb_security_group_id" {
    value = module.fe_alb_sg.security_group_id
}

output "fe_alb_dns_name" {
    value = aws_alb.this_fe.dns_name
}

output "fe_alb_arn" {
    value = aws_alb.this_fe.arn
}

output "fe_alb_dns_zone_id" {
    value = aws_alb.this_fe.zone_id
}


output "be_alb_security_group_id" {
    value = module.be_alb_sg.security_group_id
}

output "be_alb_dns_name" {
    value = aws_alb.this_be.dns_name
}

output "be_alb_arn" {
    value = aws_alb.this_be.arn
}

output "be_alb_dns_zone_id" {
    value = aws_alb.this_be.zone_id
}

output "fe_alb_ls_http" {
    value = aws_lb_listener.alb_fe_ls_http.arn
}

output "fe_alb_ls_https" {
    value = try(aws_lb_listener.alb_fe_ls_https.arn, "")
}

output "be_alb_ls_http" {
    value = aws_lb_listener.alb_be_ls_http.arn
}

output "be_alb_ls_https" {
    value = try(aws_lb_listener.alb_be_ls_https.arn, "")
}