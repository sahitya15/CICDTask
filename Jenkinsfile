
pipeline {
    agent any
    
    stages{
        stage('get scm'){
            steps{

			checkout([$class: 'GitSCM', branches: [[name: '*/master']],
			extensions: [], 
			userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/sahitya15/CICDTask.git']]])
       
        }
    }

         stage('Mvn Package'){
             steps{
                 
         sh 'mvn clean package'
            
             }
    }

stage('Publish to Nexus Repository Manager') {
            steps {
            nexusArtifactUploader artifacts: [[artifactId: 'com.example.maven-project', classifier: '', file: '/var/lib/jenkins/workspace/pipeline-project/webapp/target/webapp.war', type: 'war']], credentialsId: 'nexux-user-credentials', groupId: 'com.example.maven-project', nexusUrl: '34.234.79.194:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-nexus-repo/', version: '1.0-SNAPSHOT'
            }
	    }

stage('Build Docker Image') {
            steps {
                script {
                  sh 'docker build -t sahitya15/task-cicd .'
                }
            }
        }
		
stage ('Push Docker image to DockerHub') {
    steps {
withCredentials([usernameColonPassword(credentialsId: 'dockerhub', variable: 'dockerhubcred')]) {
sh 'docker login -u sahitya15 -p sahitya15@'
sh 'docker push sahitya15/task-cicd'
}
}
}

stage ('Deploy to Dev') {
steps {
sshagent(['deploy-to-dev-docker']) {
sh 'ssh -o StrictHostKeyChecking=no ec2-user@34.201.3.203'
sh 'docker run -d -p 9000:8080 sahitya15/task-cicd'
}
}
}

stage('SonarQube Analysis') {
		 steps {
        withSonarQubeEnv('sonar') 
        {
                 // some block                                 
                                  
                withMaven(jdk: 'JAVA_HOME', maven: 'MAVEN_HOME') {
                 sh 'mvn clean package sonar:sonar'
                                   }
                          }
        }
    }

	}
	}