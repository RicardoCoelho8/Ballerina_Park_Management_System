import ballerina/http;
import ballerina/jwt;
import ballerina/log;

string secretKey = "jhewiwrvmqere3"; // The key used for HMAC256 algorithm
string userId = "";
string role = "";

string mcsUsers = "users";
string mcsParks = "parks";
string mcsPayments = "payments";

listener http:Listener apiListener = new(9090, {
    httpVersion: "2.0"
});

map<http:Method> unauthenticatedRoutes = {
    "/users/createUser": http:HTTP_POST,
    "/users/login": http:HTTP_POST,
    "/barriers/entrance": http:HTTP_POST,
    "/barriers/exit": http:HTTP_POST,
    "/display/update": http:HTTP_POST,
    "/display/get": http:HTTP_POST,
    "/payments/createPayment": http:HTTP_POST,
    "/payments/getAllPayments": http:HTTP_GET
};

function isUnauthenticatedRoute(string path, string method) returns boolean {
    if unauthenticatedRoutes.hasKey(path) {
        return true;
    }
    return false;
}

function getJwtValidatorConfig() returns jwt:ValidatorConfig {
    jwt:ValidatorConfig validatorConfig = {
        signatureConfig: {
            secret: secretKey
        }
    };
    return validatorConfig;
}

function validateJWT(http:Request req, string path) returns boolean {
    // Check if path requires authentication
    if isUnauthenticatedRoute(path, req.method) {
        log:printInfo("No authentication required for path: " + path);
        return true;
    }

    // Extract the Authorization header
    var authHeaderResult = req.getHeader("Authorization");
    if authHeaderResult is string {
        if authHeaderResult.startsWith("Bearer ") {
            string token = authHeaderResult.substring("Bearer ".length());
            jwt:ValidatorConfig validatorConfig = getJwtValidatorConfig();

            // Validate the JWT
            jwt:Payload|error validationResult = jwt:validate(token, validatorConfig);

            if validationResult is jwt:Payload {
                log:printInfo("JWT validation succeeded");

                // Extract userId and role from JWT payload and setting them as headers
                userId = validationResult["sub"].toString();
                role = validationResult["role"].toString();

                return true; // Validation successful
            } else {
                log:printError("JWT validation failed", 'error = validationResult);
            }
        } else {
            log:printError("Authorization header does not contain Bearer token");
        }
    } else {
        log:printError("Authorization header not found");
    }
    return false; // Default to validation failed
}

function sendForbiddenResponse(http:Caller caller) returns http:ListenerError? {
    http:Response res = new;
    res.statusCode = 403;
    res.setPayload("Forbidden");
    return caller->respond(res);
}

service / on apiListener {

    function init() {
        // Initialization logic
        log:printInfo("Service is ready to handle requests.");
    }

    // User routes ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    resource function post users/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/users/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to user microservice
        http:Client userServiceClient = check new("http://"+ mcsUsers + ":8090");
        anydata response = check userServiceClient->post(fullPath, req);
        return caller->respond(response);
    }

    resource function put users/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/users/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to user microservice
        http:Client userServiceClient = check new("http://"+ mcsUsers + ":8090");
        anydata response = check userServiceClient->put(fullPath, req);
        return caller->respond(response);
    }

    resource function get users/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/users/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Headers to be forwarded to user microservice
        map<string|string[]> headers = {
            "X-UserId": [userId],
            "X-UserRole": [role]
        };

        // Forward request to user microservice
        http:Client userServiceClient = check new("http://"+ mcsUsers + ":8090");
        anydata response = check userServiceClient->get(fullPath, headers);
        return caller->respond(response);
    }

        resource function get userReport/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/userReport/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Headers to be forwarded to user microservice
        map<string|string[]> headers = {
            "X-UserId": [userId],
            "X-UserRole": [role]
        };

        // Forward request to user microservice
        http:Client userServiceClient = check new("http://"+ mcsUsers + ":8090");
        anydata response = check userServiceClient->get(fullPath, headers);
        return caller->respond(response);
    }

    // Park routes ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    resource function put parks/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/parks/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to park microservice
        http:Client parkServiceClient = check new("http://"+ mcsParks + ":8094");
        anydata response = check parkServiceClient->put(fullPath, req);
        return caller->respond(response);
    }

    resource function get parks/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/parks/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to park microservice
        http:Client parkServiceClient = check new("http://"+ mcsParks + ":8094");
        anydata response = check parkServiceClient->get(fullPath);
        return caller->respond(response);
    }

    resource function get parkReport/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/parkReport/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Headers to be forwarded to park microservice
        map<string|string[]> headers = {
            "X-UserId": [userId],
            "X-UserRole": [role]
        };

        // Forward request to park microservice
        http:Client parkServiceClient = check new("http://"+ mcsParks + ":8094");
        anydata response = check parkServiceClient->get(fullPath, headers);
        return caller->respond(response);
    }

    // Barrier and Display routes ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    resource function post barriers/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/barriers/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to park microservice
        http:Client parkServiceClient = check new("http://"+ mcsParks + ":8094");
        anydata response = check parkServiceClient->post(fullPath, req);
        return caller->respond(response);
    }

    resource function post display/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/display/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to park microservice
        http:Client parkServiceClient = check new("http://"+ mcsParks + ":8094");
        anydata response = check parkServiceClient->post(fullPath, req);
        return caller->respond(response);
    }

    // Payment routes ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    resource function post payments/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/payments/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to payments microservice
        http:Client paymentsServiceClient = check new("http://"+ mcsPayments +":8086");
        anydata response = check paymentsServiceClient->post(fullPath, req);
        return caller->respond(response);
    }

    resource function get payments/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/payments/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Headers to be forwarded to payments microservice
        map<string|string[]> headers = {
            "X-UserId": [userId],
            "X-UserRole": [role]
        };

        // Forward request to payments microservice
        http:Client paymentsServiceClient = check new("http://"+ mcsPayments +":8086");
        anydata response = check paymentsServiceClient->get(fullPath, headers);
        return caller->respond(response);
    }

}