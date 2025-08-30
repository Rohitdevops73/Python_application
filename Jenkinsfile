pipeline{
    agent any
    environment{
        DOCKER_TAG = '20250830'
    }
    stages{
        stage("clone repo"){
            steps{
                git branch: 'main', url: 'https://github.com/Rohitdevops73/Python_application.git'
            }
        }
        stage('Build image'){
            steps{
                script{
                    sh 'docker build -t python_app:${DOCKER_TAG} .'

            }    
            }
        }
        stage('Docker image scan'){
            steps{
                script{
                    sh 'trivy image --format table -o trivy-image-report.html python_app:${DOCKER_TAG}'
                }
            }
        }
        stage('Push Docker image'){
            steps{
                script{
                    sh 'docker push python_app:${DOCKER_TAG}'
                }
            }
        }
        
    }
    
}