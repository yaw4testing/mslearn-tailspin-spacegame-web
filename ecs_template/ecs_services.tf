resource "aws_ecs_service" "ecs_template" {
  name            = "nginx"
  cluster         = aws_ecs_cluster.ecs_template.id
  task_definition = aws_ecs_task_definition.ecs_template.arn
  desired_count   = 2
  # iam_role        = aws_iam_role.foo.arn
  # depends_on      = [aws_iam_role_policy.foo]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  # load_balancer {
  #   target_group_arn = aws_lb_target_group.foo.arn
  #   container_name   = "nginx"
  #   container_port   = 80
  # }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [eu-west-2a, eu-west-2b]"
  }
  tags = {
    Name = "ecs_template"
  }
}