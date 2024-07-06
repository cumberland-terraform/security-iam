variable "platform" {
  description                           = "Platform metadata configuration object. See [Platform Module] (https://source.mdthink.maryland.gov/projects/ET/repos/mdt-eter-platform/browse) for detailed information about the permitted values for each field."
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
  description                           = "IAM configuration object."
  type                                  = object({
    tags                                = {
      owner                             = string
      contact                           = string
      cross_account_role                = bool
      auto_cleanup                      = bool
    }
  })
}
