cd ..
cd eureka
cmd /C mvn clean install -DskipTests
cd ..
cd api-gateway
cmd /C mvn clean install -DskipTests
cd ..
cd bal_api_gateway
cmd /C bal clean
cmd /C bal build --cloud=docker
cd ..
cd park_bo_mcs
cmd /C mvn clean install -DskipTests
cd ..
cd payments_bo_mcs
cmd /C mvn clean install -DskipTests
cd ..
cd users_bo_mcs
cmd /C mvn clean install -DskipTests
cd ..
cd bal_users_bo_mcs
cmd /C bal clean
cmd /C bal build --cloud=docker
cd ..
cd display_mcs_fe
cmd /C mvn clean install -DskipTests
cd ..
cd barrier_mcs_fe
cmd /C mvn clean install -DskipTests