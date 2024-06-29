locals {

    ## ROLE CONFIGURATION
    # Map of services roles used to generated IAM roles
    #   ``name``: Physical name assigned to role.
    #   ``instance_profile``: `bool` that associates an instance profile to role.
    #   ``assume_role_policy``: JSON text containing assume role policy statement.
    #   ``policy_attachments``: List of policy ARNs to attach to role.
    service_roles             = {
        eks_worker_node         = {
            name                  = join(
                                    "-",
                                    [
                                        "IMR",
                                        module.platform.agency.abbr,
                                        module.platform.account.threeletterkey,
                                        module.platform.acct_env.threeletterkey,
                                        module.platform.app.fourletterkey
                                    ]
                                    )
            instance_profile      = true
            assume_role_policy    = file("${path.module}/policies/sts/ec2.json")
            policy_attachments    = [
                "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
                "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
                "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
                "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
                "arn:aws:iam::aws:policy/AmazonS3FullAccess",
                "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
                "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess",
                # need to codify this one: "arn:aws:iam::713371575757:policy/IMP-MDT-AWS-TAG"
            ]
        }
    }

    # This is a technique for generating a flat list of { role, policy } so
    #   the ``aws_iam_role_policy_attachment`` resources can be generated more
    #   efficiently. This local should not be altered. If you need to add a role
    #   to a baseline deployment, do so through the `service_roles` map above.
    # See: https://developer.hashicorp.com/terraform/language/functions/flatten
    service_role_attachments  = flatten([
        for r_key, role in local.service_roles: [
        for policy in role.policy_attachments: {
            role_name           = role.name
            policy_arn          = policy
        } 
        ]
    ])
}