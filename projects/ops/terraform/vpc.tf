resource "aws_vpc" "mr" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "mr_inet" {
  vpc_id = "${aws_vpc.mr.id}"
}

# Public subnets

resource "aws_subnet" "us-west-1a-public" {
  vpc_id = "${aws_vpc.mr.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-west-1a"
}

resource "aws_subnet" "us-west-1b-public" {
  vpc_id = "${aws_vpc.mr.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-1b"
}

resource "aws_route_table" "us-west-1-public" {
  vpc_id = "${aws_vpc.mr.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "aws_internet_gateway.mr_inet.id"
  }
}

resource "aws_route_table_association" "us-west-1a-public" {
  route_table_id = "${aws_route_table.us-west-1-public.id}"
  subnet_id = "${aws_subnet.us-west-1a-public.id}"
}

resource "aws_route_table_association" "us-west-1b-public" {
  route_table_id = "${aws_route_table.us-west-1-public.id}"
  subnet_id = "${aws_subnet.us-west-1b-public.id}"
}

# Private subnets

resource "aws_subnet" "us-west-1a-private" {
  vpc_id = "${aws_vpc.mr.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-1a"
}

resource "aws_subnet" "us-west-1b-private" {
  vpc_id = "${aws_vpc.mr.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-1b"
}

resource "aws_eip" "mr_nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat-us-west-1a" {
  allocation_id = "${aws_eip.mr_nat.id}"
  subnet_id     = "${aws_subnet.us-west-1a-public.id}"
}

resource "aws_route_table" "us-west-1-private" {
  vpc_id = "${aws_vpc.mr.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "aws_nat_gateway.nat-us-west-1a.id"
  }
}

resource "aws_route_table_association" "us-west-1a-private" {
  route_table_id = "${aws_route_table.us-west-1-private.id}"
  subnet_id = "${aws_subnet.us-west-1a-private.id}"
}

resource "aws_route_table_association" "us-west-1b-private" {
  route_table_id = "${aws_route_table.us-west-1-private.id}"
  subnet_id = "${aws_subnet.us-west-1b-private.id}"
}
