# provider.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.70.0"   # AWS 최신 버전으로 설정
    }
    google = {
      source  = "hashicorp/google"
      version = ">= 6.5.0"   # GCP 최신 버전으로 설정
    }
  }

  required_version = ">= 1.9.5" # terraform 최신 버전
}

provider "aws" {
  profile = "terraform_prof"
  region = "ap-northeast-2"  # 한국 리전 사용
}

provider "google" {
 credentials = "${file("../gcp-credentials.json")}"
 project     = "terraform-gcp-437815"
 region      = "southamerica-east1"
}