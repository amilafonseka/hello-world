pipeline {
  agent any
    stages {
      

      
        stage('Run Migration Scripts before Gradle Build') {
            steps {
             script {
               
                withAWSParameterStore(credentialsId: 'AWS_DEV', naming: 'absolute', path: '/PostgreSchemaList/', recursive: true, regionName: 'ap-southeast-2') {
                  
                } 
               
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
                aws --version
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
