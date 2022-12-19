resource "aws_ecs_task_definition" "ecs_template" {
  family       = "ecs_template"
  #network_mode = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "813534103990.dkr.ecr.eu-west-2.amazonaws.com/docker-registry"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }

  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
  tags = {
    Name = "ecs_template"
  }
}