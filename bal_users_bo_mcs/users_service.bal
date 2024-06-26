import ballerina/http;
import ballerina/log;
import ballerina/lang.'int as langint;

listener http:Listener apiListener = new(9092, {
    httpVersion: "2.0"
});

isolated service /users on apiListener{

    function init() {
        // Initialization logic
        log:printInfo("User service is ready to handle requests.");
    }
    
    resource isolated function post createUser(http:Caller caller, http:Request request) returns error?{
        http:Response response = new;
        json payload = check request.getJsonPayload();
        UserOnCreation userOnCreation = check payload.cloneWithType(UserOnCreation);

        json|error? result = create(userOnCreation);

        if (result is error?) {
            response.statusCode = 404;
            response.setPayload("Bad Request");
            return caller->respond(response);
        }else {
            response.statusCode = 201;
            response.setJsonPayload(result);
            return caller->respond(response);
        }
    }

    resource isolated function post login(http:Caller caller, http:Request request) returns error?{
        http:Response response = new;
        json payload = check request.getJsonPayload();
        UserCredentials userOnLogin = check payload.cloneWithType(UserCredentials);

        json|error? result = login(userOnLogin);

        if (result is error? || result.token == null || result.token == "") {
            response.statusCode = 401;
            response.setPayload("Unauthorized");
            return caller->respond(response);
        }else {
            response.statusCode = 201;
            response.setJsonPayload(result);
            return caller->respond(response);
        }
    }

    resource isolated function get getAllUsers(http:Caller caller, http:Request request) returns error?{
        http:Response response = new;

        var headerRole = check request.getHeader("X-UserRole");
        if(!(headerRole == SUPERVISOR || headerRole == CUSTOMER_MANAGER)){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }

        json|error? result = getAll();

        if (result is error?) {
            response.statusCode = 409;
            response.setPayload("Conflict");
            return caller->respond(response);
        }else {
            response.statusCode = 200;
            response.setJsonPayload(result);
            return caller->respond(response);
        }
    }

    resource isolated function put vehicle/[int userId](http:Caller caller, http:Request request) returns error? {
        http:Response response = new;
        json payload = check request.getJsonPayload();
        VehicleOnCreation vehicleOnCreation = check payload.cloneWithType(VehicleOnCreation);

        var headerRole = check request.getHeader("X-UserRole");
        var headerUserId = check request.getHeader("X-UserId");

        if(headerUserId.toString() != userId.toString()){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }
            
        if(headerRole != CUSTOMER){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }

        json|error? result = addVehicle(userId, vehicleOnCreation);

        if (result is error?) {
            response.statusCode = 409;
            response.setPayload("Conflict");
            return caller->respond(response);
        }else {
            response.statusCode = 202;
            response.setJsonPayload(result);
            return caller->respond(response);
        }
    }

    resource isolated function put paymentMethod/[int userId](http:Caller caller, http:Request request) returns error? {
        http:Response response = new;
        json payload = check request.getJsonPayload();
        PaymentRequestRecord paymentRequest = check payload.cloneWithType(PaymentRequestRecord);

        var headerRole = check request.getHeader("X-UserRole");
        var headerUserId = check request.getHeader("X-UserId");

        if(headerUserId.toString() != userId.toString()){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }
            
        if(headerRole != CUSTOMER){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }

        json|error? result = changePaymentMethod(userId, paymentRequest);

        if (result is error?) {
            response.statusCode = 409;
            response.setPayload("Conflict");
            return caller->respond(response);
        }else {
            response.statusCode = 202;
            response.setJsonPayload(result);
            return caller->respond(response);
        }
    }

    resource isolated function get vehicles/[int userId](http:Caller caller, http:Request request) returns error? {
        http:Response response = new;

        var headerRole = check request.getHeader("X-UserRole");
        var headerUserId = check request.getHeader("X-UserId");

        if(headerUserId.toString() != userId.toString()){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }
            
        if(headerRole != CUSTOMER){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }

        json|error? result = getAllUserVehicles(userId);

        if (result is error?) {
            response.statusCode = 409;
            response.setPayload("Conflict");
            return caller->respond(response);
        }else {
            response.statusCode = 200;
            response.setJsonPayload(result);
            return caller->respond(response);
        }
    }

    resource isolated function get paymentMethod/[int userId](http:Caller caller, http:Request request) returns error? {
        http:Response response = new;

        var headerRole = check request.getHeader("X-UserRole");
        var headerUserId = check request.getHeader("X-UserId");

        if(headerUserId.toString() != userId.toString()){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }
            
        if(headerRole != CUSTOMER){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }

        json|error? result = getUserPaymentMethod(userId);

        if (result is error?) {
            response.statusCode = 409;
            response.setPayload("Conflict");
            return caller->respond(response);
        }else {
            response.statusCode = 200;
            response.setJsonPayload(result);
            return caller->respond(response);
        }
    }

    resource isolated function post parkies(http:Caller caller, http:Request request) returns error? {
        http:Response response = new;
        json payload = check request.getJsonPayload();
        ParkyTransactionRequest parkyTransactionRequest = check payload.cloneWithType(ParkyTransactionRequest);

        var headerRole = check request.getHeader("X-UserRole");
        var headerUserId = check request.getHeader("X-UserId");

        if(headerRole != CUSTOMER_MANAGER){
            response.statusCode = 403;
            response.setPayload("Forbidden");
            return caller->respond(response);
        }

        int managerId = check langint:fromString(headerUserId);
        boolean|error? result = addParkiesToUsers(parkyTransactionRequest, managerId);

        if (result is error?) {
            response.statusCode = 409;
            response.setPayload("Conflict");
            return caller->respond(response);
        }else {
            response.statusCode = 201;
            response.setJsonPayload(result);
            return caller->respond(response);
        }
    }

    resource isolated function get parkies/[int userId](http:Caller caller, http:Request request) returns error? {
        http:Response response = new;

        json|error? result = getParkyWalletOfUser(userId);

        if (result is error?) {
            response.statusCode = 409;
            response.setPayload("Conflict");
            return caller->respond(response);
        }else {
            response.statusCode = 200;
            response.setJsonPayload(result);
            return caller->respond(response);
        }
    }
}

