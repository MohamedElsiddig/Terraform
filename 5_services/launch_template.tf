resource "aws_launch_template" "this_lt" {
    name = "${local.prefix}-launch-template"
    image_id = var.AMIS[var.tomcat_image]
    instance_type = var.ec2_instance_type
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.this_sg.id]
    iam_instance_profile {
        name = aws_iam_instance_profile.this_isp.name
    }   

    lifecycle {
        create_before_destroy = true
    }
    block_device_mappings{
        device_name = "/dev/sda1"
        ebs {
            volume_size = var.instance_volume_size
        }
    }
    user_data = base64encode(templatefile("./settings.sh", {bucket_name = local.s3_bucket , hostname = var.prefix_name ,tomcat_version = var.tomcat_image }))
    tags = merge({
        "Name" = "${local.prefix}-launch-template"
    },
    local.common_tags
    )

}

