provider "azurerm" {}

terraform {
  backend "azurerm" {}
  required_version = ">= 0.12"
}

resource "azurerm_resource_group" "acidemobook" {
  name     = "demoBook"
  location = "westeurope"
}

variable "image_version" {
  description = "Tag of the image to deploy"
}

variable "dockerhub_username" {
  description = "DockerHub username"
}


resource "azurerm_container_group" "aci-myapp" {
  name                = "aci-app"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.acidemobook.name
  ip_address_type     = "public"
  dns_name_label      = "myapp-demo"
  os_type             = "linux"
  container {
    name   = "myappdemo"
    image  = "docker.io/${var.dockerhub_username}/demobook:${var.image_version}"
    cpu    = "0.5"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
