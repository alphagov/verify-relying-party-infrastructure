module "verify_connect_db" {
  source     = "terraform-aws-modules/rds/aws"
  identifier = "verify_connect_db"

  engine             = "postgres"
  engine_version     = "9.6.3"
  instance_class     = "db.t2.micro"
  allocated_storage  = 20
  storage_encrypted  = false
  port               = "5432"
  username           = "${var.dbuser}"
  password           = "${var.dbpass}"
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  subnet_ids = ["${module.vpc.private_subnets}"]
  family     = "postgres9.6"
}
