locals {
    assume_role_templatefile = "${path.module}/policies/sts/ASSUME-ROLE.tftpl"
    
    ## ROLE CONFIGURATION
    # Map of services roles used to generated IAM roles
    #   ``<service_role>``: 
    #       1. ``name``: Physical name assigned to role.
    #       2. ``instance_profile``: `bool` that associates an instance profile to role.
    #       3. ``assume_role_policy``: JSON text containing assume role policy statement.
    #       4. ``policy_attachments``: List of policy ARNs to attach to role.
    platform_service_roles          = {
        ec2                         = {
            name                    = lower("${module.platform.prefix}-EC2-SVC")
            assume_role_policy      = templatefile(
                                        local.assume_role_templatefile,
                                        { svc = "ec2", aws = null }
                                    )
            policy_attachments      = [ ]
        }
        lambda                      = {
            name                    = lower("${module.platform.prefix}-LAMBDA-SVC")
            assume_role_policy      = templatefile(
                                        local.assume_role_templatefile,
                                        { svc = "lambda", aws = null}
                                    )
            policy_attachments      = [ ]
        }
    }

    ## INTERMEDIATE CALCULATION
    # This is a technique for generating a flat list of { role, policy } objects
    #   so the ``aws_iam_role_policy_attachment`` resources can be generated more
    #   efficiently. This local should not be altered. If you need to add a role
    #   to a baseline deployment, do so through the `service_roles` map above.
    #   Likewise with any policies that need attached to service roles.
    # See: https://developer.hashicorp.com/terraform/language/functions/flatten
    platform_service_role_attachments   = flatten([
        for r_key, role in local.platform_service_roles: [
            for policy in role.policy_attachments: {
                role_name               = role.name
                policy_arn              = policy
            } 
        ]
    ])
}