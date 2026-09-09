# =========================
# Public Subnet - AZ 1
# =========================

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.cloudnotes_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloudnotes-public-subnet-1"
  }
}


# =========================
# Public Subnet - AZ 2
# =========================

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.cloudnotes_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "cloudnotes-public-subnet-2"
  }
}


# =========================
# Private App Subnet - AZ 1
# =========================

resource "aws_subnet" "private_app_subnet_1" {
  vpc_id            = aws_vpc.cloudnotes_vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "cloudnotes-private-app-subnet-1"
  }
}


# =========================
# Private App Subnet - AZ 2
# =========================

resource "aws_subnet" "private_app_subnet_2" {
  vpc_id            = aws_vpc.cloudnotes_vpc.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "cloudnotes-private-app-subnet-2"
  }
}


# =========================
# Private Database Subnet - AZ 1
# =========================

resource "aws_subnet" "private_db_subnet_1" {
  vpc_id            = aws_vpc.cloudnotes_vpc.id
  cidr_block        = "10.0.21.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "cloudnotes-private-db-subnet-1"
  }
}


# =========================
# Private Database Subnet - AZ 2
# =========================

resource "aws_subnet" "private_db_subnet_2" {
  vpc_id            = aws_vpc.cloudnotes_vpc.id
  cidr_block        = "10.0.22.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "cloudnotes-private-db-subnet-2"
  }
}