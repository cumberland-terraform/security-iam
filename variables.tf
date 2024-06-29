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

variable "eks_config" {
  description                           = "IAM configuration for EKS deployments."
  type                                  = object({
    cluster                             = object({
      id                                = string
    })
  })
}
