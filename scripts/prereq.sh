#!/bin/bash
if [ ! -d /opt/elastic_stack ];
then
  echo "Cloning elastic_stack repo"
  cd /opt
  git clone https://github.com/scottl1736/elastic_stack.git
  chown -R ${SUDO_USER} /opt/elastic_stack
fi
if grep docker /etc/group | grep -q ${SUDO_USER}
then
  echo "Current user already member of docker group"
else
  echo "Adding current user to docker group"
  sudo usermod -aG docker ${SUDO_USER}
fi
chown -R ${SUDO_USER}: /opt/elastic_stack
