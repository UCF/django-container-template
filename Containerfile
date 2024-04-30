# Pull official base image

## Mac/Windows/Linux x86
FROM python:3.12

## Mac M-Series
## FROM arm64v8/python:3.12

# Set environment variables
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

# apt-get update + vim install for editing
RUN yes | apt-get update && yes | apt-get upgrade
RUN yes | apt-get install vim

# Install dependencies
WORKDIR /app
RUN pip install --upgrade pip
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy project
COPY ./mysite /app/

RUN python3 manage.py makemigrations polls

CMD ["sh", "-c", "python3 manage.py createsuperuser --noinput --username $DJANGO_SUPERUSER_USERNAME --email $DJANGO_SUPERUSER_EMAIL && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
