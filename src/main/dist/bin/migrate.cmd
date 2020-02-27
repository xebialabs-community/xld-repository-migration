@echo off

@REM
@REM # THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
@REM IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
@REM FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
@REM

REM
REM Batch script to migrate the Deployit Server
REM

setlocal ENABLEDELAYEDEXPANSION

REM Get Java executable
if "%JAVA_HOME%"=="" (
  set JAVACMD=java
) else (
  set JAVACMD="%JAVA_HOME%\bin\java"
)

REM Get JVM options
if "%DEPLOYIT_SERVER_OPTS%"=="" (
  set DEPLOYIT_SERVER_OPTS=-Xmx1024m -XX:MaxPermSize=128m
)

REM Get logging-related options
if "%DEPLOYIT_SERVER_LOG_OPTS%"=="" (
  set DEPLOYIT_SERVER_LOG_OPTS=-Dlogback.configurationFile=conf\logback.xml -Dderby.stream.error.file=log\derby.log
)

REM Get Deployit server home dir
if "%DEPLOYIT_SERVER_HOME%"=="" (
  cd /d "%~dp0"
  cd ..
  set DEPLOYIT_SERVER_HOME=!CD!
)

cd /d "%DEPLOYIT_SERVER_HOME%"

REM Build Deployit server classpath
set DEPLOYIT_SERVER_CLASSPATH="%DEPLOYIT_SERVER_HOME%\conf\*;%DEPLOYIT_SERVER_HOME%\ext\*;%DEPLOYIT_SERVER_HOME%\hotfix\*;%DEPLOYIT_SERVER_HOME%\lib\*;%DEPLOYIT_SERVER_HOME%\plugins\*"

REM Run Deployit server
%JAVACMD% %DEPLOYIT_SERVER_OPTS% %DEPLOYIT_SERVER_LOG_OPTS% -cp "%DEPLOYIT_SERVER_CLASSPATH%" com.xebialabs.deployit.tools.RepositoryMigration %*

:end
endlocal
