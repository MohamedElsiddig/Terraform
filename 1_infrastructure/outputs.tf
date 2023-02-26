output "prefix" {
    value       = local.prefix
    description = "Exported common resources prefix"
}
output "common_tags" {
    value       = local.common_tags
    description = "Exported common resources tags"
}
output "vpc_id" {
    value       = module.vpc.vpc_id
    description = "VPC ID"
}

output "public_subnets" {
    value       = module.vpc.public_subnets
    description = "VPC public subnets' IDs list"
}
output "public_cidr" {
    value = module.vpc.private_subnets_cidr_blocks
}

output "private_subnets" {
    value       = module.vpc.private_subnets
    description = "VPC private subnets' IDs list"
}
output "private_cidr" {
    value = module.vpc.private_subnets_cidr_blocks
}

output "public_ip" {
    value = module.vpc.nat_public_ips
    description = "VPC Public IP"
}

output "db_subnets" {
    value = module.vpc.database_subnets
}

output "database_cidr" {
    value = module.vpc.database_subnets_cidr_blocks
}

output "public_route_table_id" {
    value = module.vpc.public_route_table_ids
}

output "private_route_table_id" {
    value = module.vpc.private_route_table_ids
}

output "databes_route_table_id" {
    value = module.vpc.database_route_table_ids
}

output "vpc_security_group_ids" {
    value = module.vpc.default_security_group_id
}
output "default_security_group_id" {
    value = module.vpc.default_security_group_id
}