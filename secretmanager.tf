# Secret Manager Secret
resource "aws_secretsmanager_secret" "immune-g2-secret-01" {
  name = "/api/rds/immune-g2-rds-credentials"
}