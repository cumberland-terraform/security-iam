locals {

    ## CALCULATED PROPERTIES
    # Variables that store local calculations that change based on the 
    #   the deployment configuration.
    tags                        = merge({
        PrimaryContact          = var.iam_config.tags.contact
        CrossAccountRole        = var.iam_config.tags.cross_account_role
        AutoCleanup             = var.iam_config.tags.auto_cleanup
    }, module.platform.tags)
}