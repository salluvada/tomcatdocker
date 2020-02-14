FROM openjdk:latest
RUN powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
RUN choco install tomcat -y
WORKDIR /ProgramData/Tomcat9/webapps
COPY sample.war sample.war
RUN powershell -Command Remove-Item -Path examples -Recurse
WORKDIR /
RUN powershell -Command New-Item -Name "psscripts" -Path ./ -ItemType "directory"
COPY psscripts/. /psscripts/.
EXPOSE 8080
CMD ["tomcat9"]