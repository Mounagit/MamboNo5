node ('slave_jenkins') {

    def image="version-${env.BUILD_ID}"

    stage ('clone git'){ 
        git url: 'https://github.com/girldevops/Restful-Webservice.git'
    }

    stage ('terraform job'){
        withCredentials([file(credentialsId: 'MounaSylvain', variable: 'FILE')]){
            sh 'terraform init'
            sh 'terraform plan -out=out.tfstate -var-file=main.tfvars -var-file=$FILE'
            sh 'terraform apply out.tfstate'
        }
    }

    stage ('clone git projet'){
        git url: 'https://github.com/Mounagit/devopsapps.git'
    }

    stage ('build projet'){
        sh '/opt/apache-maven-3.6.3/bin/mvn clean install'  
    }

    // Récupération Roles Ansible et autres
    stage ('clone git'){ 
        git url: 'https://github.com/Mounagit/Projet_terraformPileComplete.git'
    }

    stage ('ansible') {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'login', passwordVariable: 'password']]){
            ansiblePlaybook(
                credentialsId: 'MounaNeko2',
                become: true,
                inventory: 'inventory',
                playbook: 'playbook_deploy.yml',
                hostKeyChecking: false,
                extras: "--extra-vars 'image=$image login=$login password=$password'"
            )
        }
    }
    
    stage ('Publish test results') {
        junit 'target/surface-reports/.*.xml'
    }
}
