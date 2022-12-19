provider "aws" {
  region = "eu-west-2"
}
data "aws_ami" "customized" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

output "aws_ami"{
    value = data.aws_ami.customized.id
}

data "aws_availability_zones" "azs"{}

resource "aws_instance" "terraform_template" {
  count         = length(var.private_cidr)
  ami           = data.aws_ami.customized.id
  instance_type = var.instance_types
  associate_public_ip_address = true
  subnet_id                   = var.private_id
  #for_each = toset(var.azs)
  availability_zone  = data.aws_availability_zones.azs.names[count.index]
  key_name           = aws_key_pair.template_key.key_name
  user_data          = <<-EOF
                          #!/bin/bash
                          sudo yum update -y && sudo yum install -y docker
                          sudo systemctl start docker

                          sudo usermod -aG docker ec2-user
                          docker run -p 8080:80 nginx
                        EOF


  tags = {
    Name = "${var.my_prefix}-ec2-instance"
  }
}


resource "aws_key_pair" "template_key" {
  key_name   = "template_key"
  public_key = file(var.key_location)
}
