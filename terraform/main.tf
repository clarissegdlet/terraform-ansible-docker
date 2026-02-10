resource "docker_network" "app_network" {
  name = "net-${var.environment}"
}

resource "docker_volume" "app_volume" {
  name = "vol-${var.environment}"
}

resource "docker_image" "app_image" {
  name = var.image
}

resource "docker_container" "app_container" {
  name  = var.container_name
  image = docker_image.app_image.image_id

  restart = "always"

  networks_advanced {
    name = docker_network.app_network.name
  }

  volumes {
    volume_name    = docker_volume.app_volume.name
    container_path = "/usr/share/nginx/html"
  }

  ports {
    internal = 80
    external = var.external_port
  }
}
