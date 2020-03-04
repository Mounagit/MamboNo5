// Lancement des jobs sur le slave
node('slave') {
    /* On clone le projet sur notre git :
    Puis on le run pour le tester
    Si il y a un rpoblème, on l'identifie et on le corrige */
    stage('Clone du git du projet'){       
        git url: 'https://github.com/Mounagit/Code_Source.git'
    }
    
    stage('Build du jar avec Maven') {
        sh "mvn clean package"
    }
    /*
    stage('on push le jar sur le serveur') {
        withCredentials([sshUserPrivateKey(credentialsId: 'slave', keyFileVariable: 'key', passphraseVariable: '', usernameVariable: 'jpr')]) {
            sh "scp -i \$key target/restfulweb-1.0.0-SNAPSHOT.jar jpr@jpr-devops-test.francecentral.cloudapp.azure.com:/home/jpr"
        }
    }
    
    //dans une image docker
    docker.image('mounabal/terraform_12.21).inside() {
    
        //on recupere le git pour avoir nos fichiers Terraform     
        stage('git des fichiers Terraform dans une image Docker') {
            git url: 'https://gitlab.com/projet_final1/pile.git'
        }
        
        //on place les fichiers terraform dans le repertoire de travail
        stage('on copie les fichiers terraform dans le repertoire de travail'){
            sh "mv ./terraform/* ."
        }
        
        stage('Terraform Init'){
                //on passe les fichiers de credential   
                withCredentials([file(credentialsId: 'backend', variable: 'test')]) {
                
                //on initialise terraform
                sh "terraform init"
                
                //on plan terraform
                sh "terraform plan -var 'env=toto' -var-file=\$test -out planfile"
            }
        }
        
        stage('Terraform Aplication'){
            sh "terraform apply planfile"
        }
    
        //on deploie la config avec ansible
        stage('Deploiement Ansible') {
            
                ansiblePlaybook (
                    colorized: true, 
                    become: true,
                    playbook: 'ansible/playbook-prod.yml',
                    inventory: 'ansible/inventory.ini',
                    hostKeyChecking: false,
                    credentialsId: 'slave'
                )
            
        }
    }*/
}


