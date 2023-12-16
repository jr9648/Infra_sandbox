
resource "aws_instance" "database" {
  ami           = var.database_ami_id
  instance_type = var.database_instance_type  # Use the database instance type variable
  key_name      = module.ssh.ssh-key-name
  security_groups = [module.sg.database]
  tags = {
    Name = "database-instance"
    Layer = "database"
  }
  user_data = "${file("./scripts/database.sh")}"
}
