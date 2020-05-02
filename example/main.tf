module "service-role" {
  source  = "yutaka0m/service-role/aws"
  version = "~> 1.0"

  iam_role_name = "TestRole"

  trusted_entity = "ecs-tasks.amazonaws.com"

  predefined_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]

  policies = [
    {
      name        = "ExamplePolicy"
      json_policy = data.aws_iam_policy_document.example.json
    },
  ]

  tags = {
    Terraform = true
  }
}

data "aws_iam_policy_document" "example" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
      "secretsmanager:GetSecretValue",
    ]
    resources = ["*"]
  }
}
