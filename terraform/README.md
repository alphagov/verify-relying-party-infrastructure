Terraform
=========

[Terraform](https://www.terraform.io/) is an infrastructure as code tool which
can build infrastructure in the cloud.

This directory contains terraform configuration which creates an environment in
Amazon Web Services. The environment hosts a service which connects to the
GOV.UK Verify Integration environment.

Getting Started
---------------

Set up your aws creds by following the instructions in https://github.com/alphagov/verify-terraform#assuming-roles, then:

```
cd terraform

# To see what terraform thinks it should do:
terraform plan

# To have terraform set up the environment:
terraform apply
```

