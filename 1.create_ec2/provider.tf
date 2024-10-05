# provider.tf

provider "aws" {
	profile = "terraform_prof" #aws configure --profile에서 설정한 profile
	region = "ap-northeast-2"
}