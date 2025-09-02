resource "aws_db_instance" "immune-g2-rds-primary-01" {
  allocated_storage    = 20
  engine               = "sqlserver-ex"
  engine_version       = "15.00" # Replace with the latest version if needed
  instance_class       = "db.t3.micro"

  max_allocated_storage = 100                     # autoscaling de almacenamiento
  storage_type         = "gp3"
  storage_encrypted    = true

  username             = "admin01"
  password             = "admin0123456789!"
  license_model        = "license-included"
  port                 = 1433

  db_subnet_group_name = aws_db_subnet_group.immune-g2-rds-subnet-group-01.name
  multi_az             = false
  publicly_accessible  = false
  skip_final_snapshot = "true"
  tags = {
    "name" = "immune-g2-rds-primary-01"
  }
}

resource "aws_db_instance" "immune-g2-rds-replica-01" {
  replicate_source_db = aws_db_instance.immune-g2-rds-primary-01.id
  instance_class      = "db.t3.micro"
  publicly_accessible = false
  skip_final_snapshot = "true"
  tags = {
    "name" = "immune-g2-rds-replica-01"
  }
}

resource "aws_db_subnet_group" "immune-g2-rds-subnet-group-01" {
  name = "immune-g2-rds-subnet-group-01"
  subnet_ids = [
    aws_subnet.immune-g2-private-db-subnet-01.id,
    aws_subnet.immune-g2-private-db-subnet-02.id
  ]
  tags = {
    "name" = "immune-g2-rds-subnet-group-01"
  }
}

resource "aws_elasticache_cluster" "immune-g2-cache-01" {
  cluster_id           = "immune-g2-cache-01"
  engine               = "redis"
  engine_version       = "7.0" # Replace with the latest version if needed
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  subnet_group_name    = aws_elasticache_subnet_group.immune-g2-cache-subnet-group-01.name
  parameter_group_name = "default.redis7"

  tags = {
    "name" = "immune-g2-cache-01"
  }
}

resource "aws_elasticache_subnet_group" "immune-g2-cache-subnet-group-01" {
  name = "immune-g2-cache-subnet-group-01"
  subnet_ids = [
    aws_subnet.immune-g2-private-db-subnet-01.id,
    aws_subnet.immune-g2-private-db-subnet-02.id
  ]

  tags = {
    "name" = "immune-g2-cache-subnet-group-01"
  }
}