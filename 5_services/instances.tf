# resource "aws_instance" "this" {
#     ami  = var.AMIS["tomcat8"]
#     instance_type = "t2.micro"
# #   Commetning this out as it been used by network_interface
#     subnet_id = local.private_subnets[count.index]
#     vpc_security_group_ids = [aws_security_group.this_sg.id]
#     count = 2
#     key_name = "keyname"
#     iam_instance_profile = aws_iam_instance_profile.this_isp.name
#     root_block_device {
#         volume_size = 20
#     }
#     tags = merge({
#         "Name" = "${local.prefix}-${count.index + 1}"
#     },
#     local.common_tags
#     )
# }