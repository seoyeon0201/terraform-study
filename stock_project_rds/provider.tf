# provider.tf

provider "aws" {
    profile = "stocks_sy"
    region = var.region  # 한국 리전 사용
}