# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = "${module.vpc.vpc_id}"
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = ["${module.vpc.private_subnets}"]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${module.vpc.public_subnets}"]
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = ["${module.vpc.nat_public_ips}"]
}

output "this_security_group_id" {
  description = "The ID of the security group"
  value       = "${module.verify_connect_sg.this_security_group_id}"
}

output "this_security_group_vpc_id" {
  description = "The VPC ID"
  value       = "${module.verify_connect_sg.this_security_group_vpc_id}"
}

output "this_security_group_owner_id" {
  description = "The owner ID"
  value       = "${module.verify_connect_sg.this_security_group_owner_id}"
}

output "this_security_group_name" {
  description = "The name of the security group"
  value       = "${module.verify_connect_sg.this_security_group_name}"
}

output "this_security_group_description" {
  description = "The description of the security group"
  value       = "${module.verify_connect_sg.this_security_group_description}"
}

output "relying_party_ip" {
  description = "The IP address of relying party front-end"
  value       = ["${aws_instance.verify_connect_app.public_ip}"]
}
