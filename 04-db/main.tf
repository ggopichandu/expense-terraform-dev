# module "db" {
#   source = "terraform-aws-modules/rds/aws"

#   identifier = "/${var.project_name}/${var.environment}" #expense-dev

#   engine            = "mysql"
#   engine_version    = "8.0"
#   instance_class    = "db.t3.micro"
#   allocated_storage = 5

#   db_name  = "transactions" #default schema for expense project
#   username = "root"
#   port     = "3306"

#   vpc_security_group_ids = [data.aws_ssm_parameter.db_sg_id.value]



#   # DB subnet group
#   db_subnet_group_name = data.aws_ssm_parameter.db_subnet_group_name.value

#   # DB parameter group
#   family = "mysql8.0"

#   # DB option group
#   major_engine_version = "8.0"

#   tags = merge(
#     var.common_tags,
#     {
#         Name = "${var.project_name}/${var.environment}"
#     }
#   )
    
#   manage_master_user_password = false
#   password = "ExpenseApp1"
#   skip_final_snapshot = true   

#   parameters = [
#     {
#       name  = "character_set_client"
#       value = "utf8mb4"
#     },
#     {
#       name  = "character_set_server"
#       value = "utf8mb4"
#     }
#   ]

#   options = [
#     {
#       option_name = "MARIADB_AUDIT_PLUGIN"

#       option_settings = [
#         {
#           name  = "SERVER_AUDIT_EVENTS"
#           value = "CONNECT"
#         },
#         {
#           name  = "SERVER_AUDIT_FILE_ROTATIONS"
#           value = "37"
#         },
#       ]
#     }
#   ]
# }

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "/${var.project_name}/${var.environment}"

  engine            = "mysql"
  engine_version    = "8.0.40"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20

  db_name  = "transactions" #AWS will create this schema automatically
  username = "root"
  port     = "3306"
  password = "ExpenseApp1"
  manage_master_user_password = false
  skip_final_snapshot = true

  vpc_security_group_ids = [data.aws_ssm_parameter.db_sg_id.value]

  # DB subnet group
  create_db_subnet_group = false
  db_subnet_group_name = data.aws_ssm_parameter.db_subnet_group_name.value

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
   tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}/${var.environment}"
    }
   )
}


resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "mysql-${var.environment}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 1
  records = [module.db.db_instance_address]
}



