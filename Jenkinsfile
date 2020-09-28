pipeline {
  agent any
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
                docker run -v ${JENKINS_HOME}/workspace/My_Pipeline_master:/liquibase/changelog liquibase/liquibase --url="jdbc:postgresql://aurora.dev1.leaseeagle.com:5432/postgres?currentSchema=leaseeagle25_gj" --changeLogFile=../liquibase/changelog/samplechangelog.h2.sql --username=postgres --password=BhHMCykkd6YbvE3P update
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
