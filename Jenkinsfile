pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                input "Does the staging environment look ok?"
            }
        }
    }
  parameters {
    booleanParam(
      name: 'DEPLOY_DEV_STAGE',
      defaultValue: false,
      description: 'This will deploy to the development environment.'
    )
    booleanParam(
      name: 'DEPLOY_STAGING_STAGE',
      defaultValue: false,
      description: 'Deploy to staging. Note: Only the migration-postgres branch can be deployed to prod.'
    )
    booleanParam(
      name: 'DEPLOY_PROD_STAGE',
      defaultValue: false,
      description: 'Deploy to production. Note: Only the master branch can be deployed to prod.'
    )
  }
}
