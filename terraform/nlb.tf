resource "aws_lb" "verify_connect_nlb" {
  name               = "verify-connect-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = ["${module.vpc.private_subnets}"]
}
