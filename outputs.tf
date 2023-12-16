output "web-server-id" {
  value = module.instances.frontend_instance_id
}

output "server-id" {
  value = module.instances.backend_instance_id
}

output "database-id" {
  value = module.instances.database_instance_id
}