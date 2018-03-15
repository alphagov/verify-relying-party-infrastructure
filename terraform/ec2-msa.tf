module "verify_connect_msa" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "verify_connect_msa"

  ami                         = "ami-3fc8d75b"
  instance_type               = "t2.small"
  key_name                    = "default"
  monitoring                  = false
  vpc_security_group_ids      = ["${module.verify_connect_sg.this_security_group_id}"]
  subnet_id                   = "${module.vpc.private_subnets[0]}"
  disable_api_termination     = false
  associate_public_ip_address = false
  source_dest_check           = false
  user_data                   = "${file("user-data.sh")}"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
