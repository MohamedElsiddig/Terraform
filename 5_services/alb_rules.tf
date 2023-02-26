locals {

    alb_listner   = (var.lb_type == "frontend" ? data.terraform_remote_state.alb.outputs.fe_alb_ls_https : data.terraform_remote_state.alb.outputs.be_alb_ls_http)

}

resource "aws_lb_listener_rule" "host_based_routing" {
    count = length(var.http_listener_rules)
    listener_arn = local.alb_listner
    priority     = lookup(var.http_listener_rules[count.index], "priority", null)



#########################################################################
# Action redirect with host header + path patterns
#########################################################################
    dynamic "action" {
        for_each = [
        for action_rule in var.http_listener_rules[count.index].actions :
        action_rule
        if action_rule.type == "redirect"
        ]
        content {
        type = action.value["type"]
        redirect {
            host        = lookup(action.value, "host", null)
            path        = lookup(action.value, "path", null)
            port        = lookup(action.value, "port", null)
            protocol    = lookup(action.value, "protocol", null)
            query       = lookup(action.value, "query", null)
            status_code = action.value["status_code"]
        }
        }
    }
    dynamic "condition" {
        for_each = [
        for condition_rule in var.http_listener_rules[count.index].conditions :
        condition_rule
        if length(lookup(condition_rule, "host_headers", [])) > 0
        ]

        content {
        host_header {
            values = condition.value["host_headers"]
        }
        }
    }
    dynamic "condition" {
        for_each = [
            for condition_rule in var.http_listener_rules[count.index].conditions :
            condition_rule
            if length(lookup(condition_rule, "path_patterns", [])) > 0
        ]
        content {
            path_pattern {
                values = condition.value["path_patterns"]
            }
        }
    }
#########################################################################
# Actions forward with host header + path patterns
#########################################################################
    dynamic "action" {
        for_each = [
        for action_rule in var.http_listener_rules[count.index].actions :
        action_rule
        if action_rule.type == "forward"
        ]
        content {
        type = action.value["type"]

            target_group_arn = aws_lb_target_group.this_tg.arn
        }
    }
    dynamic "condition" {
        for_each = [
            for condition_rule in var.http_listener_rules[count.index].conditions : condition_rule
            if length(lookup(condition_rule, "host_headers", [])) > 0
        ]

        content {
            host_header {
                values = condition.value["host_headers"]
            }
        }
    }
        dynamic "condition" {
        for_each = [
            for condition_rule in var.http_listener_rules[count.index].conditions :
            condition_rule
            if length(lookup(condition_rule, "path_patterns", [])) > 0
        ]
        content {
            path_pattern {
                values = condition.value["path_patterns"]
            }
        }
    }
#########################################################################
# Action fixed-response with path patterns
#########################################################################
    dynamic "action" {
        for_each = [
        for action_rule in var.http_listener_rules[count.index].actions :
        action_rule
        if action_rule.type == "fixed-response"
        ]

        content {
        type = action.value["type"]
        fixed_response {
            message_body = lookup(action.value, "message_body", null)
            status_code  = lookup(action.value, "status_code", null)
            content_type = action.value["content_type"]
        }
        }
    }
        dynamic "condition" {
        for_each = [
            for condition_rule in var.http_listener_rules[count.index].conditions :
            condition_rule
            if length(lookup(condition_rule, "path_patterns", [])) > 0
        ]
        content {
            path_pattern {
                values = condition.value["path_patterns"]
            }
        }
    }
    
}
