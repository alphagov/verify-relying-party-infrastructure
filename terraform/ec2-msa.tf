resource "aws_instance" "verify_connect_msa" {
  ami                         = "ami-3fc8d75b"
  instance_type               = "t2.small"
  key_name                    = "default"
  monitoring                  = false
  vpc_security_group_ids      = ["${module.verify_connect_sg.this_security_group_id}"]
  subnet_id                   = "${module.vpc.private_subnets[0]}"
  disable_api_termination     = false
  associate_public_ip_address = false
  source_dest_check           = false
  user_data                   = "${file("msa/msa-user-data.sh")}"

  provisioner "file" {
    source      = "msa/verify-matching-service-adapter.conf"
    destination = "/home/ubuntu/verify-matching-service-adapter.conf"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      bastion_host = "35.177.196.23"
      bastion_user = "ubuntu"
    }
  }

  provisioner "file" {
    source      = "msa/config.yml"
    destination = "/home/ubuntu/config.yml"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      bastion_host = "35.177.196.23"
      bastion_user = "ubuntu"
    }
  }

  provisioner "file" {
    source      = "msa/msa.env"
    destination = "/home/ubuntu/msa.env"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      bastion_host = "35.177.196.23"
      bastion_user = "ubuntu"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "verify_connect_msa"
  }
}
