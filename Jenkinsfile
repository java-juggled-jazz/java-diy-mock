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
                sh 'ENTRYPOINT echo -e "[default]\naccess_key = ${BUCKET_ACCESS_KEY}\nsecret_key = ${BUCKET_SECRET_KEY}\nbucket_location = ${env.BUCKET_LOCATION}\nhost_base = storage.yandexcloud.net\nhost_bucket = ${env.BUCKET_NAME}.storage.yandexcloud.net" > ~/.s3cfg'
                sh 'echo BUCKET_ACCESS_KEY: ${BUCKET_ACCESS_KEY}'
                sh 'echo BUCKET_SECRET_KEY: ${BUCKET_SECRET_KEY}'
                sh 'echo BUCKET_LOCATION: ${env.BUCKET_LOCATION}'
                sh 'echo BUCKET_NAME: ${env.BUCKET_NAME}'
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
