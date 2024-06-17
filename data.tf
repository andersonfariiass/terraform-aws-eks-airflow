data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_name
}

#################################################################################################################
# Se o deploy for na conta PoC da Brlink esse bloco de codigo apoia a criação de um DNS e pega o certificado ssl#
#################################################################################################################

# Find a certificate that is issued
# data "aws_acm_certificate" "issued" {
#   domain   = "*.webc2aws.online"
#   statuses = ["ISSUED"]
# }

# data "aws_route53_zone" "selected" {
#   name         = "webc2aws.online"
#   private_zone = false
# }

# Busca o DNS do loadbalancer 
data "aws_lb" "load_balancer" {
  tags = {
    "elbv2.k8s.aws/cluster" = "brlink-eks-airflow"
  }
  depends_on = [kubernetes_ingress_v1.airflow_ingress]
}