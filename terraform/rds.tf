module "verify-connect-db" {
  source             = "terraform-aws-modules/rds/aws"
  identifier         = "verify-connect-db"
  engine             = "postgres"
  engine_version     = "9.6.6"
  instance_class     = "db.t2.small"
  allocated_storage  = 50
  storage_encrypted  = false
  port               = "5432"
  username           = "${var.dbuser}"
  password           = "${var.dbpass}"
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  subnet_ids             = ["${module.vpc.private_subnets}"]
  vpc_security_group_ids = ["${module.verify_connect_sg.this_security_group_id}"]
  family                 = "postgres9.6"
}
