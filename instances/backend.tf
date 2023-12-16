
resource "aws_instance" "backend" {
  ami           = var.backend_ami_id
  instance_type = var.backend_instance_type  # Use the backend instance type variable
  key_name      = module.ssh.ssh-key-name
  security_groups = [module.sg.frontend-backend]
  tags = {
    Name = "backend-instance"
    Layer = "backend"
  }
  user_data = "${file("./scripts/backend.sh")}"
}
