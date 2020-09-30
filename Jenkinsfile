pipeline {
  agent any
  environment {
        POSTGRES_SCHEMAS_LIST = '$(aws ssm get-parameters --region $REGION --names /PostgreSchemaList )'
  }
    stages {
      

      
        stage('Run Migration Scripts before Gradle Build') {
            steps {
             script { 
                echo sh(returnStdout: true, script: 'env')
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
                
                docker run --rm -v ${JENKINS_HOME}/workspace/My_Pipeline_master:/liquibase/changelog liquibase/liquibase --url="jdbc:postgresql://aurora.dev1.leaseeagle.com:5432/postgres?currentSchema=leaseeagle25_gj" --changeLogFile=../liquibase/changelog/samplechangelog.h2.sql --username=postgres --password=BhHMCykkd6YbvE3P update
                docker ps -a
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
