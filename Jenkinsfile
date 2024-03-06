pipeline {
    agent none
    stages {
        stage ('Testing django') { 
            agent { 
                docker { image 'python:3'
                args '-u root:root'
                }
            }
            stages {
                stage('Clone') {
                    steps {
                        git branch:'master',url:'https://github.com/fabiiogonzalez8/django_tutorial.git'
                    }
                }
                stage('Install') {
                    steps {
                        sh 'pip install -r requirements.txt'
                    }
                }
                stage('Test') {
                    steps {
                        sh 'python3 manage.py test'
                    }
                } 
            }
        }
        stage('Subir imagen') {
            agent any
            stages {
                stage('Construir') {
                    steps {
                        script {
                            withDockerRegistry([credentialsId: 'CREDENCIALES_DOCKERHUB', url: '']) {
                            def dockerImage = docker.build("fabiiogonzalez8/django_tutorial:${env.BUILD_ID}")
                            dockerImage.push()
                            }
                        }
                    }
                }
                stage('Eliminar imagen') {
                    steps {
                        script {
                            sh "docker rmi fabiiogonzalez8/django_tutorial:${env.BUILD_ID}"
                        }
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
