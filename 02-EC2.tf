## EC2 Instances
## Note: The keypair used for these instances was created through the UI for security purposes. The AMI is also hardcoded to keep consistency between existing and new instances.

resource "aws_instance" "external" {
  ami = "ami-86fe70f8"
  instance_type = "t3.micro"
  subnet_id = "${aws_subnet.external1.id}"
  key_name = "Dank"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]

  dynamic "tag" {
    for_each = local.ec2_tags

    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_instance" "internal" {
  ami = "ami-95b53beb"
  instance_type = "t3.micro"
  subnet_id = "${aws_subnet.internal1.id}"
  key_name = "Dank"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]

  dynamic "tag" {
    for_each = local.ec2_tags

    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
    }
  }
}


resource "aws_instance" "internal" {
  ami = "ami-95b53beb"
  instance_type = "t3.micro"
  subnet_id = "${aws_subnet.internal1.id}"
  key_name = "Dank"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]

  dynamic "tag" {
    for_each = local.ec2_tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
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