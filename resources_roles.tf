resource "aws_iam_role" "platform_service_roles" {
  lifecycle {
    ignore_changes          = [ tags ]
  }
  for_each                  = local.platform_service_roles

  name                      = each.value.name
  assume_role_policy        = each.value.assume_role_policy
  tags                      = local.tags
}

resource "aws_iam_instance_profile" "instance_profiles" {
  for_each                  = { for k,v in local.platform_service_roles: 
                                  k => v if v.instance_profile }

  name                      = each.value.name
  role                      = each.value.name
}

resource "aws_iam_role_policy_attachment" "service_role_attachments" {
  for_each                  = { for k,v in local.platform_service_role_attachments: 
                                  k => v }

  policy_arn                = each.value.policy_arn
  role                      = each.value.role_name
}