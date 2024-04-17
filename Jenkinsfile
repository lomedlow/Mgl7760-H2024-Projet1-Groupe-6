pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm // s'Assurer que notre dépôt Git est configurer
            }
        }
        stage('Pre-Cleanup') {
            steps {
                sh 'docker-compose down'
            }
        }
        stage('installation') {
           steps {
                script {
                    try {
                        sh 'docker-compose down'
                        sh 'docker-compose up --build -d'
                        sh 'docker-compose ps'
                    } catch (Exception e) {
                        echo "Error encountered: ${e.getMessage()}"
                        throw new RuntimeException("Stopping build due to errors in setting up Docker environment.")
                    }
                }
            }
        }
        stage('Lint') {
           steps {
                sh 'docker-compose ps'
                sh 'make lint'
            }
        }
        stage('Test') {
            steps {
                sh 'make test'
            }
        }
        stage('Documentation') {
            steps {
                sh 'make doc'
            }
        }
        stage('Coverage') {
            steps {
                sh 'make coverage'
            }
        }
        stage('Copy Reports') {
            steps {
                sh 'make copy-reports'
            }
        }
    }
    post {
        always {
            sh 'docker-compose down'
            cleanWs()
        }
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
