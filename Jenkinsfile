pipeline {
  agent {
    docker { image 'node:14-alpine' }
  }
    stages {
        stage('Run Migration Scripts before Gradle Build') {
            steps {
             script {
                env.flagError = "false"
                try {
                    input(message: 'Do you want to run the DB migration scripts', ok: 'Proceed')

                }catch(e){
                    println "input aborted or timeout expired, will try to rollback."
                    env.flagError = "true"        
                }
              }
            }
        }
        
        stage('Run the DB migration scripts before the Gradl build') {
            when{
                expression { env.flagError == "false" }
            }

            steps {
                sh '''
                    node --version
                   '''
            }
        }
        
        stage('Gradle build') {
            steps {
                sh 'echo Gradle build'
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
