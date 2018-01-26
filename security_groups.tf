/* Security Group Creation */
resource "aws_security_group" "MongoDB" {
  name = "MongoDB"
  tags {
        Name = "MongoDB"
  }
  description = "ONLY tcp CONNECTION INBOUND"
  vpc_id = "${var.vpc_id}"
  ingress {
      from_port = 27017
      to_port = 27017
      protocol = "TCP"
      self = "true"
  }

  ingress {
      from_port   = "22"
      to_port     = "22"
      protocol    = "TCP"
      cidr_blocks = "${var.vpc-fullcidr}"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}