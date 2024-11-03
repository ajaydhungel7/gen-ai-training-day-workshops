# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Clone Repo
git clone https://github.com/opea-project/GenAIExamples.git

# Install Docker
cd GenAIExamples/ChatQnA/docker_compose
chmod +x ./install_docker.sh
./install_docker.sh

# Fix sudo for docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Set Envs
export HUGGINGFACEHUB_API_TOKEN=\$(aws ssm get-parameter --name /huggingface/api_token --with-decryption --query 'Parameter.Value' --output text)
export host_ip=$(hostname -I | awk '{print $1}')
export no_proxy="localhost"
chmod +x ./set_env.sh
source ./set_env.sh

# Start Docker
docker compose -f compose.yaml up -d