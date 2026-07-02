pipeline {

    agent any

    environment {
        IMAGE_NAME = "frontend-app"
        CONTAINER_NAME = "frontend-container"
        PORT = "8081"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify User') {
            steps {
                sh '''
                sudo -u student whoami
                sudo -u student podman --version
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                sudo -u student podman build \
                -t $IMAGE_NAME .
                '''
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                sudo -u student podman stop $CONTAINER_NAME || true
                sudo -u student podman rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                sudo -u student podman run -d \
                --name $CONTAINER_NAME \
                -p $PORT:80 \
                $IMAGE_NAME
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                sudo -u student podman ps
                '''
            }
        }

    }

    post {

        success {
            echo "Deployment Successful"
            echo "Open:"
            echo "http://workstation:8081"
        }

        failure {
            echo "Deployment Failed"
        }

        always {
            echo "Pipeline Finished"
        }

}
