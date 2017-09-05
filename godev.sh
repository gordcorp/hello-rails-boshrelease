#!/usr/bin/env bash

# Handy development script to create a new dev release, upload, and deploy
# this bosh release.

set -e # Exit immediately if there is an error

set -x # Print shell input lines as they are read.

set -o pipefail # cause a pipeline (for example, curl -s http://sipb.mit.edu/ | grep foo) to produce a failure return code if any command errors not just the last command of the pipeline.

: ${BOSH_ENVIRONMENT:?required}

director_name=$(bosh2 env --json | jq -r ".Tables[0].Rows[0].name")

export CREDHUB_CLI_USERNAME=credhub-cli
export CREDHUB_CLI_PASSWORD=`bosh int ~/deployments/vbox/creds.yml --path /credhub_cli_password`
credhub login -s https://192.168.50.6:8844 -u $CREDHUB_CLI_USERNAME -p $CREDHUB_CLI_PASSWORD --skip-tls-validation

export SECRET_KEY_BASE=$(credhub get -n "/${director_name}/hello-rails/application-secret-key-base" --output-json | jq -r .value)

pushd src/hello-rails
   bundle install
   bundle package --all
   RAILS_ENV=production bundle exec rake assets:precompile
popd

bosh2 -n delete-deployment -d hello-rails

bosh2 create-release --name=hello-rails --force

bosh2 upload-release

bosh2 deploy -n -d hello-rails manifests/hello-rails.yml

echo finished
