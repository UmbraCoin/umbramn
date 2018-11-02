#/bin/bash

echo "*******************************"
echo "*                             *"
echo "*      Umbra Masternode       *"
echo "*           SETUP             *"
echo "*                             *"
echo "*******************************"
echo && echo && echo

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

IP==$(curl -s4 icanhazip.com)
echo -e "${GREEN}Please enter your private key: (Copy from Windows and right click to paste and press enter)${NC}" 
read KEY
sleep 2

sudo apt-get update -y &>/dev/null
sudo apt-get upgrade -y &>/dev/null
echo -e "${GREEN}Completion: 5%...${NC}"
sudo apt-get install libboost-all-dev libevent-dev software-properties-common -y &>/dev/null
sudo add-apt-repository ppa:bitcoin/bitcoin -y &>/dev/null
echo -e "${GREEN}Completion: 10%...${NC}"
sudo apt-get update &>/dev/null
echo -e "${GREEN}Completion: 20%...${NC}"
sudo apt-get install libdb4.8-dev libdb4.8++-dev -y &>/dev/null
echo -e "${GREEN}Completion: 30%...${NC}"
sudo apt-get install libpthread-stubs0-dev -y &>/dev/null
sudo apt-get install libzmq3-dev -y &>/dev/null
echo -e "${GREEN}Completion: 40%...${NC}"
sudo apt install -y make build-essential libtool software-properties-common autoconf libssl-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev \
libboost-program-options-dev libboost-system-dev libboost-test-dev libboost-thread-dev sudo automake git curl libdb4.8-dev \
bsdmainutils libdb4.8++-dev libminiupnpc-dev libgmp3-dev ufw pkg-config libevent-dev libdb5.3++ unzip libzmq5 &>/dev/null
echo -e "${GREEN}Completion: 75%...${NC}"

sleep 2
cd /var
sudo touch swap.img &>/dev/null
sudo chmod 600 swap.img &>/dev/null
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000 &>/dev/null
sudo mkswap /var/swap.img &>/dev/null
sudo swapon /var/swap.img &>/dev/null
sudo free &>/dev/null
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab &>/dev/null
echo -e "${GREEN}Completion: 85%...${NC}"
cd
sleep 2
sudo apt-get install -y ufw &>/dev/null
sudo ufw allow ssh/tcp &>/dev/null
sudo ufw limit ssh/tcp &>/dev/null
sudo ufw allow 11234/tcp &>/dev/null
sudo ufw logging on &>/dev/null
echo "y" | sudo ufw enable &>/dev/null
echo -e "${GREEN}Completion: 90%...${NC}"
sleep 2
sudo chmod +x /root/umbramn/umbrad /root/umbramn/umbra-cli
sudo mv /root/umbramn/umbrad /root/umbramn/umbra-cli /usr/local/bin
sleep 2
sudo mkdir /root/.umbra
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> /root/.umbra/umbra.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> /root/.umbra/umbra.conf
echo "rpcallowip=127.0.0.1" >> /root/.umbra/umbra.conf
echo "listen=1" >> /root/.umbra/umbra.conf
echo "server=1" >> /root/.umbra/umbra.conf
echo -e "${GREEN}Completion: 95%...${NC}"
echo "daemon=1" >> /root/.umbra/umbra.conf
echo "maxconnections=250" >> /root/.umbra/umbra.conf
echo "masternode=1" >> /root/.umbra/umbra.conf
echo "masternodeaddr$IP:11234" >> /root/.umbra/umbra.conf
echo "externalip$IP:11234" >> /root/.umbra/umbra.conf
echo "masternodeprivkey=$KEY" >> /root/.umbra/umbra.conf
echo -e "${GREEN}Completion: 99%...${NC}"
cd /root
sudo umbrad &>/dev/null
echo -e "${GREEN}Completion: 100%...${NC}"
echo -e "Thank you for installing the Umbra wallet.  Please move onto the ${RED}NEXT${NC} step."
