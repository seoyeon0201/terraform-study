data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
}

# Secret 생성
resource "kubernetes_secret" "app_secret" {
  metadata {
    name = "app-secret"
  }

  data = {
    kis_api_appKey    = var.app_key
    kis_api_appSecret = var.app_secret
    kis_api_baseUrl = "jdbc:mysql://${aws_db_instance.default.endpoint}:3306/stockdatabase?serverTimezone=Asia/Seoul"
    db_username       = var.rds_username
    db_password       = var.rds_password
  }

  type = "Opaque"
}

# RDS 연결 sa 생성
resource "kubernetes_service_account" "rds_access_sa" {
  metadata {
    name      = "rds-access-sa"
    namespace = "default"  # 서비스 계정이 속할 네임스페이스 지정
    annotations = {
      "eks.amazonaws.com/role-arn" = module.irsa-rds.iam_role_arn
    }
  }

}