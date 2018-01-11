IMAGE_NAME="docker-es-frontend"
pipeline {
	agent any
	stages {
		stage('Docker') {
			steps {
				script {
					image = docker.build("docker.ehm.rocks/ehm/${IMAGE_NAME}")
					docker.withRegistry("https://docker.ehm.rocks","docker.ehm.rocks-write")  {
						image.push("${BRANCH_NAME}")
					}
				}
			}
		}
	}
}
