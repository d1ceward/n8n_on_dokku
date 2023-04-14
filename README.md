![](.github/images/repo_header.png)

[![n8n](https://img.shields.io/badge/n8n-0.224.0-blue.svg)](https://github.com/n8n-io/n8n/releases/tag/n8n%400.224.0)
[![Dokku](https://img.shields.io/badge/Dokku-Repo-blue.svg)](https://github.com/dokku/dokku)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/d1ceward/minio_on_dokku/graphs/commit-activity)
# Run n8n on Dokku

## Perquisites

### What is n8n?

[n8n](https://n8n.io/) is an extendable workflow automation tool. With a fair-code distribution model.

### What is Dokku?

[Dokku](http://dokku.viewdocs.io/dokku/) is the smallest PaaS implementation you've ever seen - _Docker
powered mini-Heroku_.

### Requirements
* A working [Dokku host](http://dokku.viewdocs.io/dokku/getting-started/installation/)
* [PostgreSQL](https://github.com/dokku/dokku-postgres) plugin for Dokku
* [Letsencrypt](https://github.com/dokku/dokku-letsencrypt) plugin for SSL (optionnal)

# Setup

**Note:** We are going to use the domain `n8n.example.com` for demonstration purposes. Make sure to replace
it to your domain name.

## Create the app
Log onto your Dokku Host to create the n8n app:

```bash
dokku apps:create n8n
```

## Configuration

### Setting encryption key
```bash
dokku config:set n8n N8N_ENCRYPTION_KEY=$(echo `openssl rand -base64 45` | tr -d \=+ | cut -c 1-32)
```

### Setting webhook url
```bash
dokku config:set n8n WEBHOOK_URL=http://n8n.example.com
```

## Domain setup

To get the routing working, we need to apply a few settings. First we set the domain.

```bash
dokku domains:set n8n n8n.example.com
```

## Push n8n to Dokku

### Grabbing the repository

First clone this repository onto your machine.

#### Via SSH

```bash
git clone git@github.com:d1ceward/n8n_on_dokku.git
```

#### Via HTTPS

```bash
git clone https://github.com/d1ceward/n8n_on_dokku.git
```

### Set up git remote

Now you need to set up your Dokku server as a remote.

```bash
git remote add dokku dokku@example.com:n8n
```

### Push n8n

Now we can push n8n to Dokku (_before_ moving on to the [next part](#ssl-certificate)).

```bash
git push dokku master
```

## SSL certificate

Last but not least, we can go an grab the SSL certificate from [Let's Encrypt](https://letsencrypt.org/).

```bash
# Install letsencrypt plugin
dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git

# Set certificate contact email
dokku config:set --no-restart n8n DOKKU_LETSENCRYPT_EMAIL=you@example.com

# Generate certificate
dokku letsencrypt:enable n8n
```

## Wrapping up

Your n8n instance should now be available on [https://n8n.example.com](https://n8n.example.com).
