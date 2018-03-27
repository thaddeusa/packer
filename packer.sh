#!/bin/bash
set -e

if [ $2 = "aws" ]; then
  env=aws
elif [ $2 = "azure" ]; then
  env=azure
elif [ $2 = "aws-azure" ]; then
  env=aws-azure
else
  echo "no match"
  exit 1
fi

function packer_validate () {
  if [[ $env == azure || $env == aws-azure ]]; then
    echo "azure image will be deleted on build"
  fi
  packer validate \
  -var-file=creds.json \
  $env.json
}


function packer_build () {
  if [[ $env == azure || $env == aws-azure ]]; then
    echo "deleting azure image..."
    az image delete -n taPackerImage -g tapacker-rg
  fi
  packer build -force \
  -var-file=creds.json \
  $env.json
}

function az-automation () {
  az-automation \
  -a 2c4abd34-0cef-4c27-b897-ccfe4ac01f56 \
  -d ta-packer \
  -i http://ta-packer \
  -c packer-creds.sh
}

case $1 in
  validate)
     packer_validate
     ;;
  build)
     packer_build
     ;;
  *) echo "invalid option"
     exit
     ;;
esac
