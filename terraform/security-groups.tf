module "verify_connect_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "verify-connect-service"
  description = "Security group for verify connect environment"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "213.86.153.212/32,213.86.153.213/32,213.86.153.214/32,213.86.153.235/32,213.86.153.236/32,213.86.153.237/32,85.133.67.244/32"
    },
    {
      from_port   = 3200
      to_port     = 3200
      protocol    = "tcp"
      description = "Node app"
      cidr_blocks = "213.86.153.212/32,213.86.153.213/32,213.86.153.214/32,213.86.153.235/32,213.86.153.236/32,213.86.153.237/32,85.133.67.244/32"
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
    {
      from_port   = 3200
      to_port     = 32000
      protocol    = "-1"
      description = "compliance tool (ipv4)"
      cidr_blocks = "37.26.93.213/32"
    },
  ]
}
