# Use a base image with Node.js and Flutter
FROM cirrusci/flutter:latest

# Set the working directory
WORKDIR /usr/src/app

# Copy the Flutter app files into the container
COPY . .

# Install dependencies (for both Flutter and Node.js)
RUN flutter pub get
RUN npm install -g serve

# Build the Flutter app
RUN flutter build web

# Expose the port
EXPOSE 3000

# Start serving the app
CMD ["serve", "-s", "build/web"]
