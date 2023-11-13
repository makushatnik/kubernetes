#!/bin/bash
source .env
cd terraform/yandex
terraform destroy --auto-approve
