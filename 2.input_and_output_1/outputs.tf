# outputs.tf

output "variable1_output" {
  description = "The name of the EC2 instance provided by the user"
  value       = var.variable1  # 입력된 변수값을 출력
}

output "variable2_output" {
  description = "The name of the EC2 instance provided by the user"
  value       = var.variable2  # 입력된 변수값을 출력
}