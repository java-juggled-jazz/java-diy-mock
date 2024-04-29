FROM maven:3.9.6-eclipse-temurin-17-alpine
RUN apk install s3cmd && echo -e "[default]\naccess_key = ${ACCESS_KEY}\nsecret_key = ${SECRET_KEY}\nbucket_location = ${BUCKET_LOCATION}\nhost_base = storage.yandexcloud.net\nhost_bucket = ${BUCKET_NAME}.storage.yandexcloud.net" > ~/.s3cfg
