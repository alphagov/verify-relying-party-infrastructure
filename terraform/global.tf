terraform {
  backend "s3" {
    bucket  = "connect-to-verify-aws-tfstate"
    key     = "terraform.tfstate"
    encrypt = true
    region  = "eu-west-2"
  }
}

provider "aws" {
  region  = "eu-west-2"
  profile = "ctv"
}
