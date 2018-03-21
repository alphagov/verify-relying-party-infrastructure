resource "aws_lb" "verify_connect_app_lb" {
  name               = "verify-connect-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${module.verify_connect_sg.this_security_group_id}"]
  subnets            = ["${module.vpc.public_subnets}"]
}

resource "aws_lb_target_group" "app" {
  name     = "app"
  port     = 3200
  protocol = "HTTP"
  vpc_id   = "${module.vpc.vpc_id}"
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = "${aws_lb.verify_connect_app_lb.arn}"
  port              = "3200"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.app.arn}"
    type             = "forward"
  }
}

resource "aws_alb_target_group_attachment" "app_service" {
  target_group_arn = "${aws_lb_target_group.app.arn}"
  target_id        = "${aws_instance.verify_connect_app.id}"
  port             = 3200
}

