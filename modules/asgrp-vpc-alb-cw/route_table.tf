# Routing table for Public Subnet 01 ----------------------------
resource "aws_route_table" "rt_pub_sub_01" {
  vpc_id = aws_vpc.my_vpc_01.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.my_igw_01.id
  }

  tags = {
    Name = "rt-public-subnet-01"
  }
}
# Routing table for Public Subnet 02 ----------------------------
resource "aws_route_table" "rt_pub_sub_02" {
  vpc_id = aws_vpc.my_vpc_01.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_internet_gateway.my_igw_01.id
  }

  tags = {
    Name = "rt-public-subnet-02"
  }
}

# Routing table for Private Subnet 03 ----------------------------
resource "aws_route_table" "rt_priv_sub_03" {
  vpc_id = aws_vpc.my_vpc_01.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_nat_gateway.my_ng_01.id
  }

  tags = {
    Name = "rt-private-subnet-03"
  }
}

# Routing table for Private Subnet 04 ----------------------------
resource "aws_route_table" "rt_priv_sub_04" {
  vpc_id = aws_vpc.my_vpc_01.id

  route {
    cidr_block = var.rt_cidr_block
    gateway_id = aws_nat_gateway.my_ng_02.id
  }

  tags = {
    Name = "rt-private-subnet-04"
  }
}

# Associate routing tables -----------------------------------

# Associate route table to Public Subnet 01
resource "aws_route_table_association" "rt_assoc_sub_01" {
  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.rt_pub_sub_01.id
}

# Associate route table to Public Subnet 02
resource "aws_route_table_association" "rt_assoc_sub_02" {
  subnet_id      = aws_subnet.public_subnet_02.id
  route_table_id = aws_route_table.rt_pub_sub_02.id
}

# Associate route table to Private Subnet 03
resource "aws_route_table_association" "rt_assoc_sub_03" {
  subnet_id      = aws_subnet.private_subnet_03.id
  route_table_id = aws_route_table.rt_priv_sub_03.id
}

# Associate route table to Private Subnet 04
resource "aws_route_table_association" "rt_assoc_sub_04" {
  subnet_id      = aws_subnet.private_subnet_04.id
  route_table_id = aws_route_table.rt_priv_sub_04.id
}