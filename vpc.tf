resource "aws_vpc" "immune-g2-vpc-01" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "immune-g2-vpc-01"
  }
}

resource "aws_internet_gateway" "immune-g2-igw-01" {
  vpc_id = aws_vpc.immune-g2-vpc-01.id
  tags = {
    "Name" = "immune-g2-igw-01"
  }
}

resource "aws_subnet" "immune-g2-public-subnet-01" {
  vpc_id                  = aws_vpc.immune-g2-vpc-01.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "immune-g2-public-subnet-01"
  }
}

resource "aws_subnet" "immune-g2-public-subnet-02" {
  vpc_id                  = aws_vpc.immune-g2-vpc-01.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "immune-g2-public-subnet-02"
  }
}

resource "aws_subnet" "immune-g2-private-web-subnet-01" {
  vpc_id                  = aws_vpc.immune-g2-vpc-01.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "immune-g2-private-web-subnet-01"
  }
}

resource "aws_subnet" "immune-g2-private-web-subnet-02" {
  vpc_id                  = aws_vpc.immune-g2-vpc-01.id
  cidr_block              = "10.0.20.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "immune-g2-private-web-subnet-02"
  }
}

resource "aws_subnet" "immune-g2-private-app-subnet-01" {
  vpc_id            = aws_vpc.immune-g2-vpc-01.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "immune-g2-private-app-subnet-01"
  }
}

resource "aws_subnet" "immune-g2-private-app-subnet-02" {
  vpc_id            = aws_vpc.immune-g2-vpc-01.id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "us-east-1b"
  tags = {
    "Name" = "immune-g2-private-app-subnet-02"
  }
}

resource "aws_subnet" "immune-g2-private-db-subnet-01" {
  vpc_id            = aws_vpc.immune-g2-vpc-01.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "immune-g2-private-db-subnet-01"
  }
}

resource "aws_subnet" "immune-g2-private-db-subnet-02" {
  vpc_id            = aws_vpc.immune-g2-vpc-01.id
  cidr_block        = "10.0.40.0/24"
  availability_zone = "us-east-1b"
  tags = {
    "Name" = "immune-g2-private-db-subnet-02"
  }
}

resource "aws_security_group" "immune-g2-web-sg-01" {
  name        = "immune-g2-web-sg-01"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.immune-g2-vpc-01.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "immune-g2-web-sg-01"
  }
}

resource "aws_security_group" "immune-g2-app-sg-01" {
  name        = "immune-g2-app-sg-01"
  description = "Security group for application servers"
  vpc_id      = aws_vpc.immune-g2-vpc-01.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.immune-g2-web-sg-01.id]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.2.0/24", # Private Web Subnet 01
      "10.0.20.0/24" # Private Web Subnet 02
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "immune-g2-app-sg-01"
  }
}

resource "aws_security_group" "immune-g2-db-sg-01" {
  name        = "immune-g2-db-sg-01"
  description = "Security group for databases"
  vpc_id      = aws_vpc.immune-g2-vpc-01.id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.immune-g2-app-sg-01.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "immune-g2-db-sg-01"
  }
}