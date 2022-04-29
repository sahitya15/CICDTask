FROM tomcat:latest
LABEL app=web
COPY /webapp/target/*.war /usr/local/tomcat/webapps/
CMD ["java", "-war", "webapp.war"]
