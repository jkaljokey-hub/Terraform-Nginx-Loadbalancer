variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "subnet_id" { type = string }

variable "vm_name" { type = string }
variable "vm_size" { type = string }
variable "vm_count" { type = number }

variable "admin_username" { type = string }
variable "ssh_public_key" { type = string }

variable "enable_public_ip" { type = bool }
variable "custom_data" { type = string }
