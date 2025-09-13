# Security Group para el Load Balancer Público
resource "aws_security_group" "immune-g2-public-lb-sg" {
  name        = "immune-g2-public-lb-sg"
  description = "Security group for public load balancer"
  vpc_id      = aws_vpc.immune-g2-vpc-01.id

  # Permitir tráfico HTTP (puerto 80) desde cualquier origen
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir tráfico HTTPS (puerto 443) desde cualquier origen
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir todo el tráfico de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "immune-g2-public-lb-sg"
  }
}

# Security Group para el Load Balancer Interno
resource "aws_security_group" "immune-g2-internal-lb-sg" {
  name        = "immune-g2-internal-lb-sg"
  description = "Security group for internal load balancer"
  vpc_id      = aws_vpc.immune-g2-vpc-01.id

  # Permitir tráfico HTTP (puerto 80) desde las subnets privadas
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.2.0/24", # Private Web Subnet 01
      "10.0.20.0/24" # Private Web Subnet 02
    ]
  }

  # Permitir tráfico HTTPS (puerto 443) desde las subnets privadas
  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.2.0/24", # Private Web Subnet 01
      "10.0.20.0/24" # Private Web Subnet 02
    ]
  }

  # Permitir todo el tráfico de salida
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "immune-g2-internal-lb-sg"
  }
}

# Security Group for vpc endpoint
resource "aws_security_group" "immune-g2-vpc-endpoint-sg" {
  name        = "immune-g2-vpc-endpoint-sg"
  description = "Security group for VPC endpoint"
  vpc_id      = aws_vpc.immune-g2-vpc-01.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "immune-g2-vpc-endpoint-sg"
  }
}