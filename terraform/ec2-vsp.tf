resource "aws_instance" "verify_connect_vsp" {
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

  root_block_device {
    volume_size           = "50"
    delete_on_termination = "true"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "verify_connect_vsp"
  }
}
