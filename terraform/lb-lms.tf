resource "aws_lb" "verify_connect_lms_lb" {
  name               = "verify-connect-lms-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${module.verify_connect_sg.this_security_group_id}"]
  subnets            = ["${module.vpc.public_subnets}"]
}

resource "aws_lb_target_group" "lms" {
  name     = "lms"
  port     = 50500
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_lb_listener" "lms_listener" {
  load_balancer_arn = "${aws_lb.verify_connect_lms_lb.arn}"
  port              = "50500"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.lms.arn}"
    type             = "forward"
  }
}

#resource "aws_alb_target_group_attachment" "svc_physical_external" {
#  target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
#  target_id        = "${aws_instance.svc.id}"
#  port             = 50400
#}

