# variables.tf

variable "variable1" {
  description = "First Variable 1"
  type        = string
}

variable "variable2" {
  description = "Second Variable 2"
  type        = string
  default     = "Second Variable"  # 기본값 설정
}