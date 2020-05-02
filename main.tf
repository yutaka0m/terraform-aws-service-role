resource "aws_iam_role" "this" {
  name                  = var.iam_role_name
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  description           = var.description
  path                  = var.path
  max_session_duration  = var.max_session_duration
  force_detach_policies = var.force_detach_policies
  tags                  = var.tags
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = var.trusted_entity
    }
  }
}

# Attaching predefined policies to an IAM Role
resource "aws_iam_role_policy_attachment" "predefined_policies" {
  count = length(var.predefined_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = var.predefined_policy_arns[count.index]
}

# Create policies
resource "aws_iam_policy" "policies" {
  count = length(var.policies)

  name   = lookup(var.policies[count.index], "name")
  policy = lookup(var.policies[count.index], "json_policy")

  description = var.description
}

# Attaching policies to an IAM Role
resource "aws_iam_role_policy_attachment" "policies" {
  count = length(var.policies)

  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.policies[count.index].arn
}
