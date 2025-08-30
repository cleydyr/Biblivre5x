# PowerShell script to build and run Biblivre5x

# Build the WAR file
mvn clean package

# Build the Docker image
docker build -f Dockerfile.local -t biblivre-local .

# Run the Docker container, binding port 8080
docker run -p 8080:8080 biblivre-local
