variable "image" {
  description = "Docker image to deploy"
  type        = string
  default     = "nginx:latest"
}

variable "container_name" {
  description = "Name of the Docker container"
  type        = string
}

variable "external_port" {
  description = "Port exposed on localhost"
  type        = number
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}
