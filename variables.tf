variable "platform" {
  description                                   = "Platform metadata configuration object."
  type                                          = object({
    client                                      = string 
    environment                                 = string
  })
}


variable "iam" {
  description                           = "IAM configuration object."
  type                                  = object({
    tags                                = optional(map(string), {})
  })
}
