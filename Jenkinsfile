pipeline {
  agent any

  tools {
    maven 'M2_Home'
    }
  
  stages {
    stage('CheckOut') {
      steps {
        echo 'Checkout the source code from GitHub'
        git branch: 'main', url: 'https://github.com/RamisettyNaveen/InsureMe-Project'
            }
    }
   stage('Package') {
      steps {
        echo 'Generate a jar file the package using Maven'
        sh 'mvn clean package'
            }
    }
   stage('Publish TestNG report') {
      steps {
        echo 'Generate a TestNG report'
        publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/root/.jenkins/workspace/InsureMe-Project/target', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
    }
   stage('Create Docker Image') {
      steps {
        echo 'Create a Docker Image'
        sh 'docker build -t rnavindevops/insure-me:1.0 .'
            }
    }
     stage('Docker Login') {
    steps {
        echo 'Docekr Login'
        withCredentials([usernamePassword(credentialsId: 'dockerlogin', passwordVariable: 'dockerhub_pass', usernameVariable: 'dockerhub_user')])  {
            sh "docker login -u ${env.dockerhub_user} -p ${env.dockerhub_pass}"
        }
    }
}
     stage('Push Docker Image') {
      steps {
        echo 'Push a Docker Image'
        sh 'docker push rnavindevops/insure-me:1.0'
                   }
            }
     stage('Ansible config and Deployment') {
       steps {
        ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'ansible.yml', vaultTmpPath: ''
            }
       }
    }
}
