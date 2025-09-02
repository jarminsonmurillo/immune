resource "aws_eip" "immune-g2-nat-eip-01" {
tags = {
  "Name" = "immune-g2-nat-eip-01"
}
}

resource "aws_eip" "immune-g2-nat-eip-02" {
tags = {
  "Name" = "immune-g2-nat-eip-02"
}
}

resource "aws_nat_gateway" "immune-g2-nat-gateway-01" {
  allocation_id = aws_eip.immune-g2-nat-eip-01.id
  subnet_id     = aws_subnet.immune-g2-public-subnet-01.id
tags = {
  "Name" = "immune-g2-nat-gateway-01"
}
}

resource "aws_nat_gateway" "immune-g2-nat-gateway-02" {
  allocation_id = aws_eip.immune-g2-nat-eip-02.id
  subnet_id     = aws_subnet.immune-g2-public-subnet-02.id
tags = {
  "Name" = "immune-g2-nat-gateway-02"
}
}