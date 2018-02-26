resource "aws_lb" "verify_connect_alb" {
  name               = "verify-connect-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${module.verify_connect_sg.this_security_group_id}"]
  subnets            = ["${module.vpc.public_subnets}"]
}
