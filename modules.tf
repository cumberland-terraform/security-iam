module "platform" {
  source                = "git::ssh://git@source.mdthink.maryland.gov:22/et/mdt-eter-platform.git"
  
  lookup                = {
    aws_service         = "Elastic Kubernetes Service"
    aws_region          = var.platform.aws_region
    agency              = var.platform.agency
    program             = var.platform.program
    account             = var.platform.account
    acct_env            = var.platform.acct_env
    app                 = var.platform.app
    app_env             = var.platform.app_env
  }
}