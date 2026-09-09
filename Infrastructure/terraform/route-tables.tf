# ==========================================
# Public Route Table
# ==========================================

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.cloudnotes_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cloudnotes_igw.id
  }

  tags = {
    Name = "cloudnotes-public-route-table"
  }
}

# ==========================================
# Public Subnet Associations
# ==========================================

resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

# ==========================================
# Private App Route Table
# ==========================================

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.cloudnotes_vpc.id

  tags = {
    Name = "cloudnotes-private-route-table"
  }
}

# ==========================================
# Private App Subnet Associations
# ==========================================

resource "aws_route_table_association" "private_app_subnet_1_association" {
  subnet_id      = aws_subnet.private_app_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_app_subnet_2_association" {
  subnet_id      = aws_subnet.private_app_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

# ==========================================
# Private Database Route Table
# ==========================================

resource "aws_route_table" "private_db_route_table" {
  vpc_id = aws_vpc.cloudnotes_vpc.id

  tags = {
    Name = "cloudnotes-private-db-route-table"
  }
}

# ==========================================
# Database Subnet Associations
# ==========================================

resource "aws_route_table_association" "private_db_subnet_1_association" {
  subnet_id      = aws_subnet.private_db_subnet_1.id
  route_table_id = aws_route_table.private_db_route_table.id
}

resource "aws_route_table_association" "private_db_subnet_2_association" {
  subnet_id      = aws_subnet.private_db_subnet_2.id
  route_table_id = aws_route_table.private_db_route_table.id
}