
resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = "ami-00785f4835c6acf64"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}