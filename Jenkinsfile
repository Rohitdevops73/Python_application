pipeline{
    agent any
    environment {
        SONAR_URL ="http://65.2.82.81:9000/"
        DOCKER_IMAGE = "rohitkube/python_app"
        GIT_USER_NAME = "Rohitdevops73"
        GIT_REPO_NAME = "Python_application"
    }
    stages{
         stage('Set DOCKER_TAG') {
            steps{
                script{
                    DOCKER_TAG = sh(returnStdout: true, script: 'date +%Y%m%d').trim()
                    echo "DOCKER_TAG is set to ${DOCKER_TAG}"
                }
            }
        }
        stage("clone repo"){
            steps{
                git branch: 'main', url: 'https://github.com/Rohitdevops73/Python_application.git'
            }
        }
        
      //  stage('SonarQube') {
        //    steps {
          //      withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_TOKEN')]) {
            //        sh "mvn sonar:sonar -Dsonar.login=$SONAR_TOKEN -Dsonar.host.url=${SONAR_URL}"
              //  }
            //}
       // }
        stage('Build image'){
            steps{
                script{
                    sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."

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
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }
        stage('Update Deployment File') {
            steps {
                withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                    sh '''
                        git config user.email "rohitpatil.cse@gmail.com "
                        git config user.name "${GIT_USER_NAME}"

                        # Update deployment.yml with the correct Docker image version (Build Number)
                        sed -i "s|image: ${DOCKER_IMAGE}:[^ ]*|image: ${DOCKER_IMAGE}:${DOCKER_TAG}|g" argocd-manifest/deployment.yml

                        # Commit and push the updated deployment file
                        git argocd-manifest/deployment.yml
                        git commit -m "Update deployment image to version ${DOCKER_TAG}"
                        git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                    '''
                }
            }
        }
        
    }
    
}