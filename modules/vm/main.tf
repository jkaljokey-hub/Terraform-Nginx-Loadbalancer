provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  vnet_name     = "nginx-vnet"
  address_space = ["10.0.0.0/16"]

  subnet_name   = "nginx-subnet"
  subnet_prefix = ["10.0.1.0/24"]
}

# NGINX Load Balancer VM
module "nginx_lb" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = module.network.subnet_id

  vm_name        = "nginx-lb"
  vm_size        = "Standard_B1s"
  vm_count       = 1
  admin_username = "azureuser"
  ssh_public_key = var.ssh_public_key

  enable_public_ip = true
  custom_data      = "scripts/nginx-lb.sh"
}

# Backend VMs
module "backend" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  subnet_id           = module.network.subnet_id

  vm_name        = "backend"
  vm_size        = "Standard_B1s"
  vm_count       = 2
  admin_username = "azureuser"
  ssh_public_key = var.ssh_public_key

  enable_public_ip = false
  custom_data      = "scripts/backend.sh"
}
