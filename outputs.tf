output "service_roles" {
  description       = "Service role metadata."
  value             = {
    for key, role in aws_iam_role.platform_service_roles: 
        key         => {
            id      = role.id
            arn     = role.arn
        }
  }
}