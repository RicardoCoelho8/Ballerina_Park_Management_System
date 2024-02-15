cd Setup
cmd /C Install.bat
cd ..
cd DataBases
    docker-compose up -d
cd ..

timeout /t 10 /nobreak

docker-compose up -d