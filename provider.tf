terraform {
2    required_providers {
3        vkcs = {
4            source = "vk-cs/vkcs"
5        }
6    }
7}

provider "vkcs" {
    username   = "USER_NAME"
    password   = "YOUR_PASSWORD"
    project_id = " 111111111111111111111111111"
    region     = "RegionOne"
    token      = var.vk_token
    cloud_id   = var.vk_cloud_id
    folder_id  = var.vk_folder_id
}
