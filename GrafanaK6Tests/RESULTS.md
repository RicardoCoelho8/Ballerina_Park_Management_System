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
| Ballerina GraalVM (AOT) | HTTP 1.1 | `http://localhost:9090/users/getAllUsers`  |
| Ballerina GraalVM (AOT) | HTTP 2   | `https://localhost:9090/users/getAllUsers` |
| Ballerina               | HTTP 1.1 | `http://localhost:9090/users/getAllUsers`  |
| Ballerina               | HTTP 2   | `https://localhost:9090/users/getAllUsers` |
| Java (AOT)              | HTTP 1.1 | `http://localhost:8080/users/getAllUsers`  |
| Java (AOT)              | HTTP 2   | `https://localhost:8080/users/getAllUsers` |
| Java                    | HTTP 1.1 | `http://localhost:8080/users/getAllUsers`  |
| Java                    | HTTP 2   | `https://localhost:8080/users/getAllUsers` |

## Results

Bellow are the results obtained from the tests:

### Report Summary

#### 1 - API Gateway - Ballerina (AOT)

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Max    | Median | Min   | 90% Line | 95% Line    | Error (%) |
|---------------------|------------|-----------------|-----------|-----------|--------|--------|-------|----------|-------------|-----------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 300       | 23.01     | 33.85  | 24.71  | 11.55 | 28.99    | 29.37       | 0.000     |
| Ballerina (AOT)     | HTTP 2     | 1               | 300       | 20.45     | 59.39  | 17.17  | 11.76 | 31.77    | 33.74       | 0.000     |
| Ballerina           | HTTP 1.1   | 1               | 300       | 23.05     | 36.40  | 23.86  | 11.47 | 28.55    | 31.37       | 0.000     |
| Ballerina           | HTTP 2     | 1               | 300       | 18.42     | 33.85  | 17.80  | 10.32 | 23.96    | 27.25       | 0.000     |
| Java (AOT)          | HTTP 1.1   | 1               | 293       | 28.34     | 71.74  | 23.08  | 11.43 | 47.74    | 61.26       | 0.000     |
| Java (AOT)          | HTTP 2     | 1               | 294       | 26.60     | 45.71  | 24.75  | 11.46 | 40.92    | 42.44       | 0.000     |
| Java                | HTTP 1.1   | 1               | 300       | 19.92     | 46.79  | 20.09  | 11.44 | 24.38    | 25.05       | 0.000     |
| Java                | HTTP 2     | 1               | 300       | 22.99     | 47.19  | 22.42  | 12.47 | 34.86    | 39.51       | 0.000     |
| -------------       | ---------- | --------------- | --------- | --------- | ------ | ------ | ----- | -------- | ----------- | --------- |
| Ballerina (AOT)     | HTTP 1.1   | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina (AOT)     | HTTP 2     | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina           | HTTP 1.1   | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina           | HTTP 2     | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Java (AOT)          | HTTP 1.1   | 2               | 2903      | 39.07     | 371.20 | 30.40  | 10.38 | 62.38    | 72.93       | 0.000     |
| Java (AOT)          | HTTP 2     | 2               | 2936      | 31.43     | 339.19 | 24.93  | 10.30 | 42.48    | 51.49       | 0.000     |
| Java                | HTTP 1.1   | 2               | 3000      | 21.52     | 115.85 | 20.51  | 11.04 | 29.81    | 33.89       | 0.000     |
| Java                | HTTP 2     | 2               | 3000      | 22.48     | 110.54 | 21.15  | 9.90  | 31.25    | 40.98       | 0.000     |

#### 2 - API Gateway - Ballerina

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Max    | Median | Min   | 90% Line | 95% Line    | Error (%) |
|---------------------|------------|-----------------|-----------|-----------|--------|--------|-------|----------|-------------|-----------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 300       | 25.45     | 47.14  | 26.71  | 13.33 | 33.59    | 34.46       | 0.000     |
| Ballerina (AOT)     | HTTP 2     | 1               | 290       | 28.43     | 56.04  | 27.40  | 13.55 | 36.00    | 46.19       | 0.000     |
| Ballerina           | HTTP 1.1   | 1               | 300       | 21.63     | 32.78  | 21.99  | 11.97 | 27.56    | 30.38       | 0.000     |
| Ballerina           | HTTP 2     | 1               | 290       | 33.75     | 55.67  | 31.82  | 16.06 | 49.44    | 50.75       | 0.000     |
| Java (AOT)          | HTTP 1.1   | 1               | 290       | 31.29     | 63.15  | 29.01  | 12.38 | 50.55    | 57.53       | 0.000     |
| Java (AOT)          | HTTP 2     | 1               | 292       | 31.89     | 72.71  | 30.66  | 12.37 | 50.20    | 58.03       | 0.000     |
| Java                | HTTP 1.1   | 1               | 300       | 23.73     | 39.94  | 23.55  | 11.57 | 32.48    | 33.95       | 0.000     |
| Java                | HTTP 2     | 1               | 300       | 20.93     | 47.79  | 20.46  | 11.42 | 25.40    | 43.61       | 0.000     |
| -------------       | ---------- | --------------- | --------- | --------- | ------ | ------ | ----- | -------- | ----------- | --------- |
| Ballerina (AOT)     | HTTP 1.1   | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina (AOT)     | HTTP 2     | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina           | HTTP 1.1   | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina           | HTTP 2     | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Java (AOT)          | HTTP 1.1   | 2               | 2900      | 47.08     | 392.88 | 39.24  | 10.39 | 69.95    | 86.18       | 0.000     |
| Java (AOT)          | HTTP 2     | 2               | 2914      | 35.70     | 367.10 | 26.83  | 10.75 | 58.20    | 75.82       | 0.000     |
| Java                | HTTP 1.1   | 2               | 3000      | 27.61     | 146.80 | 23.64  | 11.45 | 39.53    | 44.92       | 0.000     |
| Java                | HTTP 2     | 2               | 3000      | 25.15     | 130.40 | 22.96  | 10.94 | 35.62    | 40.22       | 0.000     |

#### 3 - API Gateway - Java (AOT)

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Max    | Median | Min   | 90% Line | 95% Line    | Error (%) |
|---------------------|------------|-----------------|-----------|-----------|--------|--------|-------|----------|-------------|-----------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 300       | 16.12     | 33.94  | 33.94  | 9.41  | 22.71    | 23.00       | 0.000     |
| Ballerina (AOT)     | HTTP 2     | 1               | 300       | 25.04     | 58.14  | 24.62  | 9.28  | 33.09    | 36.60       | 0.000     |
| Ballerina           | HTTP 1.1   | 1               | 300       | 22.48     | 45.13  | 21.82  | 9.36  | 29.03    | 43.13       | 0.000     |
| Ballerina           | HTTP 2     | 1               | 300       | 18.20     | 37.00  | 16.05  | 10.28 | 26.26    | 27.10       | 0.000     |
| Java (AOT)          | HTTP 1.1   | 1               | 300       | 20.97     | 54.50  | 17.82  | 9.34  | 34.02    | 38.04       | 0.000     |
| Java (AOT)          | HTTP 2     | 1               | 294       | 26.47     | 45.97  | 26.32  | 10.30 | 41.95    | 42.94       | 0.000     |
| Java                | HTTP 1.1   | 1               | 300       | 21.23     | 43.75  | 18.95  | 9.33  | 35.05    | 40.06       | 0.000     |
| Java                | HTTP 2     | 1               | 300       | 22.47     | 46.52  | 19.95  | 12.72 | 35.55    | 42.31       | 0.000     |
| -------------       | ---------- | --------------- | --------- | --------- | ------ | ------ | ----- | -------- | ----------- | --------- |
| Ballerina (AOT)     | HTTP 1.1   | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina (AOT)     | HTTP 2     | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina           | HTTP 1.1   | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina           | HTTP 2     | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Java (AOT)          | HTTP 1.1   | 2               | 2912      | 37.11     | 340.86 | 29.86  | 8.76  | 51.52    | 82.84       | 0.000     |
| Java (AOT)          | HTTP 2     | 2               | 2906      | 43.96     | 338.96 | 38.21  | 9.88  | 64.81    | 76.99       | 0.000     |
| Java                | HTTP 1.1   | 2               | 3000      | 25.67     | 107.25 | 21.36  | 9.56  | 43.85    | 50.48       | 0.000     |
| Java                | HTTP 2     | 2               | 3000      | 20.60     | 121.36 | 15.41  | 10.39 | 33.37    | 47.33       | 0.000     |

#### 4 - API Gateway - Java

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Max    | Median | Min   | 90% Line | 95% Line    | Error (%) |
|---------------------|------------|-----------------|-----------|-----------|--------|--------|-------|----------|-------------|-----------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 300       | 21.37     | 51.95  | 20.27  | 11.44 | 33.81    | 41.71       | 0.000     |
| Ballerina (AOT)     | HTTP 2     | 1               | 300       | 27.24     | 51.07  | 27.74  | 12.64 | 39.95    | 46.85       | 0.000     |
| Ballerina           | HTTP 1.1   | 1               | 290       | 29.81     | 52.02  | 29.66  | 10.45 | 37.92    | 46.89       | 0.000     |
| Ballerina           | HTTP 2     | 1               | 300       | 24.31     | 52.30  | 23.62  | 11.42 | 37.59    | 42.40       | 0.000     |
| Java (AOT)          | HTTP 1.1   | 1               | 291       | 37.45     | 68.54  | 36.84  | 11.49 | 58.11    | 65.37       | 0.000     |
| Java (AOT)          | HTTP 2     | 1               | 292       | 28.50     | 70.46  | 22.72  | 11.97 | 43.92    | 67.06       | 0.000     |
| Java                | HTTP 1.1   | 1               | 300       | 24.36     | 45.25  | 20.95  | 12.47 | 35.17    | 45.21       | 0.000     |
| Java                | HTTP 2     | 1               | 300       | 26.16     | 47.42  | 24.68  | 12.58 | 37.63    | 41.01       | 0.000     |
| -------------       | ---------- | --------------- | --------- | --------- | ------ | ------ | ----- | -------- | ----------- | --------- |
| Ballerina (AOT)     | HTTP 1.1   | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina (AOT)     | HTTP 2     | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina           | HTTP 1.1   | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Ballerina           | HTTP 2     | 2               | ERROR     | ERROR     | ERROR  | ERROR  | ERROR | ERROR    | ERROR       | ERROR     |
| Java (AOT)          | HTTP 1.1   | 2               | 2911      | 40.93     | 440.45 | 30.95  | 8.42  | 61.09    | 73.33       | 0.000     |
| Java (AOT)          | HTTP 2     | 2               | 2901      | 43.13     | 375.40 | 35.50  | 11.00 | 61.45    | 72.22       | 0.000     |
| Java                | HTTP 1.1   | 2               | 3000      | 23.14     | 118.04 | 21.60  | 10.94 | 33.80    | 37.07       | 0.000     |
| Java                | HTTP 2     | 2               | 2980      | 26.91     | 136.67 | 23.80  | 11.94 | 36.95    | 46.06       | 0.000     |

### System Stress Test requests

For this test, a stepping thread group was used, in order to increase the number of threads overtime, starting with 1 till the first timeout error is reached.

| Technology      | Protocol | Max Number of VUs |
|-----------------|----------|-------------------|
| Ballerina (AOT) | HTTP 1.1 | 14                |
| Ballerina (AOT) | HTTP 2   | 14                |
| Ballerina       | HTTP 1.1 | 14                |
| Ballerina       | HTTP 2   | 14                |
| Java (AOT)      | HTTP 1.1 | 7644              |
| Java (AOT)      | HTTP 2   | 4645              |
| Java            | HTTP 1.1 | 7941              |
| Java            | HTTP 2   | 4343              |

After several tests, it was noted that the user's ballerina application limits the use of a maximum of 14 users simultaneously regardless of the compilation and HTTP protocol. It is not known for sure why this happens, but it is believed that it is because of the way data is accessed within the database (SQL statements).
Therefore, the original user's application will be used to compare the values of the API gateways in the two languages and the two types of compilation.

| Technology      | Protocol | Number of threads simultaneous |
|-----------------|----------|--------------------------------|
| Ballerina (AOT) | HTTP 1.1 | 3142                           |
| Ballerina (AOT) | HTTP 2   | 2638                           |
| Ballerina       | HTTP 1.1 | 3241                           |
| Ballerina       | HTTP 2   | 3245                           |
| Java (AOT)      | HTTP 1.1 | 7644                           |
| Java (AOT)      | HTTP 2   | 4645                           |
| Java            | HTTP 1.1 | 7941                           |
| Java            | HTTP 2   | 4343                           |

# Results Analysis

## General Performance

This analysis compares the response times of Ballerina's performance compared to Java.
Analysing the tables, Ballerina performs similarly to Java, sometimes with better results, but very similar. Regardless of its compilation, Ballerina obtains competitive results under lower load conditions.

## Stress Test

Ballerina can't hold a high load configuration in both AOT or default compilation, which points to potential stability issues

## HTTP/1.1 vs HTTP/2.0

Analysing the results, in terms of load tests no pattern can be detected, sometimes the use of HTTP/2 brings advantages and sometimes not, even though there is no significant difference between the versions of the HTTP protocol. As far as stress tests are concerned, it can be seen that there is a limitation to HTTP/2 and its capacity drops by an average of 40%.

## Conclusion

Ballerina demonstrates competitive response times compared to Java under lower load conditions, making it a viable alternative for moderate traffic applications. However, it struggles with stability under high load, regardless of the compilation method used.
Comparing HTTP/1.1 and HTTP/2.0 protocols, no consistent performance pattern emerges in load tests, with neither protocol showing a significant advantage. However, under stress, HTTP/2 experiences a substantial 40% drop in capacity.
In summary, while Ballerina shows promise, it requires further optimization for high-load stability, and the choice between HTTP protocols remains context-dependent.