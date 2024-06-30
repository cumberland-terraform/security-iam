resource "aws_iam_policy" "platform" {
    for_each    = local.platform_policies

    name        = "${module.platform.prefixes.identity.policy}-${each.key}"
    path        = "/platform/"
    policy      = each.value
}