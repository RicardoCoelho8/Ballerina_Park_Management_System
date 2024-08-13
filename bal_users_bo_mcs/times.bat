@echo off
setlocal
set start=%time%
echo Start Time: %start%

REM Start the container
docker start users

endlocal
