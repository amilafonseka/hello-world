pipeline {
    agent any
    stages {
        stage('Run Migration Scripts before Gradle Build') {
            input {
                message "Should we continue?"
                ok "Yes, we should."
                submitter "alice,bob"
                parameters {
                    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
                }
            }
            steps {
                sh '''
                    liquibase update
                   '''
            }
        }
        
        stage('Gradle build') {
            steps {
                sh 'echo gradle build'
            }
        }
        
        stage('Production Deployment') {
            steps {
                sh 'echo production deployment'
            }
        }
        
        stage('Run Migration Scripts after Prod deployment') {
            steps {
                input "Do you want to run the DB migration scripts?"
                sh '''
                    liquibase update
                   '''
            }
        }
    }
    
    
}
