import ballerina/jwt;
import ballerina/regex;
import ballerina/sql;
import ballerinax/postgresql;
import ballerinax/postgresql.driver as _;

// jwt configurations -----------------------------------------------------------------------------------
final string secretKey = "jhewiwrvmqere3";

// DATABASE CONFIGS -------------------------------------------------------------------------------------

final postgresql:Client userDBClient = check new ("db_users_bo_mcs_1", "postgres", "postgrespw", "postgres", 5510);
isolated int currentUsers = 6;

// DOMAIN -----------------------------------------------------------------------------------------------

public class AccessToken {
    string? token;
    string? name;

    public isolated function init(string token, string name) {
        self.token = token;
        self.name = name;
    }

    public isolated function toJson() returns json {
        return {
            "token": self.token,
            "name": self.name
        };
    }
};

public class Email {
    string? email;

    public isolated function init(string email) {
        self.email = email;
    }

    public isolated function getEmail() returns string? {
        return self.email;
    }
};

public class Name {
    string firstName;
    string lastName;

    public isolated function init(string firstName, string lastName) {
        self.firstName = firstName;
        self.lastName = lastName;
    }

    public isolated function getFirstName() returns string {
        return self.firstName;
    }

    public isolated function getLastName() returns string {
        return self.lastName;
    }
};

public class ParkingHistory {
    string? parkingHistoryId;
    string startTime;
    string? endTime;
    int parkId;

    public isolated function init(string parkingHistoryId, string startTime, string endTime, int parkId) {
        self.parkingHistoryId = parkingHistoryId;
        self.startTime = startTime;
        self.endTime = endTime;
        self.parkId = parkId;
    }

    public isolated function toJson() returns json {
        return {
            "parkingHistoryId": self.parkingHistoryId,
            "startTime": self.startTime,
            "endTime": self.endTime,
            "parkId": self.parkId
        };
    }
};

public class ParkyTransactionEvent {
    int event_id;
    int? amount;
    string? reason;
    int? managerId;
    string? transaction_time;

    public isolated function init(int event_id, int? amount, string? reason, int? managerId, string transaction_time) {
        self.event_id = event_id;
        self.amount = amount;
        self.reason = reason;
        self.managerId = managerId;
        self.transaction_time = transaction_time;
    }

    public isolated function getAmount() returns int? {
        return self.amount;
    }

    public isolated function toJson() returns json {
        return {
            "eventId": self.event_id,
            "amount": self.amount,
            "reason": self.reason,
            "managerId": self.managerId,
            "transactionTime": self.transaction_time
        };
    }
};

public class ParkyWallet {
    int? id;
    int parkies;
    ParkyTransactionEvent[] parkyEvents;

    public isolated function init(int? id, int parkies, ParkyTransactionEvent[] parkyEvents) {
        self.id = id;
        self.parkies = parkies;
        self.parkyEvents = parkyEvents;
    }

    public isolated function getParkies() returns int {
        return self.parkies;
    }

    public isolated function addEvent(ParkyTransactionEvent event) returns boolean {
        if (self.parkies + event.getAmount() < 0) {
            return false;
        }

        self.parkyEvents.push(event);
        self.parkies = self.parkies + parseInt(event.getAmount());
        return true;
    }
};

public class ParkyWalletDTO {
    int? userId;
    int? parkies;
    ParkyTransactionEvent[]? parkyEvents;

    public isolated function init(int? userId, int? parkies, ParkyTransactionEvent[]? parkyEvents) {
        self.userId = userId;
        self.parkies = parkies;
        self.parkyEvents = parkyEvents;
    }

    public isolated function toJsonWithParkyEventJson(json parkyEvents) returns json {
        return {
            "userId": self.userId,
            "parkies": self.parkies,
            "parkyEvents": parkyEvents
        };
    }
};

public class Password {
    string password;

    public isolated function init(string password) {
        self.password = password;
    }

    public isolated function getPassword() returns string {
        return self.password;
    }
};

public isolated function isValidPassword(string? password) returns boolean {
    string auxPassword = password.toString();
    boolean isValid = regex:matches(auxPassword, "(?=.*\\b)(?=.*[a-z])(?=.*[A-Z])((?=.*\\W)|(?=.*_))^[^ ]+$");
    if (!(auxPassword.length() > 10 && isValid == true && auxPassword.length() < 20)) {
        return false;
    } else {
        return true;
    }
};

public class PaymentDTO {
    PaymentMethod? paymentMethod;

    public isolated function init(PaymentMethod paymentMethod) {
        self.paymentMethod = paymentMethod;
    }

    public isolated function toJson() returns json {
        return {
            "paymentMethod": self.paymentMethod
        };
    }
};

public enum Role {
    SUPERVISOR,
    CUSTOMER,
    CUSTOMER_MANAGER,
    PARK_MANAGER
};

public enum PaymentMethod {
    CREDIT,
    DEBIT,
    PAYPAL,
    NOT_DEFINED
};

public enum UserStatus {
    ENABLED,
    DISABLED,
    BLOCKED
};

public class TaxIdNumber {
    int nif;

    public isolated function init(int nif) {
        self.nif = nif;
    }

    public isolated function getNif() returns int {
        return self.nif;
    }
};

public class Top10ParkyDTO {
    string? name;
    string? email;
    int? parkies;

    public isolated function init(string? name, string? email, int? parkies) {
        self.name = name;
        self.email = email;
        self.parkies = parkies;
    }
};

public enum VehicleType {
    AUTOMOBILE,
    MOTORCYCLE
};

public enum VehicleEnergySource {
    FUEL,
    GPL,
    ELECTRIC,
    PLUG_IN_HYBRID
};

public class Vehicle {
    string licensePlate;
    VehicleType vehicleType;
    VehicleEnergySource vehicleEnergySource;

    public isolated function init(string licensePlate, VehicleType vehicleType, VehicleEnergySource vehicleEnergySource) {
        self.licensePlate = licensePlate;
        self.vehicleType = vehicleType;
        self.vehicleEnergySource = vehicleEnergySource;
    }

    public isolated function toJson() returns json {
        return {
            "licensePlateNumber": self.licensePlate,
            "vehicleType": self.vehicleType,
            "vehicleEnergySource": self.vehicleEnergySource
        };
    }
};

public class VehicleOutput {
    Vehicle[] vehicles;
    json vehiclesJson;

    public isolated function init(Vehicle[] vehicles, json vehiclesJson) {
        self.vehicles = vehicles;
        self.vehiclesJson = vehiclesJson;
    }
}

public class ParkyTransitionEventOutput {
    ParkyTransactionEvent[] parkyEvents;
    json parkyEventsJson;

    public isolated function init(ParkyTransactionEvent[] parkyEvents, json parkyEventsJson) {
        self.parkyEvents = parkyEvents;
        self.parkyEventsJson = parkyEventsJson;
    }
}

public class ParkingHistoryOutput {
    ParkingHistory[] parkingHistory;
    json parkingHistoryJson;

    public isolated function init(ParkingHistory[] parkingHistory, json parkingHistoryJson) {
        self.parkingHistory = parkingHistory;
        self.parkingHistoryJson = parkingHistoryJson;
    }
}

public class UserDTO {
    int? userId;
    string? firstName;
    string? lastName;
    string? email;
    int? nif;
    ParkingHistory[]? parkingHistory;
    int? parkies;
    Vehicle[]? vehicles;
    Role? role;
    PaymentMethod? paymentMethod;
    UserStatus? status;

    public isolated function init(int? userId, string? firstName, string? lastName, string? email, int? nif, ParkingHistory[]? parkingHistory, int parkies, Vehicle[]? vehicles, Role? role, PaymentMethod? paymentMethod, UserStatus? status) {
        self.userId = userId;
        self.firstName = firstName;
        self.lastName = lastName;
        self.email = email;
        self.nif = nif;
        self.parkingHistory = parkingHistory;
        self.parkies = parkies;
        self.vehicles = vehicles;
        self.role = role;
        self.paymentMethod = paymentMethod;
        self.status = status;
    }

    public isolated function toJson() returns json {
        return {
            "id": self.userId,
            "firstName": self.firstName,
            "lastName": self.lastName,
            "email": self.email,
            "nif": self.nif,
            "role": self.role,
            "paymentMethod": self.paymentMethod,
            "userStatus": self.status
        };
    }

    public isolated function toJsonWithArrays(json vehicles, json parkingHistory) returns json {
        return {
            "id": self.userId,
            "firstName": self.firstName,
            "lastName": self.lastName,
            "email": self.email,
            "nif": self.nif,
            "parkingHistory": parkingHistory,
            "totalParkies": self.parkies,
            "vehicles": vehicles,
            "role": self.role,
            "paymentMethod": self.paymentMethod,
            "userStatus": self.status
        };
    }
};

public class User {
    int? userId;
    Name name;
    Email email;
    Password password;
    TaxIdNumber nif;
    ParkingHistory[] parkingHistory;
    Vehicle[] vehicles;
    ParkyWallet parkies;
    Role role;
    PaymentMethod paymentMethod;
    UserStatus status;

    public isolated function init(int? userId, Name name, Email email, Password password, TaxIdNumber nif, ParkingHistory[] parkingHistory, Vehicle[] vehicles, ParkyWallet parkies, Role role, PaymentMethod paymentMethod, UserStatus status) {
        self.userId = userId;
        self.name = name;
        self.email = email;
        self.password = password;
        self.nif = nif;
        self.parkingHistory = parkingHistory;
        self.vehicles = vehicles;
        self.parkies = parkies;
        self.role = role;
        self.paymentMethod = paymentMethod;
        self.status = status;
    }

    public isolated function setRole(Role role) {
        self.role = role;
    }

    public isolated function addVehicle(Vehicle vehicle) returns boolean {
        if (self.vehicles.length() >= 3) {
            return false;
        }
        self.vehicles.push(vehicle);
        return true;
    }

    public isolated function addParkyTransactionEvent(ParkyTransactionEvent event) returns boolean {
        return self.parkies.addEvent(event);
    }

    public isolated function toDto(User user) returns UserDTO {
        return new UserDTO(user.userId, user.name.getFirstName(), user.name.getLastName(), user.email.getEmail(), user.nif.getNif(), [], user.parkies.getParkies(), [], user.role, user.paymentMethod, user.status);
    }
};

public type ParkyTransactionEventRecord record {
    int parky_wallet_id;
    int event_id;
    int? amount;
    int manager_id;
    string? reason;
    string transaction_time;
};

public type ParkyTransactionRequest record {
    int[] userIds;
    int? amount;
    string? reason;
};

public type PaymentRequestRecord record {
    PaymentMethod paymentMethod;
};

public type AccessTokenRecord record {
    string token;
    string name;
};

public type UserCredentials record {
    string email;
    string password;
};

public type UserRecord record {
    int userId;
    string? firstName;
    string? lastName;
    string email;
    int nif;
    int parkies;
    int role;
    int paymentMethod;
    int status;
    string password;
    int user_id;
    string last_name;
    string first_name;
    int payment_method;
    int parkies_id;
};

public type UserOnCreation record {
    string firstName;
    string lastName;
    string email;
    string password;
    string accountNumber;
    int nif;
    string licensePlateNumber;
    VehicleType vehicleType;
    VehicleEnergySource vehicleEnergySource;
    PaymentMethod paymentMethod;
};

public type VehicleOnCreation record {
    string licensePlateNumber;
    VehicleType vehicleType;
    VehicleEnergySource vehicleEnergySource;
};

public type UserVehicleRecord record {
    int user_user_id;
    string vehicles_license_plate_number;
};

public type UserVehicleJOINRecord record {
    int user_user_id;
    string license_plate_number;
    int vehicle_energy_source;
    int vehicle_type;
};

public type ParkingHistoryRecord record {
    int user_user_id;
    string parking_history_id;
    string end_time;
    int park_id;
    string start_time;
};

public type VehicleRecord record {
    string license_plate_number;
    int vehicle_energy_source;
    int vehicle_type;
};

// AUX FUNCTIONS ----------------------------------------------------------------------------------------
public isolated function isContain(int[] array1, int id) returns boolean {
    return array1.indexOf(id) != ();
}

public isolated function parseInt(int? value) returns int {
    if (value == null) {
        return 0;
    }
    return value;
};

public isolated function mapStringToInt(anydata types) returns int {
    match types {
        AUTOMOBILE => {
            return 0;
        }
        FUEL => {
            return 0;
        }
        ENABLED => {
            return 0;
        }
        DISABLED => {
            return 1;
        }
        MOTORCYCLE => {
            return 1;
        }
        GPL => {
            return 1;
        }
        ELECTRIC => {
            return 2;
        }
        BLOCKED => {
            return 2;
        }
        PLUG_IN_HYBRID => {
            return 3;
        }
        CREDIT => {
            return 0;
        }
        DEBIT => {
            return 1;
        }
        PAYPAL => {
            return 2;
        }
        NOT_DEFINED => {
            return 3;
        }
        SUPERVISOR => {
            return 0;
        }
        CUSTOMER => {
            return 1;
        }
        CUSTOMER_MANAGER => {
            return 2;
        }
        PARK_MANAGER => {
            return 3;
        }
        _ => {
            return -1;
        }
    }
};

public isolated function mapIntToRole(int number) returns Role {
    match number {
        0 => {
            return SUPERVISOR;
        }
        1 => {
            return CUSTOMER;
        }
        2 => {
            return CUSTOMER_MANAGER;
        }
        3 => {
            return PARK_MANAGER;
        }
        _ => {
            return CUSTOMER;
        }
    }
};

public isolated function mapIntToPaymentMethod(int number) returns PaymentMethod {
    match number {
        0 => {
            return CREDIT;
        }
        1 => {
            return DEBIT;
        }
        2 => {
            return PAYPAL;
        }
        _ => {
            return NOT_DEFINED;
        }
    }
};

public isolated function mapIntToUserStatus(int number) returns UserStatus {
    match number {
        0 => {
            return ENABLED;
        }
        1 => {
            return DISABLED;
        }
        2 => {
            return BLOCKED;
        }
        _ => {
            return ENABLED;
        }
    }
};

public isolated function mapIntToVehicleType(int number) returns VehicleType {
    match number {
        0 => {
            return AUTOMOBILE;
        }
        1 => {
            return MOTORCYCLE;
        }
        _ => {
            return AUTOMOBILE;
        }
    }
};

public isolated function mapIntToVehicleEnergySource(int number) returns VehicleEnergySource {
    match number {
        0 => {
            return FUEL;
        }
        1 => {
            return GPL;
        }
        2 => {
            return ELECTRIC;
        }
        3 => {
            return PLUG_IN_HYBRID;
        }
        _ => {
            return FUEL;
        }
    }
};

public isolated function getVehiclesByUserId(int user_id) returns VehicleOutput|error {
    stream<UserVehicleJOINRecord, error?> vehicleStream = userDBClient->query(`select auv.user_user_id, v.license_plate_number, v.vehicle_energy_source, v.vehicle_type from app_user_vehicles as auv join vehicle as v on auv.vehicles_license_plate_number = v.license_plate_number where auv.user_user_id = ${user_id};`, UserVehicleJOINRecord);

    Vehicle[] vehicles = [];
    string rawData = "";
    check from UserVehicleJOINRecord vehicle in vehicleStream
        do {
            Vehicle vehicleDto = new Vehicle(vehicle.license_plate_number, mapIntToVehicleType(vehicle.vehicle_type), mapIntToVehicleEnergySource(vehicle.vehicle_energy_source));
            vehicles.push(vehicleDto);
            rawData = rawData + vehicleDto.toJson().toString() + ",";
        };
    check vehicleStream.close();
    if (rawData == "") {
        rawData = "[]";
    } else {
        rawData = rawData.substring(0, rawData.length() - 1);
        rawData = "[" + rawData + "]";
    }

    json usersJson = check rawData.fromJsonString();
    return new VehicleOutput(vehicles, usersJson);
};

public isolated function getParkingHistoryByUserId(int user_id) returns ParkingHistoryOutput|error {
    stream<ParkingHistoryRecord, error?> parkingHistoryStream = userDBClient->query(`select aup.user_user_id, p.parking_history_id, p.park_id, p.start_time from app_user_parking_history as aup join parking_history as p on aup.parking_history_parking_history_id = p.parking_history_id where aup.user_user_id = ${user_id};`, ParkingHistoryRecord);

    ParkingHistory[] parkingHistory = [];
    string rawData = "";
    check from ParkingHistoryRecord parkingHistoryRecord in parkingHistoryStream
        do {
            ParkingHistory parkingHistoryDto = new ParkingHistory(parkingHistoryRecord.parking_history_id, parkingHistoryRecord.start_time, parkingHistoryRecord.end_time, parkingHistoryRecord.park_id);
            parkingHistory.push(parkingHistoryDto);
            rawData = rawData + parkingHistoryDto.toJson().toString() + ",";
        };
    check parkingHistoryStream.close();

    if (rawData == "") {
        rawData = "[]";
    } else {
        rawData = rawData.substring(0, rawData.length() - 1);
        rawData = "[" + rawData + "]";
    }

    json usersJson = check rawData.fromJsonString();
    return new ParkingHistoryOutput(parkingHistory, usersJson);
};

public isolated function getParkyTransitionEventsByUserId(int user_id) returns ParkyTransitionEventOutput|error {
    stream<ParkyTransactionEventRecord, error?> parkyEventsStream = userDBClient->query(`select awpe.parky_wallet_id, p.event_id, p.amount, p.manager_id, p.reason, p.transaction_time from parky_wallet_parky_events as awpe join parky_transaction_event as p on awpe.parky_events_event_id = p.event_id where awpe.parky_wallet_id = ${user_id};`, ParkyTransactionEventRecord);

    ParkyTransactionEvent[] parkyEvents = [];
    string rawData = "";
    check from ParkyTransactionEventRecord parkyEvent in parkyEventsStream
        do {
            ParkyTransactionEvent parkyEventDto = new ParkyTransactionEvent(parkyEvent.event_id, parkyEvent.amount, parkyEvent.reason, parkyEvent.manager_id, parkyEvent.transaction_time);
            parkyEvents.push(parkyEventDto);
            rawData = rawData + parkyEventDto.toJson().toString() + ",";
        };
    check parkyEventsStream.close();

    if (rawData == "") {
        rawData = "[]";
    } else {
        rawData = rawData.substring(0, rawData.length() - 1);
        rawData = "[" + rawData + "]";
    }

    json usersJson = check rawData.fromJsonString();
    return new ParkyTransitionEventOutput(parkyEvents, usersJson);
};

// SERVICES ---------------------------------------------------------------------------------------------
public isolated function create(UserOnCreation userOnCreation) returns json|error? {
    boolean validation = isValidPassword(userOnCreation.password);

    if (!validation) {
        return error("Password must have at least 10 characters, one uppercase letter, one lowercase letter and one special character");
    }

    int aux;
    lock{
        currentUsers = currentUsers + 1;
        aux = currentUsers;
    }

    Name name = new Name(userOnCreation.firstName.toString(), userOnCreation.lastName.toString());
    //Since ballerina doesn't support de encode of bcrypt passwords, that validation will be validated hardcoded (default password is "123PasswordX#")
    string hashedPassword = "$2a$10$EnT4g0WsLUSH2ixKFAxeSu8l806WN0l890C2f3MbrPT11RqYCSykC";
    User user = new User(aux, name, new Email(userOnCreation.email.toString()), new Password(hashedPassword), new TaxIdNumber(parseInt(userOnCreation.nif)), [], [new Vehicle(userOnCreation.licensePlateNumber, userOnCreation.vehicleType, userOnCreation.vehicleEnergySource)], new ParkyWallet(aux, 0, []), CUSTOMER, userOnCreation.paymentMethod, ENABLED);

    sql:ExecutionResult _ = check userDBClient->execute(`insert into parky_wallet (id, parkies) values (${user.userId}, 0);`);
    sql:ExecutionResult _ = check userDBClient->execute(`insert into app_user (user_id, email, first_name, last_name, nif, password, payment_method, role, status, parkies_id) values (${user.userId}, ${user.email.getEmail()}, ${user.name.getFirstName()}, ${user.name.getLastName()}, ${user.nif.getNif()}, ${user.password.getPassword()}, ${mapStringToInt(user.paymentMethod)}, ${mapStringToInt(user.role)}, ${mapStringToInt(user.status)}, ${user.userId});`);
    sql:ExecutionResult _ = check userDBClient->execute(`insert into vehicle (license_plate_number, vehicle_energy_source, vehicle_type) values (${user.vehicles[0].licensePlate}, ${mapStringToInt(user.vehicles[0].vehicleEnergySource)}, ${mapStringToInt(user.vehicles[0].vehicleType)});`);
    sql:ExecutionResult _ = check userDBClient->execute(`insert into app_user_vehicles (user_user_id, vehicles_license_plate_number) values (${user.userId}, ${user.vehicles[0].licensePlate});`);

    return user.toDto(user).toJson();
};

public isolated function login(UserCredentials UserCredentials) returns json|error? {
    UserRecord queryResult = check userDBClient->queryRow(`select * from app_user where email = ${UserCredentials.email};`);
    UserRecord user = check queryResult.cloneWithType(UserRecord);

    //Since ballerina doesn't support de decode of bcrypt passwords, that validation will be validated hardcoded (default password is "123PasswordX#")
    string unhashedPassword = "123PasswordX#";

    jwt:IssuerConfig issuerConfig = {
        username: user.user_id.toString(),
        expTime: 6000,
        customClaims: {"role": mapIntToRole(user.role)},
        signatureConfig: {
            algorithm: "HS256",
            config: secretKey
        }
    };

    if (unhashedPassword != UserCredentials.password) {
        return error("Invalid credentials");
    }

    string token = check jwt:issue(issuerConfig);
    return new AccessToken(token, user.first_name).toJson();
};

public isolated function getAll() returns json|error? {
    stream<UserRecord, error?> userStream = userDBClient->query(`select * from app_user;`, UserRecord);

    string rawData = "";
    check from UserRecord user in userStream
        do {
            VehicleOutput userOutput = check getVehiclesByUserId(user.user_id);
            ParkingHistoryOutput parkingHistoryOutput = check getParkingHistoryByUserId(user.user_id);
            int parkies = check userDBClient->queryRow(`select parkies from parky_wallet where id = ${user.user_id};`);
            UserDTO userDto = new UserDTO(user.user_id, user.first_name, user.last_name, user.email, user.nif, parkingHistoryOutput.parkingHistory, parkies, userOutput.vehicles, mapIntToRole(user.role), mapIntToPaymentMethod(user.payment_method), mapIntToUserStatus(user.status));
            rawData = rawData + userDto.toJsonWithArrays(userOutput.vehiclesJson, parkingHistoryOutput.parkingHistoryJson).toString() + ",";
        };
    check userStream.close();

    if (rawData == "") {
        rawData = "[]";
    } else {
        rawData = rawData.substring(0, rawData.length() - 1);
        rawData = "[" + rawData + "]";
    }

    json usersJson = check rawData.fromJsonString();
    return usersJson;
};

public isolated function addVehicle(int userId, VehicleOnCreation vehicleOnCreation) returns json|error? {
    Vehicle vehicle = new Vehicle(vehicleOnCreation.licensePlateNumber, vehicleOnCreation.vehicleType, vehicleOnCreation.vehicleEnergySource);

    stream<UserVehicleRecord, error?> vehicleStream = userDBClient->query(`select * from app_user_vehicles where user_user_id = ${userId};`, UserVehicleRecord);
    int vehicleCount = 0;
    check from UserVehicleRecord _ in vehicleStream
        do {
            vehicleCount = vehicleCount + 1;
        };

    if (vehicleCount >= 3) {
        return error("User already has 3 vehicles");
    }

    sql:ExecutionResult _ = check userDBClient->execute(`insert into vehicle (license_plate_number, vehicle_energy_source, vehicle_type) values (${vehicle.licensePlate}, ${mapStringToInt(vehicle.vehicleEnergySource)}, ${mapStringToInt(vehicle.vehicleType)});`);
    sql:ExecutionResult _ = check userDBClient->execute(`insert into app_user_vehicles (user_user_id, vehicles_license_plate_number) values (${userId}, ${vehicle.licensePlate});`);

    return vehicle.toJson();
};

public isolated function changePaymentMethod(int userId, PaymentRequestRecord paymentRequestRecord) returns json|error? {
    if (paymentRequestRecord.paymentMethod == NOT_DEFINED) {
        return error("Can't change payment method back to undefined");
    }

    sql:ExecutionResult _ = check userDBClient->execute(`update app_user set payment_method = ${mapStringToInt(paymentRequestRecord.paymentMethod)} where user_id = ${userId};`);
    return new PaymentDTO(paymentRequestRecord.paymentMethod).toJson();
};

public isolated function getAllUserVehicles(int userId) returns json|error? {
    stream<VehicleRecord, error?> vehicleStream = userDBClient->query(`select v.* from app_user_vehicles as auv join vehicle as v on auv.vehicles_license_plate_number = v.license_plate_number where auv.user_user_id = ${userId};`, VehicleRecord);

    string rawData = "";
    check from VehicleRecord vehicle in vehicleStream
        do {
            Vehicle vehicleDto = new Vehicle(vehicle.license_plate_number, mapIntToVehicleType(vehicle.vehicle_type), mapIntToVehicleEnergySource(vehicle.vehicle_energy_source));
            rawData = rawData + vehicleDto.toJson().toString() + ",";
        };
    check vehicleStream.close();

    rawData = rawData.substring(0, rawData.length() - 1);
    rawData = "[" + rawData + "]";

    json vehiclesJson = check rawData.fromJsonString();
    return vehiclesJson;
};

public isolated function getUserPaymentMethod(int userId) returns json|error? {
    UserRecord queryResult = check userDBClient->queryRow(`select * from app_user where user_id = ${userId};`);
    UserRecord user = check queryResult.cloneWithType(UserRecord);

    return new PaymentDTO(mapIntToPaymentMethod(user.payment_method)).toJson();
};

public isolated function addParkiesToUsers(ParkyTransactionRequest parkyTransactionRequest, int managerId) returns boolean|error? {
    stream<UserRecord, error?> userStream = userDBClient->query(`select * from app_user;`, UserRecord);

    if (parkyTransactionRequest.amount <= 0) {
        return error("Invalid users provided!");
    }

    check from UserRecord user in userStream
        do {
            if (isContain(parkyTransactionRequest.userIds, user.user_id)) {
                ParkyTransactionEvent event = new ParkyTransactionEvent(0, parkyTransactionRequest.amount, parkyTransactionRequest.reason, managerId, "now");
                int rows = check userDBClient->queryRow(`select count(*) from parky_transaction_event;`);
                sql:ExecutionResult _ = check userDBClient->execute(`insert into parky_transaction_event (event_id, amount, reason, manager_id, transaction_time) values (${rows + 1}, ${event.amount}, ${event.reason}, ${event.managerId}, now());`);
                sql:ExecutionResult _ = check userDBClient->execute(`update parky_wallet set parkies = parkies + ${event.amount} where id = ${user.user_id};`);
                sql:ExecutionResult _ = check userDBClient->execute(`insert into parky_wallet_parky_events (parky_wallet_id, parky_events_event_id) values (${user.parkies_id}, ${rows + 1});`);
            }
        };
    check userStream.close();

    return true;
};

public isolated function getParkyWalletOfUser(int userId) returns json|error? {
    int parkies = check userDBClient->queryRow(`select parkies from parky_wallet where id = ${userId};`);
    ParkyTransitionEventOutput parkyEventsOutput = check getParkyTransitionEventsByUserId(userId);
    ParkyWalletDTO parkyWalletDTO = new ParkyWalletDTO(userId, parkies, parkyEventsOutput.parkyEvents);

    return parkyWalletDTO.toJsonWithParkyEventJson(parkyEventsOutput.parkyEventsJson);
};
