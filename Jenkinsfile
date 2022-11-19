pipeline {
    agent { label 'agent1' }

    stages {
        stage('Build petclinic app') {
            steps {
                sh 'DOCKER_BUILDKIT=1 docker build -f ./Dockerfile -t spring-petclinic-app .'
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
                sh 'docker-compose up -d postgresDB'
		}
	}
        stage('Run the app') {
            steps {
                sh 'docker-compose -f ./docker-compose.yml up -d petclinic-app'
            }
        }
    }
}
