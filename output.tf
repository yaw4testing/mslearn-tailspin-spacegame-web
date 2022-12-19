output "vpc_id"{
    value = module.vpc.vpc_id
}

output "pri_subnet"{
    value = module.vpc.pri_subnet
}
output "pub_subnet"{
    value = module.vpc.pub_subnet
}