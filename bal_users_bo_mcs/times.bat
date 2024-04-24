@echo off
setlocal
set start=%time%
echo Start Time: %start%

:: Start your service
call .\target\bin\bal_users_bo_mcs.exe

endlocal
