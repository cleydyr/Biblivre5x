@echo off
REM Batch script to build and run Biblivre5x

REM Build the WAR file
mvn clean package
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

REM Build the Docker image
docker build -f Dockerfile.local -t biblivre-local .
IF %ERRORLEVEL% NEQ 0 EXIT /B %ERRORLEVEL%

REM Run the Docker container, binding port 8080
docker run -p 8080:8080 biblivre-local
