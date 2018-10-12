if [[ $BUILDARCH == "arm64" ]]; then
  echo "deb http://ports.ubuntu.com/ubuntu-ports/ trusty main restricted" >> /etc/apt/sources.list
  echo "deb-src http://ports.ubuntu.com/ubuntu-ports/ trusty main restricted" >> /etc/apt/sources.list
  echo "deb http://ports.ubuntu.com/ubuntu-ports/ trusty-updates main restricted" >> /etc/apt/sources.list
  echo "deb-src http://ports.ubuntu.com/ubuntu-ports/ trusty-updates main restricted" >> /etc/apt/sources.list
  echo "deb http://ports.ubuntu.com/ubuntu-ports/ trusty universe" >> /etc/apt/sources.list
  echo "deb-src http://ports.ubuntu.com/ubuntu-ports/ trusty universe" >> /etc/apt/sources.list
  echo "deb http://ports.ubuntu.com/ubuntu-ports/ trusty-updates universe" >> /etc/apt/sources.list
  echo "deb-src http://ports.ubuntu.com/ubuntu-ports/ trusty-updates universe" >> /etc/apt/sources.list
  echo "deb http://ports.ubuntu.com/ubuntu-ports/ trusty multiverse" >> /etc/apt/sources.list
  echo "deb-src http://ports.ubuntu.com/ubuntu-ports/ trusty multiverse" >> /etc/apt/sources.list
  echo "deb http://ports.ubuntu.com/ubuntu-ports/ trusty-updates multiverse" >> /etc/apt/sources.list
  echo "deb-src http://ports.ubuntu.com/ubuntu-ports/ trusty-updates multiverse" >> /etc/apt/sources.list
fi