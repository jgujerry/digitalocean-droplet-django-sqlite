from .common import *

DEBUG = False

ALLOWED_HOSTS = ["*"]

SECRET_KEY = env.str('DJANGO_SECRET_KEY')
