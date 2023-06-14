# VPC Definition ------------------------------
resource "aws_vpc" "my_vpc_01" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = "my-vpc-01"
  }
}

# Internet Gateway -----------------------------
resource "aws_internet_gateway" "my_igw_01" {
  vpc_id = aws_vpc.my_vpc_01.id

  tags = {
    Name = "my-ig-01"
  }
}

# Elastic IP for NAT Gateway 1 -----------------
resource "aws_eip" "my_eip_01" {
  vpc = true
}

# Elastic IP for NAT Gateway 2 -----------------
resource "aws_eip" "my_eip_02" {
  vpc = true
}

# NAT Gateway 1 --------------------------------
resource "aws_nat_gateway" "my_ng_01" {
  allocation_id = aws_eip.my_eip_01.id
  subnet_id     = aws_subnet.public_subnet_01.id
  
  tags = {
    Name = "my-ng-01"
  }

  depends_on = [aws_internet_gateway.my_igw_01]
}

# NAT Gateway 2 --------------------------------
resource "aws_nat_gateway" "my_ng_02" {
  allocation_id = aws_eip.my_eip_02.id
  subnet_id     = aws_subnet.public_subnet_02.id

  tags = {
    Name = "my-ng-02"
  }

  depends_on = [aws_internet_gateway.my_igw_01]
}