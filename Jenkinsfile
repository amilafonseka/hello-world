pipeline {
  agent any
  environment{
    POSTGRES_HOST = 'aurora.dev1.leaseeagle.com'
    POSTGRES_USER = 'postgres'
    POSTGRES_PASSWORD = 'BhHMCykkd6YbvE3P'
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
                docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
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
