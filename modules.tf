module "platform" {
  source                = "git::ssh://git@source.mdthink.maryland.gov:22/et/mdt-eter-platform.git"
  
  lookup                = var.platform
}