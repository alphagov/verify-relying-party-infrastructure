Vagrant
=======

[Vagrant](https://vagrant.io) is a tool for managing virtual machines.

This directory contains vagrant configuration which creates an environment
which runs all the services needed to connect to GOV.UK Verify.

:warning: This is provided for informational purposes only and is not a good example
of how to run a service in production. :warning:

Getting Started
---------------

- Install vagrant and postgres
- Ensure postgres is running on port 5432 (the default)
- From this directory run `vagrant up`

This will download and provision four ubuntu virtual machines:

- `vsp` - hosts the Verify Service Provider
- `msa` - hosts the Verify Matching Service Adapter
- `lms` - hosts the Verify Local Matching Service Example
- `pvsrp` - hosts the Passport Verify Stub Relying Party

In each case you can `vagrant ssh` to the machine to see the applications running (e.g.
`vagrant ssh vsp` for the Verify Service Provider).

