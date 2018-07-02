pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh "echo SCRIPT_TO_RUN: ${SCRIPT_TO_RUN}"
                sh "./${SCRIPT_TO_RUN}"
            }
        }
    }

}
