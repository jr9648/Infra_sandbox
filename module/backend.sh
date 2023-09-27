sudo -i
sudo apt-get update
sudo apt install unzip wget curl net-tools git -y
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo apt-get install docker-compose -y
cd /root
git clone -b develop https://github.com/prodevssp/superstar-backend.git

# https://<github-username>:<github-token>@github.com/<your-repository>.git

cd superstar-backend/
mkdir uploads/
unzip deploy/mnt.zip -d deploy/
unzip deploy/certs.zip -d deploy/
git pull origin feature/lcschatapp
git pull origin develop
echo y | docker system prune -a
docker-compose -f deploy/deploy.yml build --no-cache
docker-compose -f deploy/deploy.yml up -d
docker-compose -f deploy/deploy.yml logs -f