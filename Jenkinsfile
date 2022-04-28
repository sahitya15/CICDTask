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
	
	stage("Publish to Nexus Repository Manager") {
            steps {
            nexusArtifactUploader artifacts: [[artifactId: 'com.example.maven-project', classifier: '', file: '/var/lib/jenkins/workspace/pipeline-project/webapp/target/webapp.war', type: 'war']], credentialsId: 'nexux-user-credentials', groupId: 'com.example.maven-project', nexusUrl: '34.234.79.194:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-nexus-repo/', version: '1.0-SNAPSHOT'
            }
	    }
	
	stage('Sonarqube') {
    
            stage ('build && SonarQube analysis') {
                  steps {
                          withSonarQubeEnv('sonar') {
                                  // some block                                 
                                  
                                  withMaven(jdk: 'JAVA_HOME', maven: 'MAVEN_HOME') {
                                    sh 'mvn clean package sonar:sonar'
                                   }
                          }

                  }
            
            }
    }
}

    }
	}
	
	
	
	