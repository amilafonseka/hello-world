pipeline {
    agent any
    stages {
        stage('Run Migration Scripts before Gradle Build') {
            steps {
                input "Do you want to run the DB migration scripts?"
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
