resource "aws_lb" "verify_connect_msa_lb" {
  name               = "verify-connect-msa-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${module.verify_connect_sg.this_security_group_id}"]
  subnets            = ["${module.vpc.public_subnets}"]
}

resource "aws_lb_target_group" "msa" {
  name     = "msa"
  port     = 50210
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_lb_listener" "msa_listener" {
  load_balancer_arn = "${aws_lb.verify_connect_msa_lb.arn}"
  port              = "50210"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.msa.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group_attachment" "msa_service" {
  target_group_arn = "${aws_lb_target_group.msa.arn}"
  target_id        = "${aws_instance.verify_connect_msa.id}"
  port             = 50210
}
