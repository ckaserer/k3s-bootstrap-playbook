#!/bin/bash

if [[ -z "${BASH_SOURCE[0]+x}" ]]; then
  CICD_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
  PLAYBOOK_HOME=$( cd "${CICD_HOME}" && cd .. && pwd )
fi

cp ${CICD_HOME}/config.yml ${PLAYBOOK_HOME}/config.yml


pip3 install -r ${PLAYBOOK_HOME}/requirements.txt
ansible-galaxy install -f -r ${PLAYBOOK_HOME}/requirements.yml
ansible-playbook ${PLAYBOOK_HOME}/playbook.yml -i ${CICD_HOME}/hosts.ini --skip-tags notest

rm ${PLAYBOOK_HOME}/config.yml