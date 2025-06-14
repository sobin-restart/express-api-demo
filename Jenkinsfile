pipeline {
  agent any

  environment {
    IMAGE_NAME = "sobinscott/express-api-demo"
    IMAGE_TAG = "1.0.0"
  }

  stages {
    stage('Clone Repo') {
      steps {
        git 'https://github.com/sobin-restart/express-api-demo.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
        }
      }
    }

    stage('Push to Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          script {
            sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
            sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
          }
        }
      }
    }
  }
}
