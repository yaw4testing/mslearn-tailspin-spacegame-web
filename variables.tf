variable "vpc_cidr" {
  type = string
}

variable "private_cidr" {
  type    = list(string)
  default = []
}

variable "public_cidr" {
  type    = list(string)
  default = []
}
  variable "azs" {}


variable "ami_id" {

}

variable "instance_types" {

}

variable "aws_region" {

}

variable "my_prefix" {}

variable "key_location" {}

variable "my_ip"{}
