FROM tomcat:latest
EXPOSE 8080
COPY /var/lib/jenkins/workspace/testing/webapp/target/webapp webapp.war 
ENTRYPOINT ["java","-war","/webapp.war"]
