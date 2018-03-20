resource "aws_lb" "verify_connect_alb" {
  name               = "verify-connect-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${module.verify_connect_sg.this_security_group_id}"]
  subnets            = ["${module.vpc.public_subnets}"]
}

resource "aws_lb_target_group" "VSP" {
  name     = "vsp"
  port     = 50400
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_alb_listener" "vsp_listener" {
  load_balancer_arn = "${aws_lb.verify_connect_alb.arn}"
  port              = "50400"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.VSP.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "MSA" {
  name     = "msa"
  port     = 50210
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_alb_listener" "msa_listener" {
  load_balancer_arn = "${aws_lb.verify_connect_alb.arn}"
  port              = "50210"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.MSA.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "LMS" {
  name     = "lms"
  port     = 50500
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_alb_listener" "lms_listener" {
  load_balancer_arn = "${aws_lb.verify_connect_alb.arn}"
  port              = "50500"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.VSP.arn}"
    type             = "forward"
  }
}

resource "aws_lb_target_group" "APP" {
  name     = "APP"
  port     = 3200
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_alb_listener" "app_listener" {
  load_balancer_arn = "${aws_lb.verify_connect_alb.arn}"
  port              = "3200"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.APP.arn}"
    type             = "forward"
  }
}
