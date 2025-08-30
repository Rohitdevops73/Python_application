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
                    sh 'docker build -t python_app:${env.DOCKER_TAG} .'

            }    
            }
        }
        stage('Docker image scan'){
            steps{
                script{
                    sh 'trivy image --format table -o trivy-image-report.html python_app:${env.DOCKER_TAG}'
                }
            }
        }
        stage('Push Docker image'){
            steps{
                script{
                    sh 'docker push python_app:${env.DOCKER_TAG}'
                }
            }
        }
        
    }
    
}