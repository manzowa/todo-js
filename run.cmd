@echo off
setlocal

REM ==========================================
REM Todo App Docker Compose Manager
REM Usage: manage.cmd start|stop|restart|clean
REM ==========================================

set URL=http://localhost:8080

IF "%1"=="" (
    echo Usage: run.cmd start^|stop^|restart^|clean
    goto :EOF
)

IF /I "%1"=="start" (
    echo ==========================================
    echo Starting Todo App...
    echo ==========================================
    docker-compose up --build -d
    echo Todo App is running at %URL%
    start "" %URL%
    goto :EOF
)

IF /I "%1"=="stop" (
    echo ==========================================
    echo Stopping Todo App...
    echo ==========================================
    docker-compose down
    echo Containers stopped.
    goto :EOF
)

IF /I "%1"=="restart" (
    echo ==========================================
    echo Restarting Todo App...
    echo ==========================================
    docker-compose down
    docker-compose up --build -d
    echo Todo App restarted at %URL%
    start "" %URL%
    goto :EOF
)

IF /I "%1"=="clean" (
    echo ==========================================
    echo Cleaning Docker environment...
    echo ==========================================
    docker-compose down --volumes --rmi all
    echo Containers, volumes, and images removed.
    goto :EOF
)

echo Invalid option: %1
echo Usage: run.cmd start^|stop^|restart^|clean