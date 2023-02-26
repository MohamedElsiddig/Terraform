module "rds" {
    source  = "terraform-aws-modules/rds/aws"
    identifier = "${local.prefix}-db"
    # multi_az = true
    # instance_class  = "db.m5.large"
    instance_class  = "db.t3.medium"
    engine            = "mysql"
    engine_version    = "5.7.38"
    # storage_type = "io1"
    # iops = 5000
    allocated_storage = 150
    create_random_password = false
    apply_immediately = true
    db_name  = "some_name"
    password = "StrongPassword"
    username = "admin"
    port     = "3306"
    skip_final_snapshot = true
    vpc_security_group_ids = [module.db_security_group.security_group_id]
    create_db_subnet_group = true
    # db_subnet_group_name = "${local.prefix}-db"
    subnet_ids             = ["${local.db_subnets[0]}","${local.db_subnets[1]}","${local.db_subnets[2]}"]
    # DB parameter group
    family = "mysql5.7"
    parameter_group_name    = "${local.prefix}-db"
    parameter_group_use_name_prefix = false
    parameters = [
    {
        name = "character_set_client"
        value = "utf8mb4"
        apply_method = "pending-reboot"
    },
    {
        name = "character_set_server"
        value = "utf8"
        apply_method = "pending-reboot"
    },
    {
        name = "character-set-client-handshake"	 
        value = "1"
        apply_method = "pending-reboot"
    },
    {
        name = "character_set_connection"
        value = "utf8"
        apply_method = "pending-reboot"
    },
    {
        name = "character_set_filesystem"
        value = "binary"
        apply_method = "pending-reboot"
    },
    {
        name = "character_set_results"
        value = "utf8mb4"
        apply_method = "pending-reboot"
    },
    {
        name = "collation_connection"
        value = "utf8mb4_general_ci"
        apply_method = "pending-reboot"
    },
    {
        name = "collation_server"
        value = "utf8_general_ci"
        apply_method = "pending-reboot"
    },
    {
        name = "init_connect"
        value = "SET collation_connection = utf8mb4_unicode_ci"
        apply_method = "pending-reboot"
    },
    {
        name = "log_bin_trust_function_creators"
        value = "1"
        apply_method = "pending-reboot"
    },
    {
        name = "skip-character-set-client-handshake"
        value = "0"
        apply_method = "pending-reboot"
    },
    {
        name = "time_zone"
        value = "Africa/Harare"
    }
    
    ]
    # DB option group
    major_engine_version = "5.7"
    option_group_name    = "${local.prefix}-db"
    option_group_use_name_prefix = false
    options = [
        {
        option_name = "MARIADB_AUDIT_PLUGIN"

        option_settings = [
            
            # {
            # name  = "SERVER_AUDIT"
            # value = "FORCE_PLUS_PERMANENT"
            # },
            {
            name  = "SERVER_AUDIT_EVENTS"
            value = "CONNECT,QUERY"
            },
            # {
            # name  = "SERVER_AUDIT_FILE_PATH"
            # value = "/rdsdbdata/log/audit/"
            # },
        ]
        },
    ]
    tags = merge(
        {
    Name = "${local.prefix}-DB"
    },
    local.common_tags
    )


}

module "db_security_group" {
    source = "terraform-aws-modules/security-group/aws"

    name        = "${local.prefix}-DB-SG"
    description = "Security group for Staging Database"
    vpc_id      = local.vpc_id
    ingress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules = ["all-all"]
    ingress_rules  = ["mysql-tcp"]
    tags = merge(
    {
        Name = "${local.prefix}-DB-SG"
    },
    local.common_tags
    )
}