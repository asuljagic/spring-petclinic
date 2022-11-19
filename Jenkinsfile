pipeline {
    agent { label 'agent1' }

    stages {
        stage('Pull changes from repository') {
            steps {
                sh 'git pull'
            }
        }
        stage('Build petclinic app') {
            steps {
                sh 'DOCKER_BUILDKIT=1 docker build -f /home/vagrant/spring-petclinic/Dockerfile -t spring-petclinic-app .'
                sh 'docker tag spring-petclinic-app 192.168.56.103:5000/spring-petclinic-app'
            }
        }
        stage('Push petclinic to registry') {
            steps {
                sh 'docker push 192.168.56.103:5000/spring-petclinic-app'
            }
        }
        stage('Build postgres image') {
            steps {
                sh 'docker pull posgtres:14.1'
                sh 'docker tag postgres:14.1 192.168.56.103:5000/spring-psql-petclinic'
            }
        }
        stage('Push postgres to registry') {
            steps {
                sh 'docker push 192.168.56.103:5000/spring-psql-petclinic'
            }
        }
        stage('Run the app') {
            steps {
                sh 'docker-compose -f /home/vagrant/spring-petclinic/docker-compose up -d'
            }
        }
    }
}
