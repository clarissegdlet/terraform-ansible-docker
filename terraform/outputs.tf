output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.app_container.id
}

output "container_name" {
  description = "Name of the Docker container"
  value       = docker_container.app_container.name
}

output "external_port" {
  description = "Exposed external port"
  value       = var.external_port
}

output "service_url" {
  description = "URL of the exposed service"
  value       = "http://localhost:${var.external_port}"
}
