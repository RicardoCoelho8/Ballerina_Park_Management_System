@echo off
setlocal
set start=%time%
echo Start Time: %start%

:: Start your service
call java -jar bal_api_gateway.jar

endlocal
