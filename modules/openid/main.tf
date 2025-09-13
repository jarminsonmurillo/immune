resource "aws_iam_openid_connect_provider" "openid_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = var.thumbprint_list
  url             = var.url
}

resource "aws_iam_role" "openid_role" {
  assume_role_policy   = data.aws_iam_policy_document.openid_assume_role.json
  description          = var.description
  max_session_duration = var.max_session_duration
  name                 = var.role_name
  path                 = var.role_path
}

resource "aws_iam_policy" "openid_policy" {
  name   = var.policy_name
  path   = var.policy_path
  policy = data.aws_iam_policy_document.openid_policy.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.openid_role.name
  policy_arn = aws_iam_policy.openid_policy.arn
}


# Provisional

resource "aws_iam_policy" "aws_github_openid_provisional" {
  name   = "Github-AWS-Deployment-Actions-Policy-Provisional"
  path   = var.policy_path
  policy = data.aws_iam_policy_document.aws_github_openid_provisional_doc.json
}


resource "aws_iam_role_policy_attachment" "aws_github_openid_provisional" {
  role       = aws_iam_role.openid_role.name
  policy_arn = aws_iam_policy.aws_github_openid_provisional.arn
}

