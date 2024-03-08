pipeline {
    agent any
    stages {
        stage('Testing django') { 
            agent { 
                docker { 
                    image 'python:3'
                    args '-u root:root'
                }
            }
            steps {
                script {
                    git branch: 'master', url: 'https://github.com/fabiiogonzalez8/django_tutorial.git'
                    sh 'pip install -r requirements.txt'
                    sh 'python manage.py test'
                }
            }
        }
        stage('Copiar settings') {
            steps {
                script {
                    sh 'cp django_tutorial/settings.bak django_tutorial/settings.py'
                }
            }
        }
        stage('Subir imagen') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'CREDENCIALES_DOCKERHUB', url: '']) {
                        def dockerImage = docker.build("fabiiogonzalez8/django:${env.BUILD_ID}")
                        dockerImage.push()
                    }
                    sh "docker rmi fabiiogonzalez8/django:${env.BUILD_ID}"
                }
            }
        }
        stage('SSH') {
            steps {
                script {
                    sshagent(credentials: ['clave']) {
                        sh "ssh -o StrictHostKeyChecking=no fabio@goku.supergallo.es wget https://raw.githubusercontent.com/fabiiogonzalez8/django_tutorial/master/docker-compose.yaml -O docker-compose.yaml"
                        sh "ssh -o StrictHostKeyChecking=no fabio@goku.supergallo.es docker-compose up -d --force-recreate"
                    }
                }
            }
        }
    }
    post {
        always {
            mail to: 'fabiiogonzalez8@gmail.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
