#!/bin/sh

PROJECT_NAME="digitalocean-droplet-django-sqlite"
PROJECT_DIR="/web/$PROJECT_NAME"

PRODRUN_DIR="$PROJECT_DIR/production/gunicorn"
PRODRUN_SOCKFILE="$PRODRUN_DIR/gunicorn.sock"

USER="webuser"
GROUP="webapp"

DJANGO_WSGI_MODULE="config.wsgi"
TIMEOUT=120
NUM_WORKERS=1

cd "$PROJECT_DIR" || exit 1
source venv/bin/activate
export DJANGO_SETTINGS_MODULE="config.settings.production"
export PYTHONPATH="$PROJECT_DIR:$PYTHONPATH"

# Ensure the production directory exists
test -d "$PRODRUN_DIR" || mkdir -p "$PRODRUN_DIR"

# Start gunicorn server
gunicorn "$DJANGO_WEB_MODULE:application" \
    --name "$PROJECT_NAME" \
    --workers "$NUM_WORKERS" \
    --timeout "$TIMEOUT" \
    --user "$USER" \
    --group "$GROUP" \
    --bind "unix:$PRODRUN_SOCKFILE" \
    --log-level INFO \
    --log-file -
