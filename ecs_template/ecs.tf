# module "ecs" {
#   source  = "terraform-aws-modules/ecs/aws"
#   version = "4.1.1"
# }

resource "aws_ecs_cluster" "ecs_template" {
  name = "ecs_template"
  tags = {
    Name = "ecs_template"
  }
}
resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.ecs_template.name

  capacity_providers = [aws_ecs_capacity_provider.my_template.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.my_template.name
  }
}

resource "aws_ecs_capacity_provider" "my_template" {
  name = "my_template"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.test.arn
    #managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 10
    }
  }
}
