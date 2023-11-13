#!/bin/bash
source .env
cd terraform/yandex
terraform apply --auto-approve
