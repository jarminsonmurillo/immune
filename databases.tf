resource "aws_db_instance" "immune-g2-rds-primary-01" {
  allocated_storage    = 20
  engine               = "sqlserver-se"
  engine_version       = "15.00.4312.2.v1" # Replace with the latest version if needed
  instance_class       = "db.t3.micro"
  username             = "admin01"
  password             = "admin01"
  db_subnet_group_name = aws_db_subnet_group.immune-g2-rds-subnet-group-01.name
  multi_az             = false
  publicly_accessible  = false
}

resource "aws_db_instance" "immune-g2-rds-replica-01" {
  replicate_source_db  = aws_db_instance.immune-g2-rds-primary-01.id
  instance_class       = "db.t3.micro"
  publicly_accessible  = false
}

resource "aws_db_subnet_group" "immune-g2-rds-subnet-group-01" {
  name       = "immune-g2-rds-subnet-group-01"
  subnet_ids = [
    aws_subnet.immune-g2-private-db-subnet-01.id,
    aws_subnet.immune-g2-private-db-subnet-02.id
  ]
}

resource "aws_elasticache_cluster" "immune-g2-cache-01" {
  cluster_id           = "immune-g2-cache-01"
  engine               = "redis"
  engine_version       = "7.0" # Replace with the latest version if needed
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.immune-g2-cache-subnet-group-01.name
  parameter_group_name = "default.redis7"
}

resource "aws_elasticache_subnet_group" "immune-g2-cache-subnet-group-01" {
  name       = "immune-g2-cache-subnet-group-01"
  subnet_ids = [
    aws_subnet.immune-g2-private-db-subnet-01.id,
    aws_subnet.immune-g2-private-db-subnet-02.id
  ]
}