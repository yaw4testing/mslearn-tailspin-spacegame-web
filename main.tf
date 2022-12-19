## vpc module created from scractch
module "vpc" {
  source         = "./modules/vpc_modules"
  vpc_cidr       = var.vpc_cidr
  private_cidr   = var.private_cidr
  public_cidr    = var.public_cidr
  instance_types = var.instance_types
  ami_id         = var.ami_id
  azs            = data.aws_availability_zones.azs.names
  my_ip          = var.my_ip
  my_prefix      = var.my_prefix

}
data "aws_availability_zones" "azs" {}

######################################################################################
## vpc module from terraform registry



# module "eks_vpc" {
#   source               = "terraform-aws-modules/vpc/aws"
#   version              = "3.14.2"
#   name                 = "vpc_for_eks_cluster"
#   cidr                 = var.vpc_cidr
#   private_subnets      = var.pri_subnet_cidr
#   public_subnets       = var.pub_subnet_cidr
#   azs                  = data.aws_availability_zones.azs.names
#   enable_nat_gateway   = true
#   enable_vpn_gateway   = true
#   enable_dns_hostnames = true

#   tags = {
#     "kubernetes.io/cluster/eks_template" = "shared"
#   }
#   public_subnet_tags = {
#     "kubernetes.io/cluster/eks_template" = "shared"
#     "kubernetes.io/role/elb"             = 1
#   }
#   private_subnet_tags = {
#     "kubernetes.io/cluster/eks_template" = "shared"
#     "kubernetes.io/role/internal-elb"    = 1
#   }
# }



#aws_region           = var.aws_region

# data "terraform_remote_state" "eks" {
#   backend = "local"

#   # config = {
#   #   path = "..."
#   # }
# }

#################################################################################
module "ec2_instance" {
  source         = "./modules/ec2_instance"
  instance_types = var.instance_types
  #azs            = var.azs
  my_prefix      = var.my_prefix
  key_location   = var.key_location
  vpc_id         = module.vpc.vpc_id.id
  private_id     = join(", ",module.vpc.pri_subnet[*].id)
  my_ip          = var.my_ip
  private_cidr   = var.private_cidr
}