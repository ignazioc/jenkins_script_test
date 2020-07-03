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
                    echo "FFFFF: ${script_output}"
                    if (script_output == 0) {
                        echo "Eveything is fine"
                    }
                    else if (script_output == 10) {
                        echo "Error n. 10!"
                    } else {
                        echo "Some other error"
                    }
                    // def command_stdout = "foo"
                    // try {
                    //     // shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
                    //     command_stdout = sh(returnStatus: true, script: "./vendor_list_updater.sh")
                    // } catch (err) {
                    //     echo "1111111"
                    //     echo "Failed: ${err}"
                    //     echo "Failed: ${command_stdout}"

                    // } finally {
                    //     echo "222222"
                    //     echo "222222: ${command_stdout}"
                        
                    // }
                }
                // sh script: 'ls -l /', returnStdout: true
                // b = sh script: 'ls -l /', returnStdout: true
                // EXIT_CODE = sh (script: './vendor_list_updater.sh', returnStatus: true)
                // if (EXIT_CODE == '10') {
                //     ekSlackSend(color: '#808080', message: "10 10 10")
                // } else if (EXIT_CODE == '20') {
                //     ekSlackSend(color: '#808080', message: "20 20 20")
                // }
                // sh './vendor_list_updater.sh'
            }
        }
    }
}
