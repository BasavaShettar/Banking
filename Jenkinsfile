pipeline{
  agent any
  tools{
   maven 'MAVEN_HOME'
  }
  
  stages{
    stage('GIT CHECKOUT'){
      steps{
          git branch: 'main', url: 'https://github.com/BasavaShettar/Banking.git'
      }
    }

    stage ('MAVEN PACKAGEE')
    {
      steps{
      sh 'mvn clean install'
        }
    }

    stage ('HTML REPORT')
    {
      steps{
publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Banking/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
      
      }
    }
      
    stage('DOCKER BUILD')
          {
            steps{
                 sh 'docker build -t basavarajshettar/banking-app:1.0 .'
            }
          }
stage('DOCKER PUSH') {
    steps {
    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
          sh ' docker login -u basavarajshettar -p ${dockerhubpwd}'
}
      sh 'docker push basavarajshettar/banking-app:1.0'   
            }
        }
    /*
    stage('DEPLOY ON SERVERR'){
  steps{
ansiblePlaybook credentialsId: 'Ansible_Server', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'Dev.inv', playbook: 'ansible-playbook.yml'
  } 
}
 */   
    stage ('Configure Test-server with Terraform, Ansible and then Deploying'){
            steps {
                
                sh 'sudo chmod 600 NewKey.pem'
                sh 'sudo apt-get install terraform'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
            }
    }
}
  }
