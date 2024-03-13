pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Analyse statique du code') {
            steps {
                sh 'make lint'
            }
        }

        stage('Tests unitaires') {
            steps {
                sh 'make test'
            }
        }

        stage('Génération de documentation') {
            steps {
                sh 'make doc'
            }
        }

        stage('Vérification de la couverture du code') {
            steps {
                sh 'make coverage'
            }
        }
    }

    post {
        always {
            echo 'Le pipeline CI est terminé.'
        }
    }
}
