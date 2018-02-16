Verify Relying Party Infrastucture
==================================

Infrastructure as code describing an environment that connects to GOV.UK Verify
in the same way a government service would.

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

Documentation
-------------

See [docs/adr](docs/adr) for the architectural decisions we've made.

