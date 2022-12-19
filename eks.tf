# variable "vpc_id" {
#   default = "vpc-0787f2ba39824933a"
# }
# variable "subnet_id_pri" {}

# data "aws_subnet" "eks_pri_subnet" {
#   id = var.subnet_id_pri
# }
# variable "subnet_id" {}

# data "aws_subnet" "eks_pub_subnet" {
#   id = var.subnet_id
# }
# data "aws_subnet" "eks" {
#   vpc_id = var.vpc_id
# }




resource "aws_eks_cluster" "test_eks_template" {
  name     = "test_eks_template"
  role_arn = aws_iam_role.cluster_role.arn
  
  vpc_config {
    #subnet_ids = [aws_subnet.example1.id, aws_subnet.example2.id]
    subnet_ids = ["subnet-0617120509bf85ef2","subnet-0f0b0d7a460b403e3","subnet-0b0b568a30414f449",
  "subnet-0dfa14f1ac80e8d4e"]

  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController,
  ]
}

resource "aws_iam_role" "cluster_role" {
  name = "eks-template-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "eks-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster_role.name
}

# data "terraform_remote_state" "eks" {
#   backend = "local"

#   # config = {
#   #   path = "..."
#   # }
# }