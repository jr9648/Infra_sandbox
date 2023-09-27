provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAT4IGX6UNBGUPGQVL"
  secret_key = "HL5EYQN+LeVrQjwdIMl5Iljv0kAtoM2BzFML4xfS"
}

module "ec2_instances" {
  source = "./module/ec2-instances"  # Update this path to point to your module directory.

  frontend_ami_id     = "ami-053b0d53c279acc90"
  backend_ami_id      = "ami-053b0d53c279acc90"
  database_ami_id     = "ami-053b0d53c279acc90"
  frontend_instance_type = "t2.micro"  # Set the instance type for the frontend instance
  backend_instance_type  = "t2.micro"  # Set the instance type for the backend instance
  database_instance_type = "t2.micro"  # Set the instance type for the database instance
  
}