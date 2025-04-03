# Use Python base image
FROM python:3.9

# Set working directory inside the container
WORKDIR /app

# Copy only requirements.txt first (Important for caching)
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Now copy all your application files (Flask code, etc.)
COPY . .

# Expose Flask port
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
