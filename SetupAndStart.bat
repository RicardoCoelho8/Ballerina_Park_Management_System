cd Setup
cmd /C Install.bat
cd ..
cd DataBases
    docker-compose up
cd ..

timeout /t 20 /nobreak

docker-compose up