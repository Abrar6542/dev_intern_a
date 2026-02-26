FROM python:3.10-slim

WORKDIR /app

COPY dependencies.txt .

RUN pip install --no-cache-dir -r dependencies.txt

COPY . .

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "backend.wsgi:application"]
