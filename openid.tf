module "openid_immune_g2" {
  source           = "./modules/openid"
  thumbprint_list  = ["ffffffffffffffffffffffffffffffffffffffff"]
  url              = "https://token.actions.githubusercontent.com"
  role_name        = "GitHub-AWS-Role-Immune-G2"
  role_path        = "/immune/"
  policy_name      = "GitHub-Policy-Immune-G2"
  policy_path      = "/immune/"
  description      = "GitHub Actions Role for Capstone Project Immune G2"
  sub_conditions   = ["repo:jarminsonmurillo/immune/*"]
  policy_actions   = ["s3:ListAllMyBuckets", "s3:ListBucket"]
  policy_resources = ["*"]
}