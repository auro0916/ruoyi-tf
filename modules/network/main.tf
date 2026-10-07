# VPC
resource "aws_vpc" "lab" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

# Public Subnet A
resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.lab.id
  cidr_block        = var.public_subnet_a_cidr
  availability_zone = var.az_a

  tags = {
    Name = "${var.name_prefix}-public-a"
  }
}

# Public Subnet C
resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.lab.id
  cidr_block        = var.public_subnet_c_cidr
  availability_zone = var.az_c

  tags = {
    Name = "${var.name_prefix}-public-c"
  }
}

# Private App Subnets
resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.lab.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.name_prefix}-private-${each.key}"
  }
}

# DB Private Subnets
resource "aws_subnet" "db" {
  for_each = var.db_subnets

  vpc_id            = aws_vpc.lab.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.name_prefix}-db-${each.key}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "lab" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "${var.name_prefix}-public-rt"
  }
}

# Public Route
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab.id
}

# Public Subnet A -> Public Route Table
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# Public Subnet C -> Public Route Table
resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.name_prefix}-nat-eip"
  }
}

# NAT Gateway
resource "aws_nat_gateway" "lab" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "${var.name_prefix}-nat"
  }

  depends_on = [aws_internet_gateway.lab]
}

# Private App Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "${var.name_prefix}-private-rt"
  }
}

# Private App Route -> NAT Gateway
resource "aws_route" "private_internet" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.lab.id
}

# Private App Subnets -> Private Route Table
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

# DB Route Table
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "${var.name_prefix}-db-rt"
  }
}

# DB Subnets -> DB Route Table
resource "aws_route_table_association" "db" {
  for_each = aws_subnet.db

  subnet_id      = each.value.id
  route_table_id = aws_route_table.db.id
}