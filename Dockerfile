# Use a base image with Flutter installed
FROM cirrusci/flutter:latest

# Set the working directory to /app
WORKDIR /app

# Copy the entire Flutter project into the container
COPY . .

# Install Node.js (for 'serve' to work)
RUN apt-get update && apt-get install -y nodejs npm

# Install 'serve' globally for serving the Flutter web build
RUN npm install -g serve

# Run flutter doctor to ensure Flutter is correctly installed
RUN flutter doctor

# Get Flutter dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Expose the port the app will run on
EXPOSE 3000

# Command to run the web app using 'serve'
CMD ["serve", "-s", "build/web", "-l", "3000"]
