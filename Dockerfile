FROM python:3.9

WORKDIR /app/backend

# Install dependencies
COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && pip install mysqlclient \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf /var/lib/apt/lists/*

# Copy application code
COPY . /app/backend

# Expose the app port
EXPOSE 8000

# Run migrations and start the app
CMD python manage.py migrate && python manage.py runserver 0.0.0.0:8000
