# Chapter 1: Why Terraform

Packer -> create images
Vagrant -> images run on development laptops
Docker -> create images for individual applications

immutable infrastructure --> server templating. Once you deploy the server you never change it again. If you need the update just deploy it again with a new version

## Orchestration tools

Managing VMs and containers. Use an Orchestration tool like kubternetes or Nomad. 

## Provisioning tools

Actually creating the servers with tools like terraform, cloudformation and openstack Heat

## The Benefits of Infrastructure as Code

- self-service: developers can start their own deployments without sysadmin
- speed and safety: deployment is faster and consistent
- documentation: everything is written down. 
- version control: We now when changes are made to the infrastructure and what changed
- validation: We can code review and test it automatically
- reuse: using modules you have to only write it once
- Happniness: You are not doing the same thing every day 

## Why terraform?

- Configuration Management Versus Provisioning:
Tools overlap but use the tool for the correct job. 

- Mutable Infrastructure Versus Immutable Infrastructure
chef puppet and ansible default to mutable infrastructure

- Procedural Language Versus Declarative Language
Declaritive is prefered in a way you write how it should be. 

- Master Versus Masterless
You don't need a server that you have to maintain or update. Unless you wnt Terraform Enterprise

- agent vs agentless
no need to install software on servers
