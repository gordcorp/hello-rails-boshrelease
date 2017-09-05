# Hello-rails boshrelease

BOSH release for hello-rails. Hello-rails is a simple rails application with a visitor counter.

## Usage

### Setting up local environment

1. Setup a local BOSH2 environment with VBOX - https://github.com/cloudfoundry/bosh-deployment

2. Apply the provided BOSH cloud-config.
```
bosh2 update-cloud-config manifests/cloud-config-bosh-lite.yml
```

3. fetch a stemcell from bosh.io
```
bosh upload stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent
```

### Deploying hello-rails

There is no blob storage, so you will have to download the blobs and add them manually.

The manifest `manifests/hello-rails.yml` should then just work.

## Local Development

For convenience, set your target environment in an env var:
`export BOSH_ENVIRONMENT=vbox`

You can create local dev releases, and test them locally:

```
bosh create-release --name=hello-rails --force

bosh upload-release

bosh deploy -n -d hello-rails manifests/hello-rails.yml
```
