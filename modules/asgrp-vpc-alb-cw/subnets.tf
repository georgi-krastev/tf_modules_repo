# Public Subnet 1 ----------------------------------
resource "aws_subnet" "public_subnet_01" {
  vpc_id     = aws_vpc.my_vpc_01.id
  cidr_block = var.pub_sub_01_cidr
  availability_zone = var.avail_zone_1a

  tags = {
    Name = "public-subnet-01"
  }
}

# Public Subnet 2 ----------------------------------
resource "aws_subnet" "public_subnet_02" {
  vpc_id     = aws_vpc.my_vpc_01.id
  cidr_block = var.pub_sub_02_cidr
  availability_zone = var.avail_zone_1b

  tags = {
    Name = "public-subnet-02"
  }
}

# Private Subnet 3 --------------------------------
resource "aws_subnet" "private_subnet_03" {
  vpc_id     = aws_vpc.my_vpc_01.id
  cidr_block = var.priv_sub_03_cidr
  availability_zone = var.avail_zone_1a
  tags = {
    Name = "private-subnet-03"
  }
}

# Private Subnet 4 --------------------------------
resource "aws_subnet" "private_subnet_04" {
  vpc_id     = aws_vpc.my_vpc_01.id
  cidr_block = var.priv_sub_04_cidr
  availability_zone = var.avail_zone_1b
  tags = {
    Name = "private-subnet-04"
  }
}