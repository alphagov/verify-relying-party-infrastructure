resource "aws_instance" "verify_connect_app" {
  ami                         = "ami-f4f21593"
  instance_type               = "t2.small"
  key_name                    = "default"
  monitoring                  = false
  vpc_security_group_ids      = ["${module.verify_connect_sg.this_security_group_id}"]
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  disable_api_termination     = false
  source_dest_check           = false
  associate_public_ip_address = true
  user_data                   = "${file("containers/cloud-init.yaml")}"

  root_block_device {
    volume_size           = "50"
    delete_on_termination = "true"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "verify_containers"
  }
}