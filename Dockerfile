FROM python:3.9.6-alpine

# Set environment variables
#Prevents Python from writing pyc files to disc (equivalent to python -B
ENV PYTHONDONTWRITEBYTECODE 1
#Prevents Python from buffering stdout and stderr (equivalent to python -u
ENV PYTHONUNBUFFERED 1

RUN apk update && apk add --no-cache \
    # Required for installing/upgrading postgres, Pillow, etc:
    gcc python3-dev \
    # Required for installing/upgrading postgres:
    postgresql-libs postgresql-dev musl-dev

# Set work directory
RUN mkdir /dvm
WORKDIR /dvm

# Install dependencies into a virtualenv
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt 

# Copy project code
COPY . /dvm/
