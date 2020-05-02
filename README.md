# terraform-aws-service-role

A Terraform module that create service role with provided JSON IAM policy documents or predefined policy.

## Usage

```hcl
module "service-role" {
  source  = "yutaka0m/service-role/aws"
  version = "1.0.0"

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
```

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.6 |
| aws | ~> 2.42 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.42 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | The description of the role and the policy. | `string` | `"Managed by Terraform"` | no |
| force\_detach\_policies | Specifies to force detaching any policies the role has before destroying. | `bool` | `false` | no |
| iam\_role\_name | IAM role name | `string` | n/a | yes |
| max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. | `number` | `3600` | no |
| path | Path in which to create the role and the policy | `string` | `"/"` | no |
| policies | name: Policy name / policy\_json: IAM JSON Policy | <pre>list(object({<br>    name        = string<br>    json_policy = string<br>  }))</pre> | `[]` | no |
| predefined\_policy\_arns | List of predefined policy ARN | `list(string)` | `[]` | no |
| tags | A map of tags to use on IAM Role | `map(string)` | `{}` | no |
| trusted\_entity | The identity provider | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| iam\_role\_arn | IAM role arn |
| policy\_arns | List of ARNs of policies |
