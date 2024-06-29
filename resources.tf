
resource "kubernetes_config_map" "iam_nodes_config_map" {
  data          = {
    mapRoles    = file("${path.module}/configmap/iam_nodes.yaml")

  }
  
  metadata {
    name        = "aws-auth"
    namespace   = "kube-system"
  }
}
