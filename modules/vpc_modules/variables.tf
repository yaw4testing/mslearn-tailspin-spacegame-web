variable "vpc_cidr"{
    type = string
}

variable "private_cidr"{
    type = list(string)
    default = []
}

variable "public_cidr"{
    type = list(string)
    default = []
}
variable "azs"{
    type  = list(string)
    description = "region availbility zone"

}

variable "ami_id"{}

variable "instance_types"{}
# variable "aws_region"{
    
# }

variable "my_ip"{}

variable "my_prefix"{}