provider "aws" {
  region = "us-west-1"
}

data "aws_availability_zones" "all" {}
