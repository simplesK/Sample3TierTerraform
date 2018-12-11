provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

# creating new keypair in EC2


variable "region" {
  description = "The AWS region to deploy to"
  default = "ap-southeast-1"
}

variable "name" {
  description = "The name of the deployment"
  default = ""
}

variable "public_key_path" {
  description = "public Key Path"
  default = "~/.ssh/id_rsa.pub"
}