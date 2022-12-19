provider "aws" {
  region = "eu-west-2"
}
resource "aws_vpc" "eks_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/test_eks_template" = "shared"
    Name = "${var.my_prefix}-vpc"
  }
}


data "aws_availability_zones" "azs" {}

resource "aws_subnet" "private" {
  count = length(var.private_cidr)
  cidr_block  = var.private_cidr[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  #cidr_block        = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index)

  vpc_id            = aws_vpc.eks_vpc.id

  tags = {
    "kubernetes.io/cluster/test_eks_template" = "shared"
    "kubernetes.io/role/internal-elb" =1
    Name = "${var.my_prefix}-private-sub"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_cidr)
  cidr_block  = var.public_cidr[count.index]
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  #cidr_block        = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 7, count.index)
  vpc_id            = aws_vpc.eks_vpc.id

  tags = {
    "kubernetes.io/cluster/test_eks_template" = "shared"
    "kubernetes.io/role/elb" =1
    Name = "${var.my_prefix}-public-sub"
  }
}


resource "aws_internet_gateway" "eks-templates" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.my_prefix}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-templates.id
  }


  tags = {
    Name = "${var.my_prefix}-rtable"
  }
}

resource "aws_route_table_association" "eks_route_table_association" {
    count         = length(aws_subnet.public)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id

   
}
# esource "aws_nat_gateway" "eks" {
#   rcount         = length(aws_subnet.eks_pub_subnet)
#   subnet_id     = aws_subnet.eks_pub_subnet[count.index].id

#   tags = {
#     Name = "eks-template"
#   }

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.eks-templates]
# }
