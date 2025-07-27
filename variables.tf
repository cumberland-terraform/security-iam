variable "platform" {
  description                           = "Platform metadata configuration object. See [Platform Module] (https://source.mdthink.maryland.gov/projects/etm/repos/mdt-eter-platform/browse) for detailed information about the permitted values for each field."
  type                                  = object({
    aws_region                          = string 
    account                             = string
    acct_env                            = string
    agency                              = string
    program                             = string
    app                                 = string
    app_env                             = string
  })
}

variable "iam" {
  description                           = "IAM configuration object."
  type                                  = object({
    tags                                = map(string)
  })
}
