terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  required_version = "~> 1.2.0"
}
provider "aws" {
  region = "eu-west-2"
}

# data "terraform_remote_state" "eks" {
#   backend = "local"

#   # config = {
#   #   path = "..."
#   # }
# }

# # Terraform >= 0.12
# resource "aws_instance" "foo" {
#   # ...
#   subnet_id = data.terraform_remote_state.vpc.outputs.subnet_id
# }

# # Terraform <= 0.11
# resource "aws_instance" "foo" {
#   # ...
#   subnet_id = "${data.terraform_remote_state.vpc.subnet_id}"
# }
