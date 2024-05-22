node {
  def dockerHubRepo = 'daumsimac@gmail.com/daumsimac'
  def dockerHubCredentialsId = 'DockerHub_ID' 
  
  stage("Clone the project") {
    git branch: 'main', url: 'https://github.com/daumsimac/restapidemo.git'
  }

  stage("Compilation") {
    sh "chmod +x ./gradlew"
    sh "./gradlew clean build -x test"
  }

  stage("Tests and Deployment") {
    stage("Running unit tests") {
      sh "chmod +x ./gradlew"
      sh "./gradlew test"
    }
    stage("Deployment") {
      sh "chmod +x ./gradlew"
      sh 'nohup ./gradlew bootRun -Dserver.port=8080 &'
      sh 'echo #!asdf2580 | sudo docker login -u daumsimac@gmail.com --password-stdin'
      sh 'sudo docker build -t daumsimac/restapidemo:1.0 .'
    }
    stage('Push Docker Image') {
        script {
            docker.withRegistry('https://index.docker.io/v1/', dockerHubCredentialsId) {
                def image = docker.image("daumsimac/restapidemo:1.0")
                image.push()
                image.push('1.0')
            }
        }
    }
  }
}
