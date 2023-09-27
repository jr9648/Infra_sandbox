data "external" "load_env" {
  program = ["sh", "-c", "source .env && env"]
}

locals {
  aws_access_key = try(jsondecode(data.external.load_env.result)["AWS_ACCESS_KEY_ID"], "")
  aws_secret_key = try(jsondecode(data.external.load_env.result)["AWS_SECRET_ACCESS_KEY"], "")
}


provider "aws" {
  region     = "us-east-1"
  access_key = local.aws_access_key
  secret_key = local.aws_secret_key
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