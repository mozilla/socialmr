resource "aws_launch_configuration" "ret" {
  image_id = "ami-40d28157"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.ret.id}"]
}

resource "aws_autoscaling_group" "ret" {
  launch_configuration = "${aws_launch_configuration.ret.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  vpc_zone_identifier = ["${aws_subnet.us-west-1a-public.id}", "${aws_subnet.us-west-1b-public.id}"]

  min_size = 1
  max_size = 1

  tag {
    key = "Name"
    value = "ret"
    propagate_at_launch = true
  }
}
