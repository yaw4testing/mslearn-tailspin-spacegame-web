resource "aws_autoscaling_group" "test" {
  # ... other configuration, including potentially other tags ...
  launch_configuration = aws_launch_configuration.as_conf.name
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 2
  availability_zones        = data.aws_availability_zones.azs.names
  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

data "aws_availability_zones" "azs"{}