resource "aws_iam_policy" "platform" {
    for_each    = local.platform_policies

    name        = "${local.platform_policy_prefix}-${each.key}"
    path        = "/platform/"
    policy      = each.value
}