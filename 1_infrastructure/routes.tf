resource "aws_route" "this_public" {
  count = length(local.public_routes)
    route_table_id = module.vpc.public_route_table_ids[0]
    destination_cidr_block = local.public_routes[count.index].destination_cidr_block 
    gateway_id = "igw-05d414242100c54ec"
}
output "route_tables_ids" {
  value = module.vpc.public_route_table_ids
}