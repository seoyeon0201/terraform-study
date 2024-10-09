# provider.tf

terraform {
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~> 5.0"
		}
	}
}

provider "aws" {
	profile = "terraform_prof" #aws configure --profile에서 설정한 profile
	region = "ap-northeast-2"
}