module "vpc" {
  source = "git::git@bitbucket.org:brlink-cloud/terraform-aws-brlink-vpc.git?ref=2.0.0"

  vpc_cidr = "10.0.0.0/16"
  name     = "eks-airflow"
  vpc_name = "eks-airflow-network"
  # Por default é 1 NAT GW por AZ (Deixar true sempre em PRD)
  one_nat_gateway_per_az       = false
  public_subnets               = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  private_subnets              = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
  create_vpc_gateway_endpoints = false
  enable_flow_logs             = false
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  tags = {
    PoC       = "EKS Airflow",
    Descricao = "VPC para PoC EKS + Apache Airflow"
  }
}