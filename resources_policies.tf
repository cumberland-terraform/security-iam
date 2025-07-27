resource "aws_iam_policy" "platform" {
    for_each    = local.platform_policies

    name        = lower("${module.platform.prefix}-${each.key}")
    path        = "/platform/"
    policy      = each.value
}