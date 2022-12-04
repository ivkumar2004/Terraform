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
  public_key = "<public key>"
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
