/* Requires the Docker Pipeline plugin */
pipeline {
    environment {
        BUCKET_ACCESS_KEY = credentials('BUCKET_ACCESS_KEY')
        BUCKET_SECRET_KEY = credentials('BUCKET_SECRET_KEY')
        S3_CONFIG = "[default]\naccess_key = ${BUCKET_ACCESS_KEY}\nsecret_key = ${BUCKET_SECRET_KEY}\nbucket_location = ${env.BUCKET_LOCATION}\nhost_base = storage.yandexcloud.net\nhost_bucket = ${env.BUCKET_NAME}.storage.yandexcloud.net"
    }
    
    agent {
        docker {
            image 'crprrh63rcbll3spfoih/builder:latest'
            registryUrl 'https://cr.yandex/'
        }
    }
    
    stages {
        stage('cred-setup') {
            steps {
                writeFile(file: '.s3cfg', text: $S3_CONFIG)
                sh "cat .s3cfg"
                sh "echo BUCKET_LOCATION: ${env.BUCKET_LOCATION}"
                sh "echo BUCKET_NAME: ${env.BUCKET_NAME}"
            }
        }
        
        stage('build') {
            steps {
                sh "mvn -B package"
            }
        }

        stage('test') {
            steps {
                sh "java -jar target/output.jar ${env.APP_TEST_ARG_1} ${env.APP_TEST_ARG_2}"
            }
        }
        
        stage('put-jar-to-bucket') {
            steps {
                sh "s3cmd --config .s3cfg put target/output.jar s3://${env.BUCKET_NAME}/application.jar"
            }
        }
    }
}
