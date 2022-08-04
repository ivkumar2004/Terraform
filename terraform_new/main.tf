# provider "aws" {
#     region = "us-west-2"
#     access_key = "AKIA344QC75H3S7FRH4S"
#     secret_key = "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"
# }

resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "vpc_main"
  }
}

resource "aws_subnet" "subnet_main" {
  vpc_id     = aws_vpc.vpc_main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-west-2b"

  tags = {
    Name = "subnet_main"
  }
}

resource "aws_internet_gateway" "gw_main" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "gw_main"
  }
}

resource "aws_route_table" "route_main" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_main.id
  }

  tags = {
    Name = "route_main"
  }
}

resource "aws_route_table_association" "route_association_main" {
  subnet_id      = aws_subnet.subnet_main.id
  route_table_id = aws_route_table.route_main.id
}

resource "aws_key_pair" "key_pair_main" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCiiDkeR+5pbDzZUw+nPcBSEYxaZlfxVSz8ge9Fx392o+TX9YoH2AT28br3iUCDxZUmecyhi2ufPPMeQlzuoFVTVGT9Fb+Qdn3kXaKjcz3uaES/Bi30DB6Fi5IxZBLQGco2YTIdDfL4nscXWiX379xx9lNo2MEUngMdRV/s1CTy5w7983ImBYPShq8wR2FzBvSV8V1gFbpzVrBOMZuF5aSSSga4pZk5y/d8haiYZDaLbWy7qeDU4OyKvYSZfyff+nI/YmlmS0K2DrcS8YqUnXkEjTmwF39tatsARw0wMX1S/n8ZbAW1pWuTcF1bhpQv0e2J8ea946wm+gddQR5LyquV ubuntu@ip-172-31-28-156"
}

resource "aws_instance" "instance_main" {
  ami = "ami-0ee8244746ec5d6d4"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet_main.id
  key_name   = "aws_key"
  
  tags = {
    Name = "instance_main"
  }
}
