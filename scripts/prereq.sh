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
if [ -f /usr/local/bin/docker-compose ];
then
  echo "Docker Compose is already installed"
else
  echo "Installing Docker Compose"
  sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
fi
if grep -q 'vm.max_map_count' /etc/sysctl.conf
then
  echo "VM Max Map Count already configured"
else
  echo "Setting vm.max_map_count to 262144"
  sudo sysctl -w vm.max_map_count=262144
  echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
fi
chown -R ${SUDO_USER}: /opt/elastic_stack
