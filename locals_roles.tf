locals {

    ## ROLE CONFIGURATION
    # Map of services roles used to generated IAM roles
    #   ``<service_role>``: 
    #       1. ``name``: Physical name assigned to role.
    #       2. ``instance_profile``: `bool` that associates an instance profile to role.
    #       3. ``assume_role_policy``: JSON text containing assume role policy statement.
    #       4. ``policy_attachments``: List of policy ARNs to attach to role.
    service_roles             = {
        eks_cluster             = {
            name                    = "${local.role_prefix}-EKS-CLUSTER"
            assume_role_policy      = templatefile(
                                        "${path.module}/policies/sts/assume_role.tftpl",
                                        { principal = "eks" }
                                    )
            policy_attachments      = [
                "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
                "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
            ]
        }
        eks_worker_node         = {
            name                  = "${local.role_prefix}-EKS-WORKER"
            instance_profile      = true
            assume_role_policy    = templatefile(
                                        "${path.module}/policies/sts/assume_role.tftpl",
                                        { principal = "ec2" }
                                    )
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

    # This is a technique for generating a flat list of { role, policy } objects
    #   so the ``aws_iam_role_policy_attachment`` resources can be generated more
    #   efficiently. This local should not be altered. If you need to add a role
    #   to a baseline deployment, do so through the `service_roles` map above.
    #   Likewise with any policies that need attached to service roles.
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