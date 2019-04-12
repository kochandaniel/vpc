# Terraform classic VPC configuration example
This is a small repo with an example of a standard VPC deployment and testing public and private EC2 instances.

## Contents
00-Provider - Specifies the Terraform provider, in this case AWS, and the region where the resources are going to be deployed. In this example the region chosen is _eu-west-1_, London. Please note that normally you would define a backend storage to save state files at the beginning of your Terraform configuration, as explained [here](https://www.terraform.io/docs/backends/index.html).

01-VPC - Deploys the following resources:

* VPC
* 2 Public Subnets (External 1 and External 2)
* 2 Private Subnets (Internal 1 and Internal 2)
* Internet Gateway (Default)
* 2 Routing Tables (Public and Private)
* 1 Security Group (SSH)

Please note that there are no NACLs configured. For this example the defaults will be used, allowing all incoming and outgoing traffic. The Security Group will be applied to both instances for SSH access.

02-EC2 - Deploys the following resources:

* 1 EC2 Instance with external access (t2.micro, AWS AMI, Subnet External 1)
* 1 EC2 Instance without external access (t2.micro, AWS AMI, Subnet Internal 1)

There are two points to consider here:

* First, the instances are launched using a keypair called "Default", that has been generated before this deployment. If there is no such keypair in your account you won't be able to log in into the instances.
* Second, the AMI id has been hardcoded to keep consistency between EC2 instances over time. This can be dynamically obtained using the aws_ami data as described [here](https://www.terraform.io/docs/providers/aws/d/ami.html).

## Regarding credentials and structure
There are many ways to pass the credentials to the provider in Terraform, though normally they would be obtained through secure channels (like Vault). These methods are outside of the scope of this example and how to use credentials is left on the hands of the user.

As for variables in this example, note that is **not** best practice to hardcode any variable, especially those that are outside our control (AMI case). Variables should be defined separately and used accordingly in the resources.

## Purpose and recommended use
This example has been written with the idea of giving a new Terraform user a small overview of how easy is to work with Infrastructure as Code. The use of ```terraform state``` is highly encouraged to review the deployed resources as opposed to the use of Amazon's Console to get used to work with IaC. All information regarding states, how to use them and why are they important can be found in the official Terraform documentation [here](https://www.terraform.io/docs/state/index.html).
