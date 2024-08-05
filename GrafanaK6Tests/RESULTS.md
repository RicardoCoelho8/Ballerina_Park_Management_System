# Performance Test Results

## Introduction

This report presents the results of the performance test conducted on the API Gateways and User Microservices
implemented in **Ballerina** and **Java**.
The focus is on comparing the performance across two different protocol versions: **HTTP 1.1** and **HTTP 2**, for each
technology. At the end, by analyzing the results to determine if Ballerina can be a good candidate for distributed systems

Some concepts were considered in the test, such as the use of **Ahead-of-Time (AOT) compilation** and **Just-in-Time (
JIT) compilation** when using **GraalVM** to compile the code.

- **JIT Compilation** optimizes code at runtime, dynamically adapting to runtime conditions (default compilation).
- **AOT Compilation** pre compiles code into native machine code before execution, providing faster startup and reduced
  runtime overhead.

## Methodology

The tests utilized **Grafana K6** to simulate a high load of requests on the API Gateway and User Microservice

### Test Configuration

There is 2 tests one for the load test and another for the stress test, the load tests were executed with 2 different configurations, with 10 and 100 VUs, and the stress test was configured to increase the number of threads over time and the test stops when the first timeout error is reached.

- **Configuration 1:**
    - **Number of VUs (users):** 10

- **Configuration 2:**
    - **Number of VUs (users):** 100

#### Endpoints Tested:

| Technology              | Protocol | Endpoint                                   |
|-------------------------|----------|--------------------------------------------|
| Ballerina GraalVM (AOT) | HTTP 1.1 | `https://localhost:9090/users/getAllUsers` |
| Ballerina GraalVM (AOT) | HTTP 2   | `https://localhost:9090/users/getAllUsers` |
| Ballerina               | HTTP 1.1 | `https://localhost:9090/users/getAllUsers` |
| Ballerina               | HTTP 2   | `https://localhost:9090/users/getAllUsers` |
| Java (AOT)              | HTTP 1.1 | `https://localhost:8080/users/getAllUsers` |
| Java (AOT)              | HTTP 2   | `https://localhost:8080/users/getAllUsers` |
| Java                    | HTTP 1.1 | `https://localhost:8080/users/getAllUsers` |
| Java                    | HTTP 2   | `https://localhost:8080/users/getAllUsers` |

## Results

Bellow are the results obtained from the tests:

### Report Summary

#### 1 - API Gateway - Ballerina (AOT)

| User MCS Technology | Protocol | Configuration | Average (ms) | Max (ms) | Median (ms) | Min (ms) | 90% Line (ms) | 95% Line (ms) | Error (%) | Throughput (s) |
|:-------------------:|:--------:|:-------------:|-------------:|---------:|------------:|---------:|--------------:|--------------:|----------:|---------------:|
|   Ballerina (AOT)   | HTTP 1.1 |       1       |         7.53 |    17.39 |        5.54 |     2.60 |         14.21 |         15.68 |     0.000 |           9.86 |
|   Ballerina (AOT)   |  HTTP 2  |       1       |         7.06 |    15.10 |        6.36 |     2.62 |         10.95 |         12.82 |     0.000 |           9.91 |
|      Ballerina      | HTTP 1.1 |       1       |         9.63 |    21.91 |       10.43 |     3.11 |         13.76 |         18.35 |     0.000 |           9.84 |
|      Ballerina      |  HTTP 2  |       1       |         8.57 |    20.86 |        7.21 |     3.20 |         15.35 |         16.99 |     0.000 |           9.89 |
|     Java (AOT)      | HTTP 1.1 |       1       |        17.74 |    32.16 |       16.89 |    11.67 |         22.55 |         26.74 |     0.000 |           9.71 |
|     Java (AOT)      |  HTTP 2  |       1       |        16.83 |    26.58 |       16.23 |    11.12 |         21.98 |         22.65 |     0.000 |           9.80 |
|        Java         | HTTP 1.1 |       1       |        19.47 |    48.72 |       16.23 |    12.38 |         25.93 |         36.37 |     0.000 |           9.72 |
|        Java         |  HTTP 2  |       1       |        17.57 |    31.95 |       16.01 |    10.18 |         24.47 |         27.14 |     0.000 |           9.77 |
| ------------------- | -------- | ------------- | ------------ | -------- | ----------- | -------- | ------------- | ------------- | --------- | -------------- |
|   Ballerina (AOT)   | HTTP 1.1 |       2       |        11.98 |    47.84 |        9.62 |     2.61 |         23.21 |         26.79 |     0.000 |          98.82 |
|   Ballerina (AOT)   |  HTTP 2  |       2       |        11.28 |    45.66 |        9.31 |     2.06 |         21.58 |         23.58 |     0.000 |          98.90 |
|      Ballerina      | HTTP 1.1 |       2       |        13.30 |    39.55 |       12.06 |     3.10 |         22.92 |         28.24 |     0.000 |          98.28 |
|      Ballerina      |  HTTP 2  |       2       |        12.43 |    37.59 |       11.19 |     3.09 |         22.12 |         24.94 |     0.000 |          98.29 |
|     Java (AOT)      | HTTP 1.1 |       2       |        37.31 |   397.75 |       29.11 |    10.36 |         54.83 |         70.40 |     0.000 |          95.23 |
|     Java (AOT)      |  HTTP 2  |       2       |        36.19 |   384.36 |       26.78 |    10.35 |         50.90 |         65.62 |     0.000 |          96.74 |
|        Java         | HTTP 1.1 |       2       |        22.29 |   156.76 |       16.38 |    10.57 |         33.00 |         37.66 |     0.000 |          96.87 |
|        Java         |  HTTP 2  |       2       |        20.25 |   138.57 |       16.08 |     9.69 |         28.26 |         36.05 |     0.000 |          97.20 |

#### 2 - API Gateway - Ballerina

| User MCS Technology | Protocol | Configuration | Average (ms) | Max (ms) | Median (ms) | Min (ms) | 90% Line (ms) | 95% Line (ms) | Error (%) | Throughput (s) |
|:-------------------:|:--------:|:-------------:|-------------:|---------:|------------:|---------:|--------------:|--------------:|----------:|---------------:|
|   Ballerina (AOT)   | HTTP 1.1 |       1       |         9.02 |    14.63 |        8.76 |     4.16 |         12.81 |         13.44 |     0.000 |           9.85 |
|   Ballerina (AOT)   |  HTTP 2  |       1       |         8.56 |    13.82 |        7.84 |     4.98 |         12.61 |         13.31 |     0.000 |           9.87 |
|      Ballerina      | HTTP 1.1 |       1       |        10.38 |    16.55 |       10.07 |     6.87 |         14.49 |         15.17 |     0.000 |           9.80 |
|      Ballerina      |  HTTP 2  |       1       |         9.46 |    16.13 |        9.04 |     6.42 |         11.84 |         12.81 |     0.000 |           9.83 |
|     Java (AOT)      | HTTP 1.1 |       1       |        19.61 |    31.69 |       18.04 |    13.51 |         28.09 |         29.46 |     0.000 |           9.72 |
|     Java (AOT)      |  HTTP 2  |       1       |        17.27 |    48.73 |       15.97 |    13.19 |         19.07 |         20.27 |     0.000 |           9.78 |
|        Java         | HTTP 1.1 |       1       |        20.75 |    54.13 |       16.22 |    12.07 |         42.22 |         46.43 |     0.000 |           9.68 |
|        Java         |  HTTP 2  |       1       |        19.48 |    51.53 |       15.08 |    11.29 |         43.90 |         46.77 |     0.000 |           9.75 |
| ------------------- | -------- | ------------- | ------------ | -------- | ----------- | -------- | ------------- | ------------- | --------- | -------------- |
|   Ballerina (AOT)   | HTTP 1.1 |       2       |        13.37 |    35.39 |       12.17 |     3.09 |         22.92 |         26.94 |     0.000 |          98.80 |
|   Ballerina (AOT)   |  HTTP 2  |       2       |        12.76 |    40.43 |       11.85 |     3.12 |         22.00 |         25.55 |     0.000 |          98.85 |
|      Ballerina      | HTTP 1.1 |       2       |        14.88 |    38.60 |       14.12 |     4.49 |         23.03 |         24.98 |     0.000 |          98.04 |
|      Ballerina      |  HTTP 2  |       2       |        13.68 |    39.79 |       12.98 |     2.80 |         21.38 |         25.37 |     0.000 |          98.16 |
|     Java (AOT)      | HTTP 1.1 |       2       |        39.56 |   385.78 |       30.73 |    10.49 |         52.88 |         70.14 |     0.000 |          93.83 |
|     Java (AOT)      |  HTTP 2  |       2       |        38.68 |   400.90 |       27.12 |    10.72 |         58.74 |         68.67 |     0.000 |          96.06 |
|     Java (AOT)      |  HTTP 2  |       2       |        26.66 |   185.45 |       21.04 |    12.17 |         38.71 |         49.65 |     0.000 |          96.64 |
|        Java         |  HTTP 2  |       2       |        24.84 |   132.41 |       23.09 |     9.85 |         35.35 |         38.61 |     0.000 |          96.71 |

#### 3 - API Gateway - Java (AOT)

| User MCS Technology | Protocol | Configuration | Average (ms) | Max (ms) | Median (ms) | Min (ms) | 90% Line (ms) | 95% Line (ms) | Error (%) | Throughput (s) |
|:-------------------:|:--------:|:-------------:|-------------:|---------:|------------:|---------:|--------------:|--------------:|----------:|---------------:|
|   Ballerina (AOT)   | HTTP 1.1 |       1       |         9.14 |    15.10 |        8.16 |     2.59 |         14.55 |         14.62 |     0.000 |           9.85 |
|   Ballerina (AOT)   |  HTTP 2  |       1       |         8.40 |    22.65 |        8.70 |     2.06 |         12.85 |         14.25 |     0.000 |           9.87 |
|      Ballerina      | HTTP 1.1 |       1       |        10.09 |    17.24 |        9.69 |     3.14 |         14.27 |         15.93 |     0.000 |           9.80 |
|      Ballerina      |  HTTP 2  |       1       |         9.25 |    18.44 |        9.00 |     3.64 |         13.35 |         16.04 |     0.000 |           9.82 |
|     Java (AOT)      | HTTP 1.1 |       1       |        18.65 |    46.18 |       18.61 |    13.66 |         21.25 |         22.83 |     0.000 |           9.70 |
|     Java (AOT)      |  HTTP 2  |       1       |        17.98 |    53.96 |       14.11 |    11.43 |         29.05 |         35.07 |     0.000 |           9.74 |
|        Java         | HTTP 1.1 |       1       |        20.50 |    43.37 |       19.09 |    11.01 |         28.70 |         42.79 |     0.000 |           9.68 |
|        Java         |  HTTP 2  |       1       |        18.63 |    41.83 |       16.50 |     9.85 |         28.77 |         31.98 |     0.000 |           9.73 |
| ------------------- | -------- | ------------- | ------------ | -------- | ----------- | -------- | ------------- | ------------- | --------- | -------------- |
|   Ballerina (AOT)   | HTTP 1.1 |       2       |        12.41 |    42.98 |       10.35 |     1.55 |         24.44 |         28.02 |     0.000 |          62.33 |
|   Ballerina (AOT)   |  HTTP 2  |       2       |        11.57 |    48.12 |        8.02 |     2.11 |         24.74 |         31.00 |     0.000 |          70.91 |
|      Ballerina      | HTTP 1.1 |       2       |        13.70 |    79.02 |       11.66 |     3.11 |         20.65 |         27.14 |     0.000 |          70.31 |
|      Ballerina      |  HTTP 2  |       2       |        12.58 |    35.00 |       10.72 |     2.60 |         23.32 |         28.69 |     0.000 |          74.13 |
|     Java (AOT)      | HTTP 1.1 |       2       |        39.53 |   348.10 |       32.56 |     9.27 |         63.31 |         77.18 |     0.000 |          94.36 |
|     Java (AOT)      |  HTTP 2  |       2       |        37.04 |   369.60 |       27.97 |     9.89 |         57.52 |         74.26 |     0.000 |          94.82 |
|        Java         | HTTP 1.1 |       2       |        26.26 |   147.60 |       22.48 |    10.91 |         35.26 |         43.81 |     0.000 |          96.75 |
|        Java         |  HTTP 2  |       2       |        23.56 |    93.51 |       22.21 |    10.81 |         33.37 |         41.41 |     0.000 |          97.03 |

#### 4 - API Gateway - Java

| User MCS Technology | Protocol | Configuration | Average (ms) | Max (ms) | Median (ms) | Min (ms) | 90% Line (ms) | 95% Line (ms) | Error (%) | Throughput (s) |
|:-------------------:|:--------:|:-------------:|-------------:|---------:|------------:|---------:|--------------:|--------------:|----------:|---------------:|
|   Ballerina (AOT)   | HTTP 1.1 |       1       |         9.86 |    33.56 |        9.34 |     4.76 |         14.37 |         23.27 |     0.000 |           9.82 |
|   Ballerina (AOT)   |  HTTP 2  |       1       |         9.00 |    18.69 |        8.77 |     4.49 |         13.29 |         14.79 |     0.000 |           9.86 |
|      Ballerina      | HTTP 1.1 |       1       |        11.16 |    20.18 |       11.10 |     4.35 |         17.49 |         18.64 |     0.000 |           9.78 |
|      Ballerina      |  HTTP 2  |       1       |        10.21 |    25.00 |        8.85 |     4.16 |         16.78 |         20.52 |     0.000 |           9.79 |
|     Java (AOT)      | HTTP 1.1 |       1       |        20.57 |    55.49 |       16.36 |    11.81 |         31.84 |         44.82 |     0.000 |           9.67 |
|     Java (AOT)      |  HTTP 2  |       1       |        19.56 |    52.26 |       16.64 |    11.51 |         29.04 |         35.59 |     0.000 |           9.72 |
|        Java         | HTTP 1.1 |       1       |        21.84 |    35.83 |       21.22 |    12.67 |         28.13 |         34.02 |     0.000 |           9.67 |
|        Java         |  HTTP 2  |       1       |        20.38 |    38.75 |       20.39 |    12.40 |         25.49 |         29.35 |     0.000 |           9.70 |
| ------------------- | -------- | ------------- | ------------ | -------- | ----------- | -------- | ------------- | ------------- | --------- | -------------- |
|   Ballerina (AOT)   | HTTP 1.1 |       2       |        14.03 |    54.50 |       11.75 |     2.97 |         24.15 |         39.11 |     0.000 |          59.66 |
|   Ballerina (AOT)   |  HTTP 2  |       2       |        13.30 |    53.44 |       12.67 |     2.58 |         20.98 |         23.57 |     0.000 |          67.62 |
|      Ballerina      | HTTP 1.1 |       2       |        15.59 |    66.02 |       13.51 |     3.10 |         23.45 |         34.11 |     0.000 |          56.23 |
|      Ballerina      |  HTTP 2  |       2       |        15.40 |    57.68 |       14.07 |     4.37 |         20.35 |         29.92 |     0.000 |          64.29 |
|     Java (AOT)      | HTTP 1.1 |       2       |        40.76 |   471.07 |       31.33 |     9.86 |         63.16 |         92.52 |     0.000 |          93.76 |
|     Java (AOT)      |  HTTP 2  |       2       |        40.64 |   342.63 |       33.59 |     8.27 |         64.89 |         71.64 |     0.000 |          94.19 |
|        Java         | HTTP 1.1 |       2       |        27.71 |   140.91 |       23.24 |    11.88 |         42.36 |         54.81 |     0.000 |          96.62 |
|        Java         |  HTTP 2  |       2       |        26.92 |   128.82 |       24.18 |    12.26 |         35.56 |         39.71 |     0.000 |          96.71 |

### System Stress Test requests

For this test, a stepping thread group was used, in order to increase the number of threads overtime, starting with 1 till the first timeout error is reached.

| Technology      | Protocol | Max Number of VUs |
|-----------------|----------|------------------:|
| Ballerina (AOT) | HTTP 1.1 |             9.579 |
| Ballerina (AOT) | HTTP 2   |            11.373 |
| Ballerina       | HTTP 1.1 |             8.381 |
| Ballerina       | HTTP 2   |             9.172 |
| Java (AOT)      | HTTP 1.1 |             7.644 |
| Java (AOT)      | HTTP 2   |             8.984 |
| Java            | HTTP 1.1 |             6.356 |
| Java            | HTTP 2   |             7.757 |

### Startup times:

Each technology was tested 10 times and bellow are the average startup times for each service.

#### API Gateway

| Technology      | Average Startup Time (ms) |
|-----------------|---------------------------|
| Ballerina (AOT) | ~0.066                    |
| Ballerina       | ~0.635                    |
| Java (AOT)      | ~0.088                    |
| Java            | ~1.408                    |

#### User Microservice

| Technology      | Average Startup Time |
|-----------------|----------------------|
| Ballerina (AOT) | ~0.081 s             |
| Ballerina       | ~0.818 s             |
| Java (AOT)      | ~0.228 s             |
| Java            | ~3.015 s             |


# Results Analysis

## General Performance

This analysis compares the response times of Ballerina's performance compared to Java.

By analysing the load test tables it can be seen that Ballerina in general as better performance than Java, when focusing on the first configuration with 10 users simultaneously, Ballerina has a better performance in all cases in response times and throughput. 
In the second configuration with 100 users simultaneously, Ballerina still has a better performance in terms of response times, although the throughput is lower than Java when the API Gateway is implemented in Java. 
Leading to the conclusion that Ballerina has a better performance than Java when communicating with other services implemented in different technologies for scenarios with high load.

## Stress Test

From the system stress test, the conclusion is that Ballerina with its AOT compilation and HTTP/2 protocol has the best performance in scenarios of high load. It can handle more ~24% of users at the same time as Java with the same configuration.
Proving that Ballerina can be a good candidate for distributed systems, as it can handle several users at the same time in scenarios of high load, like black friday sales and other high traffic events.

## HTTP/1.1 vs HTTP/2.0

As for the both HTTP protocols, as expected, HTTP/2.0 has a better performance than HTTP/1.1 in all the cases, that behaviour was expected as it has features that allow the server to handle more requests at the same time, leading to a better performance in all the cases.

## Startup times

With the AOT compilation, Ballerina demonstrates a mean time of ~66ms to launch the API Gateway application, decreasing its startup time by ~89.6%.

## Conclusion

The performance tests indicate that Ballerina is a strong candidate for distributed systems, particularly when using AOT compilation with HTTP/2. The results suggest the following:
 - Efficiency: Ballerina provides faster response times and can handle more concurrent users compared to Java, making it a robust choice for high-load scenarios.
 - Scalability: The superior performance of Ballerina in stress tests indicates its ability to scale effectively without significant degradation in performance.
 - Protocol Utilization: Ballerina utilizes HTTP/2 advantages, further enhancing its performance edge over Java.
 - Compilation: AOT compilation significantly reduces Ballerina's startup time, making it a more efficient choice for applications requiring frequent restarts. Besides, it also improves the performance of the application.

Given these points, Ballerina proves to be a compelling option for building high-performance and scalable distributed applications.