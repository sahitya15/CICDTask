FROM tomcat:latest
COPY target/*.war / webapp.war 
ENTRYPOINT ["java","-war","/webapp.war"]
