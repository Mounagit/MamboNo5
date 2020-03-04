environment {
    registry = "mounabal/terraform_12.21"
    registryCredential = 'dockerhub'
}

node {

    stage ('clone git'){ 
        git url: 'https://github.com/Mounagit/Projet_terraformPileComplete.git'
    }
    
    stage ('terraform job'){
        withCredentials([file(credentialsId: 'dockerhub', variable: 'FILE')]){
            sh 'terraform init'
            sh 'terraform plan -out=out.tfstate -var-file=main.tfvars -var-file=$FILE'
            sh 'terraform apply out.tfstate'
        }
    }

    stage('Publish test results') {
        junit 'target/surefire-reports/*.xml'
    }

}
