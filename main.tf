provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo" {
  instance_type = "t2.micro"
  ami = "ami-05c13eab67c5d8861"
  tenancy = "default"
  tags = {
    Name = "jenkinsserver"
  }
}