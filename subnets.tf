/* Subnet Creation */
resource "aws_subnet" "PrivateAZA" {
  count = 3
  vpc_id = "${var.vpc_id}"
  cidr_block = "${element(var.Subnet-Private-AzA-CIDR, count.index)}"
  tags {
        Name = "PrivateSubnet"
  }
  availability_zone = "${element(var.azs, count.index)}"
}