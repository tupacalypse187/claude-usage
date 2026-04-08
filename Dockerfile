FROM python:3.12-slim

WORKDIR /app

COPY cli.py scanner.py dashboard.py ./

EXPOSE 8080

CMD ["python", "cli.py", "dashboard"]
