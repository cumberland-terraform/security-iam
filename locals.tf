locals {

    ## CALCULATED PROPERTIES
    # Variables that store local calculations that change based on the 
    #   the deployment configuration.
    tags                        = merge(var.iam.tags, module.platform.tags)
}