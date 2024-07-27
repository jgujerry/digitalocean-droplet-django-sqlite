from .common import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = env.str('DJANGO_SECRET_KEY')

# SECURITY WARNING: define the correct hosts in production!
ALLOWED_HOSTS = ['localhost', '127.0.0.1', '0.0.0.0']


# Email Settings
# EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
