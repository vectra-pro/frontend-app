pipeline {
    agent any

    environment {
        IMAGE_NAME = "frontend-app"
        CONTAINER_NAME = "frontend-container"
        PORT = "8081"
        PODMAN = "/usr/bin/podman"
    }

    stages {

        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('System Information') {
            steps {
                sh '''
                echo "===== USER ====="
                whoami

                echo "===== WORKSPACE ====="
                pwd

                echo "===== PODMAN VERSION ====="
                sudo $PODMAN --version
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh '''
                echo "===== BUILD IMAGE ====="
                sudo $PODMAN build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Remove Existing Container') {
            steps {
                sh '''
                echo "===== REMOVE OLD CONTAINER ====="

                sudo $PODMAN stop $CONTAINER_NAME || true
                sudo $PODMAN rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                echo "===== START NEW CONTAINER ====="

                sudo $PODMAN run -d \
                    --name $CONTAINER_NAME \
                    -p $PORT:8080 \
                    $IMAGE_NAME
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                echo "===== RUNNING CONTAINERS ====="
                sudo $PODMAN ps

                echo "===== AVAILABLE IMAGES ====="
                sudo $PODMAN images
                '''
            }
        }
    }

    post {

        success {
            echo '======================================'
            echo 'Frontend Deployment Successful'
            echo 'Application URL:'
            echo 'http://workstation:8081'
            echo '======================================'
        }

        failure {
            echo '======================================'
            echo 'Deployment Failed'
            echo 'Check Console Output'
            echo '======================================'
        }

        always {
            echo 'Pipeline Finished'
        }
    }
}
