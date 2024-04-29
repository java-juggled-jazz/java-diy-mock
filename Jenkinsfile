/* Requires the Docker Pipeline plugin */
pipeline {
    agent { docker { image 'maven:3.9.6-eclipse-temurin-17-alpine' } }
    stages {
        stage('build') {
            steps {
                sh 'mvn -B package'
            }
        }

        stage('test') {
            steps {
                sh 'java -jar output.jar ${ARG_1} ${ARG_2}'
            }
        }
        
        stage('put-jar-to-bucket') {
            steps {
                sh 's3cmd put output.jar s3://${BUCKET_NAME}/application.jar'
            }
        }
    }
}
