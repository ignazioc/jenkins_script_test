#!groovy

// We're using our own Jenkins Pipeline Library to keep the Jenkinsfiles compact.
// More details: https://github.corp.ebay.com/eBay-Kleinanzeigen/jenkins-shared-build-libraries


pipeline {
    agent any
    // triggers {
    //     // cron('* * * * *')
    //     // Every Thursday at 17.05
    //     // cron('5 17 * * 4')
    // }
    environment {
        EK_SLACK_CHANNEL = 'ek-gdpr-jenkins-tests'
    }
    stages {
        stage('Update Consent service and redeploy') {
            steps {
                script {
                    def script_output = sh(returnStatus: true, script: "./vendor_list_updater.sh")
                    if (script_output == 0) {
                        echo "Eveything is fine"
                    }
                    else if (script_output == 10) {
                        error("Vendor list and purposes do not match")
                    } else {
                        echo "Some other error"
                    }

                }
                
            }
        }
    }
}
