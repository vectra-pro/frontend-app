pipeline {
    agent any

    environment {
        IMAGE_NAME = "frontend-app"
        CONTAINER_NAME = "frontend-container"
        DOCKER = "/usr/bin/docker"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Show Environment') {
            steps {
                sh '''
                echo "Current User:"
                whoami

                echo "PATH:"
                echo $PATH

                echo "Docker Location:"
                which docker || true

                echo "Docker Version:"
                /usr/bin/docker --version
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                $DOCKER build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Stop Existing Container') {
            steps {
                sh '''
                $DOCKER stop $CONTAINER_NAME || true
                $DOCKER rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                $DOCKER run -d \
                --name $CONTAINER_NAME \
                -p 8081:80 \
                $IMAGE_NAME
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                $DOCKER ps
                '''
            }
        }
    }

    post {
        success {
            echo 'Frontend deployed successfully!'
        }

        failure {
            echo 'Deployment failed.'
        }

        always {
            echo 'Pipeline execution completed.'
        }
    }
}
