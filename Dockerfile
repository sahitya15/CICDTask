FROM tomcat:latest
EXPOSE 8080
COPY target/*.war / webapp.war 
ENTRYPOINT ["java","-war","/webapp.war"]
