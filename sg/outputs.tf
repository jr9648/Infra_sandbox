output "frontend-backend" {
  value = aws_security_group.frontend_backend_sg.name
}

output "database" {
  value = aws_security_group.database_sg.name
}