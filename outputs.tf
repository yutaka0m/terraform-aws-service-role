output "iam_role_arn" {
  description = "IAM role arn"
  value       = aws_iam_role.this.arn
}

output "policy_arns" {
  description = "List of ARNs of policies"
  value       = aws_iam_policy.policies.*.arn
}
