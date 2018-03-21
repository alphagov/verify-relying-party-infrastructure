resource "aws_lb" "verify_connect_vsp_lb" {
  name               = "verify-connect-vsp-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${module.verify_connect_sg.this_security_group_id}"]
  subnets            = ["${module.vpc.public_subnets}"]
}

resource "aws_lb_target_group" "vsp" {
  name     = "vsp"
  port     = 50400
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_alb_listener" "vsp_listener" {
  load_balancer_arn = "${aws_lb.verify_connect_vsp_lb.arn}"
  port              = "50400"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.vsp.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group_attachment" "vsp_service" {
  target_group_arn = "${aws_lb_target_group.vsp.arn}"
  target_id        = "${aws_instance.verify_connect_vsp.id}"
  port             = 50400
}

