## Latest CentOS 7.6 image

data "aws_ami" "centos" {
  most_recent = true
 
  filter {
    name = "name"
    values = ["CentOS 7.6 - 18.0.0.0SE*"]
  }
  owners = ["679593333241"]
} 

## EC2 Instances
## Note: The keypair used for these instances was created through the UI for security purposes. The AMI is also hardcoded to keep consistency between existing and new instances.

resource "aws_instance" "test" {
  ami = "ami-09ead922c1dad67e4"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.external.id}"
  key_name = "Default"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]

  tags = {
    Name = "Test Instance"
  }
}
