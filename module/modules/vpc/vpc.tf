resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  instance_tenancy     = "default"

  tags = {
    Name = var.vpc_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.igw_name
  }
}

# Subnets : public
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = var.vpc_id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  map_public_ip_on_launch = "true"
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "public-${count.index + 1}-subnet"
  }
}

# Subnets : private

resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "private-${count.index + 1}-subnet"
  }
}

# Public Route table: attach Internet Gateway 
resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

# Private Route table: attach NAT Gateway 
resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name = "private-rt"
  }
}

# Route table association with private subnets
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

# Route table association with public subnets
resource "aws_route_table_association" "public" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

## Create NAT Gateway

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = var.nat_eip
  subnet_id     = element(aws_subnet.public.*.id, 0)
}
