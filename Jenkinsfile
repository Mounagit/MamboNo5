// Lancement des jobs sur le slave
node('slave') {
    // Clone du projet corrigé sur notre git :
    stage('Clone du git du projet'){       
        git url: 'https://github.com/Mounagit/Code_Source.git'
    }
    
    stage('Build du jar avec Maven') {
        sh "mvn clean package"
    }
}


