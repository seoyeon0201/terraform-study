# provider.tf

provider "aws" {
  profile = "terraform_prof"
  region = var.region  # 한국 리전 사용
}