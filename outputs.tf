output "role_arn" {
  description = "Paste this on the praxis connect page."
  value       = aws_iam_role.praxis_audit.arn
}
