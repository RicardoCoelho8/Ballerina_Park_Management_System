import ballerina/http;
import ballerina/jwt;
import ballerina/log;

string secretKey = "jhewiwrvmqere3"; // The key used for HMAC256 algorithm

listener http:Listener apiListener = new(9090, {
    httpVersion: "2.0" // Enabling HTTP/2.0
});

map<http:Method> unauthenticatedRoutes = {
    "/users": http:HTTP_POST,
    "/users/login": http:HTTP_POST,
    "/barriers/entrance": http:HTTP_POST,
    "/barriers/exit": http:HTTP_POST,
    "/display/update": http:HTTP_POST,
    "/display/get": http:HTTP_POST,
    "/payments": http:HTTP_POST
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

    resource function post users/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/users/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to user microservice
    }

    resource function post parks/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/parks/" + string:'join("/", ...path);
        log:printInfo("FullPath: " + fullPath);
        log:printInfo("Path: " + fullPath);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to park microservice
        http:Client parkServiceClient = check new("http://localhost:8094");
        anydata response = check parkServiceClient->get(fullPath);
        return caller->respond(response);
    }

    resource function get users/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/users/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to user microservice
    }

    resource function get parks/[string... path](http:Caller caller, http:Request req) returns error? {
        string fullPath = "/parks/" + string:'join("/", ...path);
        if !validateJWT(req, fullPath) {
            return sendForbiddenResponse(caller);
        }

        // Forward request to park microservice
    }


    // Define other routes similarly, including JWT validation
}