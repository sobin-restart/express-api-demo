pipeline {
  agent any

  environment {
    IMAGE_NAME = "sobinscott/express-api-demo"
    IMAGE_TAG = "1.0.0"
  }

  stages {
    stage('Clone Repo') {
      steps {
        git branch: 'main', url: 'https://github.com/sobin-restart/express-api-demo.git'
        // git 'https://github.com/sobin-restart/express-api-demo.git'
      }
    }

    stage('Build Docker Image with .env') {
      steps {
        withCredentials([file(credentialsId: 'express-api-env-file', variable: 'DOTENV')]) {
          sh 'cp $DOTENV .env'  // ✅ This copies your secret .env into the workspace
          sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'  // ✅ Uses Dockerfile + .env
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
