podTemplate(label: label, containers: [
  containerTemplate(name: 'terraform', image: 'mounabal/terraform_12.21', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'ansible', image: 'mounabal/ansible_2.9.3', command: 'cat', ttyEnabled: true),
  containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.8', command: 'cat', ttyEnabled: true),
volumes: [
  hostPathVolume(mountPath: '/home/gradle/.gradle', hostPath: '/tmp/jenkins/.gradle'),
  hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
])
{

node ('slave_jenkins') {

    def image="version-${env.BUILD_ID}"

    
    stage ('Clone Git Terraform'){ 
        git url: 'https://github.com/Mounagit/MamboNo5.git'
    }  
    

    
/*    stage('Terraform init'){
        container('terraform-az') {
                // Initialize the plan 
                sh  """
                    cd terraform-plans/create-vmss-from-image
                    terraform init -input=false
                   """
            }
        }  */
    
    
    // On récupère le code Terraform dans Dockerhub pour Terrformer les VMs Test et Prod
    stage ('Job Terraform'){
        withCredentials([file(credentialsId: 'backend', variable: 'backend')]){
            sh 'terraform init'
            sh 'terraform plan -out=out.tfstate -var-file=main.tfvars -var-file=$FILE'
            sh 'terraform apply out.tfstate'
        }
    }

    stage ('Clone Git Ansible'){
        git url: 'https://github.com/Mounagit/devopsapps.git'
    }

    
    
    


    stage ('Clone Git Ansible'){
        git url: 'https://github.com/girldevops/Restful-Webservice.git'
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

}
