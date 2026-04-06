pipeline {
    agent any

    environment {
        DOCKER_USER     = 'shamanth74'
        IMAGE_NAME      = 'java-image'
        // Ensure you have created credentials with ID 'docker-hub-creds' in Jenkins
        DOCKER_HUB_AUTH = credentials('docker-hub-creds') 
    }

    stages {
        stage('Pull from GitHub') {
            steps {
                checkout scm
            }
        }

        stage('Build & Tag') {
            steps {
                script {
                    // Using 'bat' for Windows Command Prompt
                    bat "docker build -t %DOCKER_USER%/%IMAGE_NAME%:v%BUILD_NUMBER% ."
                    bat "docker build -t %DOCKER_USER%/%IMAGE_NAME%:latest ."
                }
            }
        }

        stage('Docker Hub Login') {
            steps {
                // We remove the space before the pipe to avoid sending a space as part of the password
                bat "@echo %DOCKER_HUB_AUTH_PSW%| docker login -u %DOCKER_HUB_AUTH_USR% --password-stdin"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                bat "docker push %DOCKER_USER%/%IMAGE_NAME%:v%BUILD_NUMBER%"
                bat "docker push %DOCKER_USER%/%IMAGE_NAME%:latest"
            }
        }

        stage('Clean Local Images') {
            steps {
                // '|| exit 0' ensures the pipeline doesn't fail if the image was already gone
                bat "docker rmi %DOCKER_USER%/%IMAGE_NAME%:v%BUILD_NUMBER% || exit 0"
                bat "docker rmi %DOCKER_USER%/%IMAGE_NAME%:latest || exit 0"
            }
        }
    }
}
