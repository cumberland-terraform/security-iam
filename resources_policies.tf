resource "aws_iam_policy" "platform" {
    for_each    = local.platform_policies

    name        = lower("${module.platform.prefix}-${each.key}-POLICY")
    path        = "/platform/"
    policy      = each.value
}