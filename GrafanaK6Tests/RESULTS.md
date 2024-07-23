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
|---------------------|----------|---------------|--------------|----------|-------------|----------|---------------|---------------|-----------|----------------|
| Ballerina (AOT)     | HTTP 1.1 | 1             | 7.49         | 24.02    | 5.84        | 2.58     | 18.61         | 22.13         | 0.000     | 9.86           |
| Ballerina (AOT)     | HTTP 2   | 1             | 6.26         | 12.41    | 5.76        | 2.64     | 9.76          | 10.98         | 0.000     | 9.91           |
| Ballerina           | HTTP 1.1 | 1             | 9.32         | 19.59    | 8.58        | 4.32     | 13.85         | 16.14         | 0.000     | 9.84           |
| Ballerina           | HTTP 2   | 1             | 6.95         | 20.70    | 6.45        | 3.17     | 9.23          | 14.55         | 0.000     | 9.89           |
| Java (AOT)          | HTTP 1.1 | 1             | 21.76        | 49.28    | 19.77       | 11.81    | 32.70         | 45.21         | 0.000     | 9.71           |
| Java (AOT)          | HTTP 2   | 1             | 20.35        | 44.02    | 18.31       | 12.32    | 35.90         | 36.85         | 0.000     | 9.80           |
| Java                | HTTP 1.1 | 1             | 22.15        | 63.07    | 19.09       | 12.68    | 30.86         | 56.69         | 0.000     | 9.72           |
| Java                | HTTP 2   | 1             | 20.85        | 43.71    | 18.86       | 10.85    | 28.69         | 39.77         | 0.000     | 9.77           |
| ------------------- | -------- | ------------- | ------------ | -------- | ----------- | -------- | ------------- | ------------- | --------- | -------------- |
| Ballerina (AOT)     | HTTP 1.1 | 2             | 11.84        | 42.66    | 9.70        | 2.62     | 22.98         | 31.26         | 0.000     | 98.82          |
| Ballerina (AOT)     | HTTP 2   | 2             | 11.42        | 37.92    | 8.06        | 2.58     | 23.71         | 29.65         | 0.000     | 98.90          |
| Ballerina           | HTTP 1.1 | 2             | 11.21        | 35.76    | 9.40        | 2.64     | 19.84         | 24.92         | 0.000     | 98.28          |
| Ballerina           | HTTP 2   | 2             | 10.48        | 58.58    | 10.58       | 2.07     | 24.93         | 29.75         | 0.000     | 98.29          |
| Java (AOT)          | HTTP 1.1 | 2             | 39.19        | 364.19   | 32.40       | 10.73    | 56.02         | 66.45         | 0.000     | 95.23          |
| Java (AOT)          | HTTP 2   | 2             | 36.54        | 354.18   | 29.33       | 10.36    | 57.16         | 62.29         | 0.000     | 96.74          |
| Java                | HTTP 1.1 | 2             | 24.70        | 129.36   | 22.87       | 11.05    | 36.31         | 41.29         | 0.000     | 96.87          |
| Java                | HTTP 2   | 2             | 21.50        | 128.63   | 18.23       | 10.84    | 30.24         | 37.20         | 0.000     | 97.20          |

#### 2 - API Gateway - Ballerina

| User MCS Technology | Protocol | Configuration | Average (ms) | Max (ms) | Median (ms) | Min (ms) | 90% Line (ms) | 95% Line (ms) | Error (%) | Throughput (s) |
|---------------------|----------|---------------|--------------|----------|-------------|----------|---------------|---------------|-----------|----------------|
| Ballerina (AOT)     | HTTP 1.1 | 1             | 8.71         | 18.64    | 7.51        | 3.94     | 13.45         | 15.35         | 0.000     | 9.85           |
| Ballerina (AOT)     | HTTP 2   | 1             | 7.88         | 18.38    | 6.73        | 3.17     | 12.38         | 14.76         | 0.000     | 9.87           |
| Ballerina           | HTTP 1.1 | 1             | 10.11        | 14.74    | 10.15       | 5.31     | 13.03         | 13.54         | 0.000     | 9.80           |
| Ballerina           | HTTP 2   | 1             | 9.77         | 14.62    | 8.90        | 3.35     | 12.76         | 13.05         | 0.000     | 9.83           |
| Java (AOT)          | HTTP 1.1 | 1             | 23.05        | 46.45    | 18.84       | 11.81    | 38.20         | 40.99         | 0.000     | 9.68           |
| Java (AOT)          | HTTP 2   | 1             | 20.89        | 47.35    | 19.20       | 10.84    | 32.99         | 39.12         | 0.000     | 9.78           |
| Java                | HTTP 1.1 | 1             | 23.74        | 41.67    | 21.57       | 12.50    | 38.58         | 40.04         | 0.000     | 9.69           |
| Java                | HTTP 2   | 1             | 22.56        | 32.51    | 17.97       | 11.61    | 23.62         | 27.06         | 0.000     | 9.75           |
| ------------------- | -------- | ------------- | ------------ | -------- | ----------- | -------- | ------------- | ------------- | --------- | -------------- |
| Ballerina (AOT)     | HTTP 1.1 | 2             | 14.83        | 37.88    | 15.33       | 2.63     | 25.26         | 29.35         | 0.000     | 98.80          |
| Ballerina (AOT)     | HTTP 2   | 2             | 14.12        | 37.00    | 11.44       | 2.05     | 27.17         | 33.00         | 0.000     | 98.85          |
| Ballerina           | HTTP 1.1 | 2             | 13.93        | 33.91    | 13.09       | 2.62     | 22.86         | 25.60         | 0.000     | 98.04          |
| Ballerina           | HTTP 2   | 2             | 12.90        | 33.23    | 11.89       | 2.54     | 22.32         | 25.31         | 0.000     | 98.16          |
| Java (AOT)          | HTTP 1.1 | 2             | 39.54        | 344.61   | 31.39       | 9.73     | 61.73         | 88.06         | 0.000     | 93.83          |
| Java (AOT)          | HTTP 2   | 2             | 38.89        | 357.16   | 34.71       | 10.31    | 64.50         | 76.98         | 0.000     | 96.06          |
| Java                | HTTP 1.1 | 2             | 25.88        | 139.69   | 22.24       | 9.57     | 38.63         | 60.75         | 0.000     | 96.64          |
| Java                | HTTP 2   | 2             | 24.90        | 138.83   | 21.52       | 11.51    | 35.56         | 43.47         | 0.000     | 96.71          |

#### 3 - API Gateway - Java (AOT)

| User MCS Technology | Protocol | Configuration | Average (ms) | Max (ms) | Median (ms) | Min (ms) | 90% Line (ms) | 95% Line (ms) | Error (%) | Throughput (s) |
|---------------------|----------|---------------|--------------|----------|-------------|----------|---------------|---------------|-----------|----------------|
| Ballerina (AOT)     | HTTP 1.1 | 1             | 7.63         | 18.15    | 7.94        | 2.13     | 10.61         | 11.12         | 0.000     | 9.85           |
| Ballerina (AOT)     | HTTP 2   | 1             | 7.50         | 15.56    | 7.56        | 3.22     | 12.07         | 12.74         | 0.000     | 9.87           |
| Ballerina           | HTTP 1.1 | 1             | 10.64        | 19.88    | 10.57       | 4.76     | 13.07         | 15.86         | 0.000     | 9.80           |
| Ballerina           | HTTP 2   | 1             | 9.66         | 18.24    | 9.97        | 3.65     | 12.21         | 15.09         | 0.000     | 9.82           |
| Java (AOT)          | HTTP 1.1 | 1             | 22.77        | 39.31    | 23.77       | 11.75    | 33.23         | 35.78         | 0.000     | 9.70           |
| Java (AOT)          | HTTP 2   | 1             | 20.65        | 46.20    | 17.35       | 10.45    | 37.95         | 40.46         | 0.000     | 9.74           |
| Java                | HTTP 1.1 | 1             | 25.70        | 45.18    | 22.83       | 13.09    | 37.09         | 37.84         | 0.000     | 9.68           |
| Java                | HTTP 2   | 1             | 21.44        | 44.26    | 20.03       | 11.78    | 29.96         | 40.85         | 0.000     | 9.73           |
| ------------------- | -------- | ------------- | ------------ | -------- | ----------- | -------- | ------------- | ------------- | --------- | -------------- |
| Ballerina (AOT)     | HTTP 1.1 | 2             | 12.06        | 39.22    | 10.57       | 2.07     | 20.88         | 25.40         | 0.000     | 62.33          |
| Ballerina (AOT)     | HTTP 2   | 2             | 11.61        | 39.56    | 9.73        | 2.10     | 21.86         | 25.74         | 0.000     | 70.91          |
| Ballerina           | HTTP 1.1 | 2             | 12.90        | 41.58    | 11.73       | 2.09     | 22.32         | 26.72         | 0.000     | 65.51          |
| Ballerina           | HTTP 2   | 2             | 11.12        | 47.62    | 10.00       | 2.07     | 18.66         | 24.23         | 0.000     | 74.13          |
| Java (AOT)          | HTTP 1.1 | 2             | 40.02        | 341.86   | 31.63       | 9.24     | 62.24         | 71.90         | 0.000     | 94.36          |
| Java (AOT)          | HTTP 2   | 2             | 38.97        | 336.74   | 29.09       | 9.90     | 66.19         | 66.31         | 0.000     | 94.82          |
| Java                | HTTP 1.1 | 2             | 26.24        | 118.46   | 23.06       | 10.40    | 40.07         | 44.27         | 0.000     | 96.75          |
| Java                | HTTP 2   | 2             | 23.99        | 126.94   | 22.34       | 10.29    | 35.91         | 44.08         | 0.000     | 97.03          |

#### 4 - API Gateway - Java

| User MCS Technology | Protocol | Configuration | Average (ms) | Max (ms) | Median (ms) | Min (ms) | 90% Line (ms) | 95% Line (ms) | Error (%) | Throughput (s) |
|---------------------|----------|---------------|--------------|----------|-------------|----------|---------------|---------------|-----------|----------------|
| Ballerina (AOT)     | HTTP 1.1 | 1             | 9.30         | 19.60    | 8.98        | 4.29     | 12.92         | 14.81         | 0.000     | 9.82           |
| Ballerina (AOT)     | HTTP 2   | 1             | 8.38         | 18.15    | 7.83        | 3.15     | 13.87         | 17.27         | 0.000     | 9.86           |
| Ballerina           | HTTP 1.1 | 1             | 11.45        | 25.41    | 10.50       | 4.48     | 17.88         | 20.45         | 0.000     | 9.78           |
| Ballerina           | HTTP 2   | 1             | 10.99        | 23.64    | 10.72       | 4.30     | 15.48         | 16.69         | 0.000     | 9.79           |
| Java (AOT)          | HTTP 1.1 | 1             | 23.34        | 41.67    | 23.01       | 11.31    | 34.09         | 37.83         | 0.000     | 9.67           |
| Java (AOT)          | HTTP 2   | 1             | 21.25        | 41.28    | 21.46       | 11.88    | 27.20         | 30.49         | 0.000     | 9.72           |
| Java                | HTTP 1.1 | 1             | 25.79        | 47.61    | 24.36       | 15.92    | 34.22         | 42.73         | 0.000     | 9.67           |
| Java                | HTTP 2   | 1             | 23.67        | 39.17    | 21.85       | 11.89    | 36.66         | 38.11         | 0.000     | 9.70           |
| ------------------- | -------- | ------------- | ------------ | -------- | ----------- | -------- | ------------- | ------------- | --------- | -------------- |
| Ballerina (AOT)     | HTTP 1.1 | 2             | 15.02        | 64.53    | 13.57       | 3.17     | 22.35         | 28.36         | 0.000     | 56.23          |
| Ballerina (AOT)     | HTTP 2   | 2             | 14.69        | 62.75    | 12.97       | 2.64     | 24.32         | 30.69         | 0.000     | 64.29          |
| Ballerina           | HTTP 1.1 | 2             | 14.25        | 78.55    | 12.37       | 3.83     | 22.20         | 29.63         | 0.000     | 59.66          |
| Ballerina           | HTTP 2   | 2             | 13.27        | 70.63    | 12.54       | 3.08     | 19.16         | 21.39         | 0.000     | 67.62          |
| Java (AOT)          | HTTP 1.1 | 2             | 40.78        | 328.10   | 34.47       | 9.97     | 56.12         | 66.46         | 0.000     | 93.76          |
| Java (AOT)          | HTTP 2   | 2             | 39.47        | 313.21   | 30.82       | 9.94     | 57.45         | 85.23         | 0.000     | 94.19          |
| Java                | HTTP 1.1 | 2             | 27.71        | 141.98   | 23.33       | 11.53    | 46.07         | 50.36         | 0.000     | 95.75          |
| Java                | HTTP 2   | 2             | 26.87        | 140.27   | 23.32       | 11.38    | 44.63         | 47.67         | 0.000     | 96.71          |

### System Stress Test requests

For this test, a stepping thread group was used, in order to increase the number of threads overtime, starting with 1 till the first timeout error is reached.

| Technology      | Protocol | Max Number of VUs |
|-----------------|----------|-------------------|
| Ballerina (AOT) | HTTP 1.1 | 9579              |
| Ballerina (AOT) | HTTP 2   | 11373             |
| Ballerina       | HTTP 1.1 | 8381              |
| Ballerina       | HTTP 2   | 9172              |
| Java (AOT)      | HTTP 1.1 | 7644              |
| Java (AOT)      | HTTP 2   | 8984              |
| Java            | HTTP 1.1 | 6356              |
| Java            | HTTP 2   | 7757              |

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
Leading to the conclusion that Ballerina has a better performance when communicating with other Ballerina services.

## Stress Test

From the system stress test, the conclusion is that Ballerina with its AOT compilation and HTTP/2 protocol has the best performance in scenarios of high load. It can handle more 24% of users at the same time as Java with the same configuration.
Proving that Ballerina can be a good candidate for distributed systems, as it can handle several users at the same time in scenarios of high load, like black friday sales and other high traffic events.

## HTTP/1.1 vs HTTP/2.0

As for the both HTTP protocols, as expected, HTTP/2.0 has a better performance than HTTP/1.1 in all the cases, as it has features that allow the server to handle more requests at the same time, leading to a better performance in all the cases.

## Startup times

With the AOT compilation, Ballerina demonstrates a mean time of ~66ms to launch the API Gateway application, decreasing its startup time by ~89.6%.

## Conclusion

The performance tests indicate that Ballerina is a strong candidate for distributed systems, particularly when using AOT compilation with HTTP/2. The results suggest the following:
 - Efficiency: Ballerina provides faster response times and can handle more concurrent users compared to Java, making it a robust choice for high-load scenarios.
 - Scalability: The superior performance of Ballerina in stress tests indicates its ability to scale effectively without significant degradation in performance.
 - Protocol Utilization: Ballerina better utilizes HTTP/2 advantages, further enhancing its performance edge over Java.
 - Compilation: AOT compilation significantly reduces Ballerina's startup time, making it a more efficient choice for applications requiring frequent restarts. Besides, it also improves the performance of the application.

Given these points, Ballerina proves to be a compelling option for building high-performance, scalable distributed applications.