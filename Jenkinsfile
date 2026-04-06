pipeline {
    agent any

    environment {
        DOCKER_USER     = 'shamanth74'
        IMAGE_NAME      = 'java-image'
        // 'docker-hub-creds' must be created in Jenkins -> Manage Jenkins -> Credentials
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
                    // This tags it with the Jenkins Build Number (v1, v2, v3...)
                    sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:v${BUILD_NUMBER} ."
                    // Also tags it as 'latest' for convenience
                    sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Docker Hub Login') {
            steps {
                // Uses the environment variables provided by 'credentials'
                sh "echo $DOCKER_HUB_AUTH_PSW | docker login -u $DOCKER_HUB_AUTH_USR --password-stdin"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:v${BUILD_NUMBER}"
                sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
            }
        }

        stage('Clean Local Images') {
            steps {
                sh "docker rmi ${DOCKER_USER}/${IMAGE_NAME}:v${BUILD_NUMBER}"
                sh "docker rmi ${DOCKER_USER}/${IMAGE_NAME}:latest"
            }
        }
    }
}
