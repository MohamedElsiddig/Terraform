locals {

    alb_security_group_id =  (var.lb_type == "frontend" ? data.terraform_remote_state.alb.outputs.fe_alb_security_group_id : data.terraform_remote_state.alb.outputs.be_alb_security_group_id)

}
module "superapp" {
    source = "../../5_services"
    prefix_name = var.prefix_name
    subnet_key = var.subnet_key
    lb_type = var.lb_type
    inbound_rules = [
        {
            description = "allow ssh"
            from_port        = 22
            to_port          = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            security_groups = []
        
    },        
    {
            description = "allow 3000"
            from_port        = 3000
            to_port          = 3000
            protocol = "tcp"
            cidr_blocks = []
            ipv6_cidr_blocks = []
            security_groups = [local.alb_security_group_id]
        
    },
    ]
    outbound_rules = [ {
        description      = "Allow all outbound traffic"
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        security_groups = []
    } 
    ]

    ec2_instance_type = var.ec2_instance_type
    key_name = var.key_name
    tomcat_image = var.tomcat_image
    instance_volume_size = var.instance_volume_size
    bucket_name = var.bucket_name
    domain_prefix = var.domain_prefix
    min_instance = var.min_instance
    max_instance = var.max_instance
    launch_template_version = var.launch_template_version
    app_ports = var.app_ports
    health_check = {
        healthy_threshold   = var.health_check["healthy_threshold"]
        unhealthy_threshold = var.health_check["unhealthy_threshold"]
        timeout             = var.health_check["timeout"]
        interval            = var.health_check["interval"]
        path                = var.health_check["path"]
        matcher             = var.health_check["matcher"] 
    }
    http_listener_rules = [ 
        {
            priority = 100
            actions = [{
                type        = "forward"
            }]
            conditions = [{
                host_headers = ["${var.domain_prefix}.example.com"]
                path_patterns = ["/some_path/","/"]
            }]
        },

    ]
}

