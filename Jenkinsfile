pipeline {
    agent { label 'agent1' }

    stages {
        stage('Build postgres image') {
            steps {
                sh 'docker pull 192.168.56.103:5000/psql-petclinic'
            }
        }
        stage('Build petclinic image') {
            steps {
                sh 'docker pull 192.168.56.103:5000/petclinic-app'
            }
        }
        stage('Run petclinic app') {
            steps {
                sh 'docker-compose -f /home/vagrant/spring-petclinic/docker-compose.yml up -d'
            }
        }
    }
}
