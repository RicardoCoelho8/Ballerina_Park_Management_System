@echo off
setlocal
set start=%time%
echo Start Time: %start%

REM Start the container
docker start ballerina_park_management_system-ballgateway-1

endlocal
