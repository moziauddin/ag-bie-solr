pipeline {
    agent any
    stages {
        stage('Build Solr Index') {
            steps {
                sh "echo SCRIPT_TO_RUN: ${SCRIPT_TO_RUN}"
                sh "./${SCRIPT_TO_RUN}"
            }
        }
    }

}
