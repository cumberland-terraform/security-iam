locals {
    templatefile_vars               = {
        role_config                 = [
            {
                # Cluster Control Plane Node?
                rolearn             = "arn:aws:iam::713371575757:role/IMR-MDH-MHS-WRKS-EC2"
                username            = "system:node:{{EC2PrivateDNSName}}"
                groups              = [
                    "system:masters"
                ]
            },
            {
                # Worker Node Role
                rolearn             = "arn:aws:iam::713371575757:role/IMR-MDH-MHS-STG-WEKS-D01"
                username            = "system:node:{{EC2PrivateDNSName}}"
                groups              = [
                    "system:bootstrappers",
                    "system:nodes"
                ]
            },
            {
                # Jenkins Role?
                rolearn             = "arn:aws:iam::713371575757:role/IMR-MDT-MHS-JENK-EKS"
                username            = "user-mdt-jenk"
                groups              = [
                    "crle-mdt-jenk"
                ]
            },
            {
                # Splunk Role?
                rolearn             = "arn:aws:iam::713371575757:role/IMR-MDT-MHS-SPNK-EKS"
                username            = "user-mdt-spnk"
                groups              = [
                    "system:masters"
                ]
            },
            {
                # Devops Role?
                rolearn             = "arn:aws:iam::713371575757:role/IMR-MDT-MHS-WRKS-AGILE-EKS"
                username            = "user-mdt-agiledevops"
                groups              = [
                    "crle-mdt-agile-devops"
                ]
            },
            {
                # Splunk Enginer Role?
                rolearn             = "arn:aws:iam::713371575757:role/IMR-MDH-STG-WRKS-SPLK-EKS"
                username            = "user-mdt-splnk-engr"
                groups              = [
                    "crle-mdt-splnk-engr"
                ]
            }
        ]
    }
}