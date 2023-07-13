variable "image_flavor" {
  type = string
  default = "Ubuntu-22.04-202208"
}

variable "compute_flavor" {
  type = string
  default = "Basic-1-2-20"
}

# variable "key_pair_name" {
#   type = string
#   default = "keypair-terraform"
# }

variable "availability_zone_name" {
  type = string
  default = "MS1"
}

variable "username" {
    type = string
}

variable "password" {
    type = string
    sensitive = true
}

variable "project_id" {
    type = string
}

variable "region" {
    type = string
}

variable "auth_url" {
    type = string
    default = "https://infra.mail.ru:35357/v3/"
}
