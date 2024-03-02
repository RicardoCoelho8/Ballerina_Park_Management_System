@echo off
setlocal
set start=%time%
echo Start Time: %start%

:: Start your service
call .\target\bin\bal_api_gateway.exe

endlocal
