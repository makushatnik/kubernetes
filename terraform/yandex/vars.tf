# Variables

variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud id"
  default     = "b1go73u6atsru70ah8au"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex Cloud folder id"
  default     = "b1gsj6i3ai06iah2qgdj"
}

variable "service_account_id" {
  type        = string
  description = "Yandex Cloud service acccount id"
  default     = "aje0cnngl3uhbbfulkla"
}

variable "oauth_token" {
  type        = string
  description = "Yandex Cloud OAuth Token"
}