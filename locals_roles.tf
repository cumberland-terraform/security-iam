locals {
    assume_role_templatefile = "${path.module}/policies/sts/ASSUME-ROLE.tftpl"
    
    ## ROLE CONFIGURATION
    # Map of services roles used to generated IAM roles
    #   ``<service_role>``: 
    #       1. ``name``: Physical name assigned to role.
    #       2. ``instance_profile``: `bool` that associates an instance profile to role.
    #       3. ``assume_role_policy``: JSON text containing assume role policy statement.
    #       4. ``policy_attachments``: List of policy ARNs to attach to role.
    platform_service_roles             = {
        # EKS Cluster Control Plane Role
        eks_cluster             = {
            name                    = "${local.platform_role_prefix}-MEKS"
            assume_role_policy      = templatefile(
                                        local.assume_role_templatefile,
                                        { svc = "eks" }
                                    )
            policy_attachments      = [
                # AWS Managed Policies
                "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
                "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
                # Platform Policies
            ]
        }
        # EKS Worker Node Role
        eks_worker_node             = {
            name                    = "${local.platform_role_prefix}-WEKS"
            instance_profile        = true
            assume_role_policy      = templatefile(
                                        local.assume_role_templatefile,
                                        { svc = "ec2" }
                                    )
            policy_attachments      = [
                # AWS Managed Policies
                "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
                "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
                "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
                "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
                "arn:aws:iam::aws:policy/AmazonS3FullAccess",
                "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
                "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess",
                # Platform Policies
                aws_iam_policy.platform_policies["AWS-TAG"].arn
            ]
        }
        eks_splunk                  = {
            name                    = "${local.platform_role_prefix}-SPNK-EKS"
            assume_role_policy      = templatefile(
                                        local.assume_role_templatefile,
                                        {
                                            # TODO
                                            aws     = "<JENKINS-EKS-ROLE-ARN-GOES-HERE>"
                                            svc     = "eks"
                                        }
                                    )
            policy_attachments      = [
                # AWS Managaed Policies

                # Platform Policies
                aws_iam_policy.platform_policies["AWS-TAG"].arn
            ]
        }

        ## TODO: this is going to be decommissioned once Jenkins no longer manages EKS deployments...
        # EKS Jenkins Role
        eks_jenkins                 = {
            name                    = "${local.platform_role_prefix}-JENK-EKS"
            assume_role_policy      = templatefile(
                                        local.assume_role_templatefile,
                                        # TODO: inquire as to the purpose of the trust relationship
                                        #       for this role. curious. very curious.
                                        { principal = "<jenkins-slave-access-key-id-goes-here>"}
                                    )
            policy_attachments      = [
                # AWS Managed Policies
                "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
                "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role",
                "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
                # Platform Policies
            ]

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