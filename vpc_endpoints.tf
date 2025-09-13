# VPC Endpoint para S3
resource "aws_vpc_endpoint" "immune-g2-s3-endpoint" {
  vpc_id       = aws_vpc.immune-g2-vpc-01.id
  service_name = "com.amazonaws.us-east-1.s3"
  tags = {
    Name = "immune-g2-endpoint-S3"
  }
}

resource "aws_vpc_endpoint_route_table_association" "immune-g2-s3-endpoint-association" {
  vpc_endpoint_id = aws_vpc_endpoint.immune-g2-s3-endpoint.id
  route_table_id  = aws_route_table.immune-g2-private-route-table.id
  depends_on      = [aws_vpc_endpoint.immune-g2-s3-endpoint]
}

# VPC Endpoints Interfacefor App

resource "aws_vpc_endpoint" "immune-g2-vpc-endpoints" {
  for_each            = { for svc in local.all_endpoints : svc => local.endpoints[svc] }
  vpc_id              = aws_vpc.immune-g2-vpc-01.id
  service_name        = each.key
  vpc_endpoint_type   = each.value
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.immune-g2-vpc-endpoint-sg.id]
  subnet_ids          = [aws_subnet.immune-g2-private-app-subnet-01.id, aws_subnet.immune-g2-private-app-subnet-02.id]

  tags = {
    Region = "us-east-1"
    Name   = "immune-g2-interface-endpoint ${upper(replace(each.key, "com.amazonaws.us-east-1.", ""))}"
  }
}

locals {
  endpoints = {
    "com.amazonaws.us-east-1.ec2"            = "Interface"
    "com.amazonaws.us-east-1.secretsmanager" = "Interface"
    "com.amazonaws.us-east-1.rds"            = "Interface"
    "com.amazonaws.us-east-1.ecs"            = "Interface"
  }

  interface_endpoints = [for svc, type in local.endpoints : svc if type == "Interface"]

  all_endpoints = keys(local.endpoints)
}

