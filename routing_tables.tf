# Tabla de enrutamiento para el segmento privado
resource "aws_route_table" "immune-g2-private-route-table" {
  vpc_id = aws_vpc.immune-g2-vpc-01.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.immune-g2-nat-gateway-01.id
  }

  tags = {
    Name = "immune-g2-private-route-table"
  }
}

# Asociación de tabla de enrutamiento con subnets privadas
resource "aws_route_table_association" "immune-g2-private-route-association-01" {
  subnet_id      = aws_subnet.immune-g2-private-db-subnet-01.id
  route_table_id = aws_route_table.immune-g2-private-route-table.id
}

resource "aws_route_table_association" "immune-g2-private-route-association-02" {
  subnet_id      = aws_subnet.immune-g2-private-db-subnet-02.id
  route_table_id = aws_route_table.immune-g2-private-route-table.id
}

# Tabla de enrutamiento para el segmento público
resource "aws_route_table" "immune-g2-public-route-table" {
  vpc_id = aws_vpc.immune-g2-vpc-01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.immune-g2-igw-01.id
  }

  tags = {
    Name = "immune-g2-public-route-table"
  }
}

# Asociación de tabla de enrutamiento con subnets públicas
resource "aws_route_table_association" "immune-g2-public-route-association-01" {
  subnet_id      = aws_subnet.immune-g2-public-subnet-01.id
  route_table_id = aws_route_table.immune-g2-public-route-table.id
}

resource "aws_route_table_association" "immune-g2-public-route-association-02" {
  subnet_id      = aws_subnet.immune-g2-public-subnet-02.id
  route_table_id = aws_route_table.immune-g2-public-route-table.id
}