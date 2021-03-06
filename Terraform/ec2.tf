data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_security_group" "SSH" {
  name = "SSH Fid Home"
  vpc = aws_vpc.main.id

  ingress {
    description = "SSH Fid"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "devops"
  }
}

resource "aws_instance" "pgpDemo" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3a.micro"
  key_name = "devops"
  vpc_security_group_ids = aws_security_group.SSH.id

  tags = {
    Name = "pgpDevops"
    Env = "pgpDevops"
  }
}
