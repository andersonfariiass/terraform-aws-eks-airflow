module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  cluster_enabled_log_types       = var.cluster_enabled_log_types
  cloudwatch_log_group_kms_key_id = var.cloudwatch_log_group_kms_key_id
  enable_irsa                     = var.enable_irsa

  manage_aws_auth_configmap                        = true
  aws_auth_users                                   = var.aws_auth_users
  aws_auth_roles                                   = var.aws_auth_roles
  aws_auth_fargate_profile_pod_execution_role_arns = var.aws_auth_fargate_profile_pod_execution_role_arns

  cluster_tags = var.cluster_tags
  tags         = var.tags

  cluster_addons = {
    kube-proxy = {}
    vpc-cni    = {}
    coredns = {
      # configuration_values = jsonencode({
      #   computeType = "Fargate"
      # })
      timeouts = {
        create = "25m"
        delete = "10m"
      }
    }
  }

  # fargate_profiles = {
  # airflow = {
  #   selectors = [
  #     { namespace = "airflow" }
  #   ]
  # }
  #   kube_system = {
  #     name = "kube-system"
  #     selectors = [
  #       { namespace = "kube-system" }
  #     ]
  #   }
  # }

  eks_managed_node_groups = {
    nodegroup-eks-poc = {
      instance_types = ["t3.medium"]
      #capacity_type  = "SPOT"
      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
}