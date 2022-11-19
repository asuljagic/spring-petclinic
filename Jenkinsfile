pipeline {
    agent { label 'agent1' }

    stages {
        stage('Build petclinic app') {
            steps {
                sh 'pwd'
                sh 'DOCKER_BUILDKIT=1 docker build -f /home/vagrant/spring-petclinic/Dockerfile -t spring-petclinic-app .'
                sh 'docker tag spring-petclinic-app 192.168.56.103:5000/spring-petclinic-app'
            }
        }
        stage('Push petclinic image to registry') {
            steps {
                sh 'docker push 192.168.56.103:5000/spring-petclinic-app'
            }
        }
        stage('Run postgres container') {
            steps {
                sh 'docker-compose up postgres_container --build'
		}
	}
        stage('Run the app') {
            steps {
                sh 'docker-compose -f /home/vagrant/spring-petclinic/docker-compose up petclinic-app -d'
            }
        }
    }
}
