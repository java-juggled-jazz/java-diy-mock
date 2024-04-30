/* Requires the Docker Pipeline plugin */
pipeline {
    environment {
        BUCKET_ACCESS_KEY = credentials('BUCKET_ACCESS_KEY')
        BUCKET_SECRET_KEY = credentials('BUCKET_SECRET_KEY')
    }
    
    agent {
        docker {
            image 'builder'
            label 'latest'
            registryUrl 'https://cr.yandex/'
        }
    }
    
    stages {
        stage('cred-setup') {
            steps {
                sh 'ENTRYPOINT echo -e "[default]\naccess_key = ${BUCKET_ACCESS_KEY}\nsecret_key = ${BUCKET_SECRET_KEY}\nbucket_location = ${BUCKET_LOCATION}\nhost_base = storage.yandexcloud.net\nhost_bucket = ${BUCKET_NAME}.storage.yandexcloud.net" > ~/.s3cfg
            }
        }
        
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
