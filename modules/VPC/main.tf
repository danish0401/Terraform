terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc["vpc-cidr"]
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "${var.name}-${terraform.workspace}-VPC"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.vpc["public-subnets-cidr"])
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.vpc["public-subnets-cidr"], count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-Public-Subnet-${count.index + 1}"
    Tier = "public"
  }
}

resource "aws_subnet" "private" {
  count                   = length(var.vpc["private-subnets-cidr"])
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.vpc["private-subnets-cidr"], count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.name}-Private-subnet-${count.index + 1}"
    Tier = "private"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-${terraform.workspace}-IGW"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "${var.name}-${terraform.workspace}-public-RT"
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "public-subnets" {
  count = length(var.vpc["public-subnets-cidr"])
  subnet_id      = element(aws_subnet.public.*.id,count.index)
  route_table_id = aws_route_table.main-public.id
}

# nat gw
resource "aws_eip" "nat" {
  count = length(var.vpc["private-subnets-cidr"]) != 0 ? 1 : 0
  vpc   = true
}

resource "aws_nat_gateway" "nat-gw" {
  count         = length(aws_eip.nat) != 0 ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.main-gw]
  tags = {
    Name = "${var.name}-${terraform.workspace}-NAT"
  }
}

# VPC setup for NAT
resource "aws_route_table" "main-private" {
  count  = length(aws_nat_gateway.nat-gw) != 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw[count.index].id
  }

  tags = {
    Name = "${var.name}-${terraform.workspace}-private-RT"
  }
}

# Route table association with private subnets
resource "aws_route_table_association" "private-subnets" {
  count = length(var.vpc["private-subnets-cidr"])
  subnet_id      = element(aws_subnet.private.*.id,count.index)
  route_table_id = aws_route_table.main-private[0].id
}
