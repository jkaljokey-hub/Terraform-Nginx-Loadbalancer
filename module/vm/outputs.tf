output "private_ips" {
  value = [
    for nic in azurerm_network_interface.nic : nic.ip_configuration[0].private_ip_address
  ]
}

output "public_ip" {
  value = var.enable_public_ip ? azurerm_public_ip.pip[0].ip_address : null
}
