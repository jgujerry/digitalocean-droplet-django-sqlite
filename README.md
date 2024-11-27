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

Add a group,
```bash
$ sudo groupadd --system webapp
```

Add a user,
```bash
$ sudo useradd --system --gid webapp --shell /bin/bash --home /web/digitalocean-droplet-django-sqlite
```

5. Clone Github repository

Create a `/web` directory to place the source code,

```bash
mkdir /web
cd /web
```

Clone the source code from github repository,
```bash
$ git clone https://github.com/jgujerry/digitalocean-droplet-django-sqlite.git
```
As this is a public repository, it does not require credentials to clone.


6. Create Python environment

Install the Python3 `venv` module if need,

```bash
$ apt install -y python3-venv
```

Enter the project directory,
```bash
$ cd digitalocean-droplet-django-sqlit
```

Create the Python virtual environment,

```bash
$ python3 -m venv venv
```

To activate this Python virtual environment, run the following command,
```bash
$ source venv/bin/activate
```

Remember to upgrade `pip` by running `pip install -U pip`.

Then install Python packages required by this project,

```bash
$ pip install -r requirements.txt
```

7. Create a `.env` file

In the project directory, create `.env` file,

```bash
$ vim .env
```

Then you can put the sensitive information, e.g. Django secret key, and/or database credentials, into the this file.

8. Initialize the database

Run Django migrate command to initialize the database,

```bash
$ python manage.py migrate
```

1. Test `gunicorn`

Run `chown` to change the ownership of the project directory to project user specified above.

```bash
$ chown -R webuser:webapp         git config --global --add safe.directory /web/digitalocean-droplet-django-sqlite
/web/digitalocean-droplet-django-sqlit
```

Then run the following command,

```bash
$ ./production/start.sh
```

If everything is good, you could see
```bash
Current working directory: /web/digitalocean-droplet-django-sqlite
[2024-11-16 08:07:38 +0000] [1055382] [INFO] Starting gunicorn 23.0.0
[2024-11-16 08:07:38 +0000] [1055382] [INFO] Listening at: unix:/web/digitalocean-droplet-django-sqlite/production/gunicorn.sock (1055382)
[2024-11-16 08:07:38 +0000] [1055382] [INFO] Using worker: sync
[2024-11-16 08:07:38 +0000] [1055383] [INFO] Booting worker with pid: 1055383
^C[2024-11-16 08:07:40 +0000] [1055382] [INFO] Handling signal: int
[2024-11-16 08:07:40 +0000] [1055383] [INFO] Worker exiting (pid: 1055383)
[2024-11-16 08:07:41 +0000] [1055382] [INFO] Shutting down: Master
```

Then `Ctrl+C` to terminate the process.


10.  Config `supervisor`

Copy the supervisor config file into `/etc/supervisor/conf.d/` directory.

```bash
$ cp production/conf/supervisor.conf /etc/supervisor/conf.d/django.conf
```

Then reread the configuration files
```bash
$ supervisorctl reread
```

Next to update supervisor to get `gunicorn` process run,

```bash
$ supervisorctl update
```

And, we can check by running the following command,

```bash
$ supervisorctl status
```

To restart the program,

```bash
$ supervisorctl restart <program-name>
```

11. Config `nginx`

Remove the default site enabled
```bash
$ rm /etc/nginx/sites-enabled/default
```

Copy project nginx config to location,

```bash
$ cp production/conf/nginx.conf /etc/nginx/site-enabled/django.conf
```

Then visit `http://droplet-ip-address`

12. Install SSL certificate

```bash
$ certbot -d <your-domain-name>
```
