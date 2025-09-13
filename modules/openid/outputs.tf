output "role_arn" {
  description = "ARN of the created IAM role"
  value       = aws_iam_role.openid_role.arn
}

output "policy_arn" {
  description = "ARN of the created IAM policy"
  value       = aws_iam_policy.openid_policy.arn
}