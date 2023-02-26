module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    name = var.vpc_name
    azs = [ "${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c" ]
    cidr = var.cidr_block["vpc_cidr"]

    public_subnets = [
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 101),
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 102),
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 103)
    ]
    public_subnet_names = ["Private-Public-A","Private-Public-B","Private-Public-C"]
    private_subnets = [
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 61),
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 62),
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 63),
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 71),
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 72),
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 73),
        
    ]
    private_subnet_names = ["Private-FE-A","Private-FE-B","Private-FE-C","Private-BE-A","Private-BE-B","Private-BE-C"]

    database_subnets = [
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 51),
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 52),
        cidrsubnet(var.cidr_block["vpc_cidr"], 8, 53),
    ]
    database_subnet_names = ["Private-DB-A","Private-DB-B","Private-DB-C"]

    enable_nat_gateway   = true
    single_nat_gateway   = true # when set to true it create single nat gatway + single route table but whe the variable enable_nat_gateway is disabled it create single route table only
    enable_dns_hostnames = true
    create_database_subnet_group           = true
    create_database_subnet_route_table     = true
    # map_public_ip_on_launch = false


}