
variable "shared" { type = "map" }
terraform { backend "s3" {} }
provider "aws" { region = "${var.shared["region"]}", version = "~> 0.1" }
data "aws_availability_zones" "all" {}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    key = "vpc/terraform.tfstate"
    bucket = "${var.shared["state_bucket"]}"
    region = "${var.shared["region"]}"
    dynamodb_table = "${var.shared["dynamodb_table"]}"
    encrypt = "true"
  }
}

resource "aws_security_group" "ret" {
  name = "ret"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

  ingress {
    from_port = "${var.ret_http_port}"
    to_port = "${var.ret_http_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "ret" {
  image_id = "ami-8edbf0ee"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.ret.id}"]
}

resource "aws_autoscaling_group" "ret" {
  launch_configuration = "${aws_launch_configuration.ret.id}"
  availability_zones = ["${data.aws_availability_zones.all.names}"]
  vpc_zone_identifier = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]

  min_size = 0
  max_size = 0

  tag {
    key = "Name"
    value = "ret"
    propagate_at_launch = true
  }
}
