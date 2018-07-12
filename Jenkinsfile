node { 
        git url: 'https://github.com/poloz2005/jjenkins.git'
        dev main 
                stage("build")
                        myimage = docker.build("poloz942/web")
                
                stage('Push image')
                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub'){
                        myimage.push("${env.BUILD_ID}")
                        myimage.push("latest")
                       }
    
                stage("clean")
                        sh "docker image prune -af"
        try {
                stage("Deploy_on_emote_machine")
                        sh "sudo docker-machine ssh nginx-prod sudo docker pull poloz942/web"
                        sh "sudo docker-machine ssh nginx-prod sudo docker stop myimage"
                        sh "sudo docker-machine ssh nginx-prod sudo docker run -d --rm  -p 80:80 --name myimage  poloz942/web"
        }           
}
