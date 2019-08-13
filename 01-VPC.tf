# VPC


resource "aws_vpc" "dank-test" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "TerraVPC"
  }
}



# Internet Gateway

resource "aws_internet_gateway" "igw"{
  vpc_id = "${aws_vpc.dank-test.id}"

  tags = {
    Name = "Main"
  }
}


# NAT

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.external1.id}"

  tags = {
    Name = "gw NAT"
  }
}


# Subnets

resource "aws_subnet" "external1" {
  vpc_id     = "${aws_vpc.dank-test.id}"
  availability_zone = "eu-north-1a"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "External Subnet 1"
  }
}

resource "aws_route_table_association" "external1" {
  subnet_id = "${aws_subnet.external1.id}"
  route_table_id = "${aws_route_table.external.id}"
}

resource "aws_subnet" "external2" {
  vpc_id     = "${aws_vpc.dank-test.id}"

  availability_zone = "eu-north-1b"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "External Subnet 2"
  }
}

resource "aws_route_table_association" "external2" {
  subnet_id = "${aws_subnet.external2.id}"
  route_table_id = "${aws_route_table.external.id}"
}



resource "aws_subnet" "internal1" {
  vpc_id     = "${aws_vpc.dank-test.id}"
  availability_zone = "eu-north-1a"
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "Internal Subnet 1"
  }
}

resource "aws_route_table_association" "internal1" {
  subnet_id = "${aws_subnet.internal1.id}"
  route_table_id = "${aws_route_table.internal.id}"
}




resource "aws_subnet" "internal2" {
  vpc_id     = "${aws_vpc.dank-test.id}"
  availability_zone = "eu-north-1b"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "Internal Subnet 2"
  }
}

resource "aws_route_table_association" "internal2" {
  subnet_id = "${aws_subnet.internal2.id}"
  route_table_id = "${aws_route_table.internal.id}"
}



## Route tables

resource "aws_route_table" "external" {
  vpc_id = "${aws_vpc.dank-test.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "External"
  }
}

resource "aws_route_table" "internal" {
  vpc_id = "${aws_vpc.dank-test.id}"

  tags = {
    Name = "Internal"
  }
}


## Security Groups

resource "aws_security_group" "ssh" {
  name = "ssh"
  vpc_id = "${aws_vpc.dank-test.id}"

  tags = {
    Name = "Default SSH"
  }

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

## ACL

resource "aws_network_acl" "main_ex" {
  vpc_id = "${aws_vpc.dank-test.id}"
  subnet_ids = [ "${aws_subnet.external1.id}" ]



ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "main_ex"
  }
}

resource "aws_network_acl" "main_in" {
  vpc_id = "${aws_vpc.dank-test.id}"
  subnet_ids = [ "${aws_subnet.internal1.id}" ]


ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "main_in"
  }
}
