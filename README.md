# digitalocean-droplet-django-sqlite

This is an example Django application deployed on DigitalOcean.

* Django
* SQLite
* Gunicorn
* Nginx
* DigitalOcean Droplet
* Let's Encrypt


## Example Django app

If you like to check this example project at localhost, please follow instructions below to run this Django application on your machine.

1. Clone this repo,

```bash
$ git clone https://github.com/jgujerry/digitalocean-django-app.git
```

2. Create a `.venv` environment,
```bash
$ python3 -m venv .venv
```

3. Activate the virtual environment,
```bash
$ source .venv/bin/activate
```

4. Install required dependencies,

```bash
$ pip install -r requirements.txt
```

5. Start the development server,

```bash
$ python manage.py runserver
```

Then visit the site locally [`http://127.0.0.1:8000`](http://127.0.0.1:8000)


## Deploy Django app


Steps about how to deploy this Django app on DigitalOcean with droplet.


1. Sign up to Digital Ocean

https://www.digitalocean.com/

Credit card information is required for signing up, and received `$200` credits for 60 days.


2. Create a Droplet

Choose a region: San Francisco


Choose a datacenter closet to you or your users.


Choose an image:
OS Ubuntu
Version 24.04 LTS


Choose Size

Droplet type: Shared CPU (Basic)
CPU Options: Regular
Disty type: SSD

You could add additional storage.


You can choose to enable automatic backups.


Choose authentication method: SSH or Password


Create SSH key by run `ssh-keygen` command, add passphrase (highly recommended), then copy `id_rsa.pub` content.


Add improved metrics monitoring and alerting (free)

Finalize Details:

Quantity: 1

Hostname: ubuntu-s-1vcpu-512mb-10gb-xxx-xx


3. Connect to Droplet


On droplet console page, you could find its `ipv4` address. You can connect to it via `ssh`.


```bash
$ ssh root@xxx.xxx.xxx.xxx
```

Or you can use Droplet Console for native-like terminal access to your Droplet from the browser.


4. Manage the Droplet

Update and install software

```bash
$ sudo apt update
```


Upgrade the system

```bash

$ sudo apt upgrade
```

Install system dependencies

```bash
$ sudo apt install python3-pip python3-dev libpq-dev nginx certbot python3-certbot-nginx supervisor
```
