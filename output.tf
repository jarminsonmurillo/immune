# Output OpenID Connect Provider ARN
output "role_arn_immune_g2" {
  description = "ARN of the created IAM role"
  value       = module.openid_immune_g2.role_arn
}