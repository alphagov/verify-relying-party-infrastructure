module "pubinstance1" { # TODO rename this
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "pubrpdev1" # TODO rename this

  ami                         = "ami-3fc8d75b"
  instance_type               = "t2.micro"
  key_name                    = "default"
  monitoring                  = false
  vpc_security_group_ids      = ["${module.verify_connect_sg.this_security_group_id}"]
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  disable_api_termination     = false
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}