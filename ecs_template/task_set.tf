resource "aws_ecs_task_set" "ecs_template" {
  service         = aws_ecs_service.ecs_template.id
  cluster         = aws_ecs_cluster.ecs_template.id
  task_definition = aws_ecs_task_definition.ecs_template.arn

  tags = {
    Name = "ecs_template"
  }

}