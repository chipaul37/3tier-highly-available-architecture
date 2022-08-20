resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet_az1.id

  tags = {
    Name = "nat gateway"
  }
    depends_on = [aws_internet_gateway.internet_gateway]
}