pipeline {
  agent any

  environment {
    IMAGE_NAME = "sobinscott/express-api-demo"
    IMAGE_TAG = "2.0.0"
    DEPLOY_USER = "ubuntu"
    DEPLOY_HOST = "80.225.228.174"
    DEPLOY_PATH = "/home/ubuntu/express-prod"
  }

  stages {
    stage('Clone Repo') {
      steps {
        git branch: 'dev', url: 'https://github.com/sobin-restart/express-api-demo.git'
      }
    }

    stage('Build Docker Image with .env') {
      steps {
        withCredentials([file(credentialsId: 'express-api-env-file', variable: 'DOTENV')]) {
          sh 'cp $DOTENV .env'
          sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
        }
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          script {
            sh "echo \$PASSWORD | docker login -u \$USERNAME --password-stdin"
            sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
          }
        }
      }
    }

    stage('Deploy to Server') {
      steps {
        script {
          sshagent(['deploy-to-oracle-sobin-poc-key']) {
            sh """
              ssh -o StrictHostKeyChecking=no ${DEPLOY_USER}@${DEPLOY_HOST} \\
              'cd ${DEPLOY_PATH} && docker compose down && docker compose pull && docker compose up -d'
            """
          }
        }
      }
    }
  }
}
