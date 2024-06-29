locals {

    ## CALCULATED PROPERTIES
    # Variables that store local calculations that change based on the 
    #   the deployment configuration.
    platform_policy_prefix      = upper(
                                    join(
                                        "-",
                                        [
                                            "IMP",
                                            module.platform.agency.abbr
                                        ]
                                    )
                                )
    platform_role_prefix        = upper(
                                    join(
                                        "-",
                                        [
                                            "IMR",
                                            module.platform.agency.abbr,
                                            module.platform.account.threeletterkey
                                        ]
                                    )
                                )
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