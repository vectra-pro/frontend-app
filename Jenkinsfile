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

        stage('Show Environment') {
            steps {
                sh '''
                echo "========== SYSTEM INFORMATION =========="
                whoami
                pwd
                echo $PATH
                /usr/bin/docker --version
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                sudo /usr/bin/docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Stop Existing Container') {
            steps {
                sh '''
                sudo /usr/bin/docker stop $CONTAINER_NAME || true
                sudo /usr/bin/docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                sudo /usr/bin/docker run -d \
                --name $CONTAINER_NAME \
                -p $PORT:80 \
                $IMAGE_NAME
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                echo "========== RUNNING CONTAINERS =========="
                sudo /usr/bin/docker ps

                echo "========== IMAGES =========="
                sudo /usr/bin/docker images
                '''
            }
        }
    }

    post {

        success {
            echo "========================================="
            echo "Frontend deployed successfully!"
            echo "Access your application at:"
            echo "http://<SERVER-IP>:8081"
            echo "========================================="
        }

        failure {
            echo "========================================="
            echo "Deployment Failed!"
            echo "Check the Console Output."
            echo "========================================="
        }

        always {
            echo "Pipeline execution completed."
        }
    }
}
