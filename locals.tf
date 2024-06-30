locals {

    ## CALCULATED PROPERTIES
    # Variables that store local calculations that change based on the 
    #   the deployment configuration.
    tags                        = {
        Owner                   = var.iam_config.tags.owner
        Account                 = module.platform.account.threeletterkey
        Agency                  = module.platform.agency.abbr
        Program                 = module.platform.program.key
        Purpose                 = var.iam_config.tags.purpose
        "PCA Code"              = var.platform.pca
        CreationDate            = formatdate("YYYY-MM-DD", timestamp())
        PrimaryContact          = var.iam_config.tags.contact
        CrossAccountRole        = var.iam_config.tags.cross_account_role
        AutoCleanup             = var.iam_config.tags.auto_cleanup
    }
}