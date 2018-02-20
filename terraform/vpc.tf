module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "verify-connect-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  private_subnets = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  public_subnets  = ["10.0.102.0/24", "10.0.103.0/24", "10.0.104.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false
  external_nat_ip_ids = [""]


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
