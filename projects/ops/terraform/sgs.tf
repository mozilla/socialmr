resource "aws_security_group" "ret" {
  name = "ret"
  vpc_id = "${aws_vpc.mr.id}"

  ingress {
    from_port = "${var.ret_http_port}"
    to_port = "${var.ret_http_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
