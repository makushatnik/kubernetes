#!/bin/bash
source .env
cd ansible
#ansible-playbook -i hosts.ini extra.yml
if [ -f ~/config ]; then
  export KUBE_CONFIG=$(cat ~/config | base64)
  curl -s -o /dev/null -w "%{http_code}" -X PUT -H "PRIVATE-TOKEN: $GITLAB_GLOBAL_TOKEN" \
     "https://gitlab.com/api/v4/projects/$GITLAB_PROJECT_ID/variables/KUBE_CONFIG" --form "value=$KUBE_CONFIG" ; echo
else
  echo "File config not found"
fi
echo "Ready!!!"
