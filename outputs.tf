output "nginx_public_ip" {
  value = module.nginx_lb.public_ip
}

output "backend_private_ips" {
  value = module.backend.private_ips
}
