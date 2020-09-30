pipeline {
  agent any
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
                #!/bin/bash
                postgresSchemasList=$(aws ssm get-parameters --region ap-southeast-2 --names /PostgreSchemaList --query Parameters[0].Value)
                for i in $(echo $postgresSchemasList | sed -e 's/^"//' -e 's/"$//' -e 's/,/ /g' )
                do
                # call your procedure/other scripts here below
                 echo "$i"
                  docker run --rm -v ${JENKINS_HOME}/workspace/My_Pipeline_master:/liquibase/changelog liquibase/liquibase --url="jdbc:postgresql://aurora.dev1.leaseeagle.com:5432/postgres?currentSchema=$i" --changeLogFile=../liquibase/changelog/samplechangelog.h2.sql --username=postgres --password=BhHMCykkd6YbvE3P update
                done
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
