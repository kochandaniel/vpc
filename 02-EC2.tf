## EC2 Instances:

resource "aws_instance" "external" {
  ami = "ami-86fe70f8"
  instance_type = "t3.micro"
  subnet_id = "${aws_subnet.external1.id}"
  key_name = "Dank"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]

  tags = local.ec2_tags
}

resource "aws_instance" "internal" {
  ami = "ami-95b53beb"
  instance_type = "t3.micro"
  subnet_id = "${aws_subnet.internal1.id}"
  key_name = "Dank"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]

  tags = local.ec2_tags
}


locals {
  ec2_tags = {
    Name          = "vpc_stockholm"
    KeepUntil     = "Indef"
    CostCenter    = ""
    ManagedBy     = "dkochan@illumina.com"
    Owner         = "dkochan"
    Purpose       = "test"
    ResourceGroup = ""
  }
}
