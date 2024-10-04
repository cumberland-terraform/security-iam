locals {

    ## CALCULATED PROPERTIES
    # Variables that store local calculations that change based on the 
    #   the deployment configuration.
    tags                        = merge({
        Owner                   = var.iam.tags.owner
        PrimaryContact          = var.iam.tags.primary_contact
        CrossAccountRole        = var.iam.tags.cross_account
        AutoCleanup             = var.iam.tags.auto_cleanup
    }, module.platform.tags)
}