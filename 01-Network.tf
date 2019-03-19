resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.test.id}"

  tags = {
    Name = "Main"
  }
}
resource "aws_subnet" "ec2" {
  vpc_id     = "${aws_vpc.test.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "EC2"
  }
}
