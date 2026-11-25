output "policy_arn" {
  value = aws_iam_policy.s3_read.arn
}

output "group_name" {
  value = aws_iam_group.s3_readers.name
}

output "user_arns" {
  value = { for k, u in aws_iam_user.this : k => u.arn }
}
