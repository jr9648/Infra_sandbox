
resource "aws_instance" "frontend" {
  ami           = var.frontend_ami_id
  instance_type = var.frontend_instance_type  # Use the frontend instance type variable
  key_name      = module.ssh.ssh-key-name
  security_groups = [module.sg.frontend-backend]
  tags = {
    Name = "frontend-instance"
    Layer = "frontend"
  }
  user_data = "${file("./scripts/frontend.sh")}"
}
