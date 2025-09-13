data "aws_iam_policy_document" "openid_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.openid_provider.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.sub_conditions
    }
  }
}

data "aws_iam_policy_document" "openid_policy" {
  statement {
    effect    = "Allow"
    actions   = var.policy_actions
    resources = var.policy_resources
  }
}

data "aws_iam_policy_document" "aws_github_openid_provisional_doc" {
  statement {
    actions   = ["*"]
    resources = ["*"]
    effect    = "Allow"
    sid       = "VisualEditor0"
  }
}