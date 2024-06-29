locals {
  service_roles             = {
    eks_worker_node         = {
      name                  = join(
                              "-",
                              [
                                "IMR",
                                module.platform.agency.abbr,
                                module.platform.account.threeletterkey,
                                module.platform.acct_env.threeletterkey,
                                module.platform.app.fourletterkey
                              ]
                            )
      assume_role_policy    = file("${path.module}/policies/sts/ec2.json")
    }
  }
}

resource "aws_iam_role" "service_roles" {
  for_each                  = local.service_roles

  name                      = each.value.name
  assume_role_policy        = each.value.assume_role_policy
}