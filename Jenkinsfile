pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm // s'Assurer que notre dépôt Git est configurer
            }
        }
        stage('installation') {
           steps {
                sh 'docker-compose up --build'
                sh 'docker-compose ps'
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
