#!/bin/bash
set -x
sudo apt-get update

# install linux tools
# sudo apt-get install -y ?? git vim, et al.

# install bosh create-env dependencies
sudo apt-get install -y build-essential zlibc zlib1g-dev \
ruby ruby-dev openssl libxslt-dev libxml2-dev libssl-dev \
libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev sqlite3


# install Azure CLI
echo "azure cli is now installing!"
sudo echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | \
   sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y azure-cli

# install AWS CLI
echo "AWS CLI is now installing!"
wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -b /usr/local/bin/aws

# install yaml patch
echo "yaml patch is now installing!"
wget https://github.com/krishicks/yaml-patch/releases/download/v0.0.10/yaml_patch_linux
chmod +x yaml_patch_linux
sudo mv yaml_patch_linux /usr/local/bin/yaml_patch

# install bosh2
echo "bosh cli is now installing!"
sudo wget -q -O /usr/local/bin/bosh https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-2.0.48-linux-amd64
sudo chmod +x /usr/local/bin/bosh

# install credhub cli
echo "credhub cli is now installing!"
wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/1.5.3/credhub-linux-1.5.3.tgz
tar xvzf credhub-linux-1.5.3.tgz
sudo mv credhub /usr/local/bin/credhub

# Install jq
echo "jq now installing!"
sudo wget -q -O /usr/local/bin/jq $(curl -s https://api.github.com/repos/stedolan/jq/releases/latest | grep "browser_download_url" | grep "jq-linux64" | cut -d '"' -f4)
sudo chmod +x /usr/local/bin/jq

# Install minio client
echo "mc now installing!"
sudo wget -O /usr/local/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc
sudo chmod +x /usr/local/bin/mc

# Check to see if there is a pip update available
#pip install --upgrade pip
# Install the AWS CLI
#pip install awscli

echo "Spiff now installing!"
wget -q -O spiff.zip "$(curl -s https://api.github.com/repos/cloudfoundry-incubator/spiff/releases/latest | jq -r '.assets[] | select(.name == "spiff_linux_amd64.zip") | .browser_download_url')"
unzip spiff.zip
sudo mv spiff /usr/local/bin/
rm spiff.zip

echo "Spruce now installing!"
sudo wget -q -O /usr/local/bin/spruce "$(curl -s https://api.github.com/repos/geofffranks/spruce/releases/latest | jq --raw-output '.assets[] | .browser_download_url' | grep linux | grep -v zip)"
sudo chmod +x /usr/local/bin/spruce

echo "yaml2json now installing!"
sudo wget -O /usr/local/bin/yaml2json https://github.com/bronze1man/yaml2json/blob/master/builds/linux_amd64/yaml2json?raw=true
sudo chmod +x /usr/local/bin/yaml2json

echo "vault now installing!"
wget -q -O vault.zip $(curl -s https://www.vaultproject.io/downloads.html | grep linux_amd | awk -F "\"" '{print$2}')
unzip vault.zip
sudo mv vault /usr/local/bin/
rm vault.zip

echo "fly now installing!"
sudo wget -q -O /usr/local/bin/fly https://github.com/concourse/concourse/releases/download/v3.8.0/fly_linux_amd64
sudo chmod +x /usr/local/bin/fly

echo "terraform now installing!"
wget -O terraform.zip https://releases.hashicorp.com/terraform/0.11.4/terraform_0.11.4_linux_amd64.zip
unzip terraform.zip
chmod +x terraform
sudo mv terraform /usr/local/bin
