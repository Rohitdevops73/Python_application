pipeline{
    agent any
    
    stages{
         stage('Set DOCKER_TAG') {
            steps {
                script {
                    env.DOCKER_TAG = sh(returnStdout: true, script: 'date +%Y-%m-%d').trim()
                    echo "DOCKER_TAG is set to ${env.DOCKER_TAG}"
                }
            }
        }
        stage("clone repo"){
            steps{
                git branch: 'main', url: 'https://github.com/Rohitdevops73/Python_application.git'
            }
        }
        stage('Build image'){
            steps{
                script{
                    sh 'docker build -t rohitkube/python_app:${env.DOCKER_TAG} .'

            }    
            }
        }
        stage('Docker image scan'){
            steps{
                script{
                    sh 'trivy image --format table -o trivy-image-report.html rohitkube/python_app:${env.DOCKER_TAG}'
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                }
            }
        }
        stage('Push Docker image'){
            steps{
                script{
                    sh 'docker push rohitkube/python_app:${env.DOCKER_TAG}'
                }
            }
        }
        
    }
    
}