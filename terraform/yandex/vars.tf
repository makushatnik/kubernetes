# Variables

variable "yc_token" {
  type        = string
  description = "Yandex Cloud API key"
  default     = "TOKEN_CHANGE_ME"
}

variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud id"
  default     = "CLOUD_ID_CHANGE_ME"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex Cloud folder id"
  default     = "FOLDER_ID_CHANGE_ME"
}

variable "service_account_id" {
  type        = string
  description = "Yandex Cloud service acccount id"
  default     = "SERVICE_ACCOUNT_ID_CHANGE_ME"
}