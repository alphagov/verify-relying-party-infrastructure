module "verify_connect_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "verify-connect-service"
  description = "Security group for verify connect environment"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "213.86.153.245/32,10.0.0.0/16"
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "verify-connect-service ports (ipv4)"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}
