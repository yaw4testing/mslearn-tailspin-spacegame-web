output "vpc_id"{
    value = aws_vpc.eks_vpc
}
output "pri_subnet"{
    value = aws_subnet.private
}
output "pub_subnet"{
    value = aws_subnet.public
}