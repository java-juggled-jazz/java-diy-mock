/* Requires the Docker Pipeline plugin */
pipeline {
    agent {
        docker {
            image 'builder'
            label 'latest'
            registryUrl 'https://cr.yandex/'
            args '-e ACCESS_KEY=${ACCESS_KEY} SECRET_KEY=${SECRET_KEY} BUCKET_LOCATION=${BUCKET_LOCATION} BUCKET_NAME=${BUCKET_NAME} '
        }
    }
    
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
