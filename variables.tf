variable "platform" {
  description                           = "Platform configuration metadata."
  type                                  = object({
    core_aws_id                         = string
    tenant_aws_id                       = string
    aws_region                          = string 
    account                             = string
    acct_env                            = string
    agency                              = string
    program                             = string
    app                                 = string
    app_env                             = string
    pca                                 = string
  })
}

variable "iam_config" {
  description                           = "IAM Configuration."
  type                                  = object({
    tags                                = {
      owner                             = string
      contact                           = string
      cross_account_role                = bool
      auto_cleanup                      = bool
    }
  })
}
