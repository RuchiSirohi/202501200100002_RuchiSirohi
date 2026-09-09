resource "aws_internet_gateway" "cloudnotes_igw" {
  vpc_id = aws_vpc.cloudnotes_vpc.id

  tags = {
    Name = "cloudnotes-igw"
  }
}