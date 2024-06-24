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

The tests utilized **Apache JMeter** to simulate various combinations of technology (Ballerina and Java) and
protocol (HTTP 1.1 and HTTP 2).
Each thread group was configured to represent a specific number of virtual users accessing the system simultaneously,
providing a comprehensive view of performance under different conditions.

### Test Configuration

In total inside the jmeter test there are 8 group threads, the first 4 threads are configured to simulate 100 users and
the last 4 threads are configured to simulate 1000 users. The test was configured with the following parameters:

- **Configuration 1:**
    - **Number of Threads (users):** 100
    - **Ramp-Up Time:** 50 seconds

- **Configuration 2:**
    - **Number of Threads (users):** 1000
    - **Ramp-Up Time:** 100 seconds

#### Endpoints Tested:

| Technology              | Protocol | Endpoint                                  |
|-------------------------|----------|-------------------------------------------|
| Ballerina GraalVM (AOT) | HTTP 1.1 | `http://localhost:9090/users/getAllUsers` |
| Ballerina GraalVM (AOT) | HTTP 2   | `http://localhost:9090/users/getAllUsers` |
| Ballerina               | HTTP 1.1 | `http://localhost:9090/users/getAllUsers` |
| Ballerina               | HTTP 2   | `http://localhost:9090/users/getAllUsers` |
| Java (AOT)              | HTTP 1.1 | `http://localhost:8080/users/getAllUsers` |
| Java (AOT)              | HTTP 2   | `http://localhost:8080/users/getAllUsers` |
| Java                    | HTTP 1.1 | `http://localhost:8080/users/getAllUsers` |
| Java                    | HTTP 2   | `http://localhost:8080/users/getAllUsers` |

## Results

Bellow are the results obtained from the tests:

### Report Summary

#### 1 - API Gateway - Ballerina (AOT)

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Median | 90% Line | 95% Line    | 99% Line  | Min | Max | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) |
|---------------------|------------|-----------------|-----------|-----------|--------|----------|-------------|-----------|-----|-----|-----------|------------------|-------------------|---------------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 1000      | 12        | 12     | 14       | 15          | 19        | 10  | 30  | 0.000%    | 20.15195         | 48.29             | 0.00          |
| Ballerina (AOT)     | HTTP 2     | 1               | 1000      | 13        | 13     | 16       | 17          | 21        | 10  | 49  | 0.000%    | 20.14302         | 48.19             | 0.00          |
| Ballerina           | HTTP 1.1   | 1               | 1000      | 10        | 10     | 13       | 15          | 18        | 8   | 33  | 0.000%    | 20.15723         | 48.31             | 0.00          |
| Ballerina           | HTTP 2     | 1               | 1000      | 11        | 11     | 13       | 14          | 18        | 8   | 24  | 0.000%    | 20.15641         | 48.22             | 0.00          |
| Java (AOT)          | HTTP 1.1   | 1               | 1000      | 12        | 12     | 14       | 17          | 23        | 9   | 26  | 0.000%    | 20.15154         | 48.29             | 0.00          |
| Java (AOT)          | HTTP 2     | 1               | 1000      | 12        | 12     | 15       | 17          | 24        | 10  | 25  | 0.000%    | 20.15276         | 48.21             | 0.00          |
| Java                | HTTP 1.1   | 1               | 1000      | 11        | 11     | 13       | 15          | 17        | 9   | 20  | 0.000%    | 20.15316         | 48.30             | 0.00          |
| Java                | HTTP 2     | 1               | 1000      | 11        | 11     | 13       | 15          | 17        | 8   | 23  | 0.000%    | 20.15398         | 48.21             | 0.00          |
| -------------       | ---------- | --------------- | --------- | --------- | -----  | -----    | ----------- | --------- | --- | --- | --------- | ---------------  | ----------------- | ------------- |
| Ballerina (AOT)     | HTTP 1.1   | 2               | 10000     | 13        | 13     | 16       | 18          | 22        | 10  | 37  | 0.000%    | 99.96301         | 239.56            | 0.00          |
| Ballerina (AOT)     | HTTP 2     | 2               | 10000     | 13        | 13     | 16       | 18          | 23        | 9   | 46  | 0.000%    | 99.98000         | 239.18            | 0.00          |
| Ballerina           | HTTP 1.1   | 2               | 10000     | 10        | 11     | 13       | 14          | 17        | 7   | 36  | 0.000%    | 99.97201         | 239.58            | 0.00          |
| Ballerina           | HTTP 2     | 2               | 10000     | 11        | 11     | 13       | 15          | 18        | 7   | 29  | 0.000%    | 99.99600         | 239.22            | 0.00          |
| Java (AOT)          | HTTP 1.1   | 2               | 10000     | 11        | 11     | 14       | 16          | 23        | 9   | 37  | 0.000%    | 99.98000         | 239.60            | 0.00          |
| Java (AOT)          | HTTP 2     | 2               | 10000     | 12        | 12     | 14       | 16          | 23        | 8   | 34  | 0.000%    | 99.98000         | 239.18            | 0.00          |
| Java                | HTTP 1.1   | 2               | 10000     | 11        | 11     | 12       | 14          | 17        | 8   | 22  | 0.000%    | 99.98600         | 239.61            | 0.00          |
| Java                | HTTP 2     | 2               | 10000     | 11        | 11     | 13       | 14          | 17        | 8   | 22  | 0.000%    | 99.98800         | 239.20            | 0.00          |

#### 2 - API Gateway - Ballerina

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Median | 90% Line | 95% Line    | 99% Line  | Min | Max | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) |
|---------------------|------------|-----------------|-----------|-----------|--------|----------|-------------|-----------|-----|-----|-----------|------------------|-------------------|---------------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 1000      | 10        | 10     | 12       | 13          | 15        | 8   | 24  | 0.000%    | 20.16373         | 48.32             | 0.00          |
| Ballerina (AOT)     | HTTP 2     | 1               | 1000      | 11        | 11     | 13       | 14          | 16        | 8   | 19  | 0.000%    | 20.15804         | 48.22             | 0.00          |
| Ballerina           | HTTP 1.1   | 1               | 1000      | 10        | 10     | 12       | 12          | 14        | 8   | 20  | 0.000%    | 20.16048         | 48.31             | 0.00          |
| Ballerina           | HTTP 2     | 1               | 1000      | 10        | 10     | 12       | 12          | 14        | 8   | 17  | 0.000%    | 20.15641         | 48.22             | 0.00          |
| Java (AOT)          | HTTP 1.1   | 1               | 1000      | 13        | 13     | 15       | 17          | 24        | 11  | 28  | 0.000%    | 20.15113         | 48.29             | 0.00          |
| Java (AOT)          | HTTP 2     | 1               | 1000      | 12        | 12     | 15       | 16          | 24        | 10  | 28  | 0.000%    | 20.14586         | 48.19             | 0.00          |
| Java                | HTTP 1.1   | 1               | 1000      | 10        | 11     | 12       | 13          | 14        | 8   | 16  | 0.000%    | 20.15885         | 48.31             | 0.00          |
| Java                | HTTP 2     | 1               | 1000      | 10        | 10     | 12       | 13          | 14        | 8   | 18  | 0.000%    | 20.15926         | 48.23             | 0.00          |
| -------------       | ---------- | --------------- | --------- | --------- | -----  | -----    | ----------- | --------- | --- | --- | --------- | ---------------  | ----------------- | ------------- |
| Ballerina (AOT)     | HTTP 1.1   | 2               | 10000     | 10        | 10     | 12       | 14          | 16        | 7   | 24  | 0.000%    | 100.00800        | 239.67            | 0.00          |
| Ballerina (AOT)     | HTTP 2     | 2               | 10000     | 10        | 10     | 12       | 14          | 16        | 8   | 22  | 0.000%    | 99.98100         | 239.18            | 0.00          |
| Ballerina           | HTTP 1.1   | 2               | 10000     | 9         | 10     | 11       | 12          | 13        | 7   | 18  | 0.000%    | 100.00600        | 239.66            | 0.00          |
| Ballerina           | HTTP 2     | 2               | 10000     | 9         | 10     | 11       | 12          | 15        | 7   | 19  | 0.000%    | 100.01600        | 239.27            | 0.00          |
| Java (AOT)          | HTTP 1.1   | 2               | 10000     | 12        | 12     | 14       | 14          | 24        | 8   | 39  | 0.000%    | 100.00300        | 239.66            | 0.00          |
| Java (AOT)          | HTTP 2     | 2               | 10000     | 11        | 12     | 13       | 14          | 24        | 8   | 31  | 0.000%    | 99.99100         | 239.21            | 0.00          |
| Java                | HTTP 1.1   | 2               | 10000     | 10        | 10     | 12       | 12          | 14        | 7   | 19  | 0.000%    | 99.98700         | 239.62            | 0.00          |
| Java                | HTTP 2     | 2               | 10000     | 10        | 11     | 12       | 12          | 14        | 8   | 28  | 0.000%    | 99.99900         | 239.23            | 0.00          |

#### 3 - API Gateway - Java (AOT)

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Median | 90% Line | 95% Line    | 99% Line  | Min | Max | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) |
|---------------------|------------|-----------------|-----------|-----------|--------|----------|-------------|-----------|-----|-----|-----------|------------------|-------------------|---------------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 1000      | 9         | 9      | 11       | 12          | 16        | 6   | 25  | 0.000%    | 20.16414         | 51.77             | 0.00          |
| Ballerina (AOT)     | HTTP 2     | 1               | 1000      | 10        | 10     | 13       | 14          | 18        | 7   | 25  | 0.000%    | 20.16576         | 51.77             | 0.00          |
| Ballerina           | HTTP 1.1   | 1               | 1000      | 9         | 9      | 11       | 12          | 15        | 7   | 30  | 0.000%    | 20.16861         | 51.78             | 0.00          |
| Ballerina           | HTTP 2     | 1               | 1000      | 8         | 9      | 11       | 11          | 13        | 6   | 20  | 0.000%    | 20.17146         | 51.79             | 0.00          |
| Java (AOT)          | HTTP 1.1   | 1               | 1000      | 9         | 9      | 12       | 15          | 19        | 6   | 36  | 0.000%    | 20.16007         | 49.49             | 0.00          |
| Java (AOT)          | HTTP 2     | 1               | 1000      | 9         | 9      | 12       | 14          | 17        | 7   | 26  | 0.000%    | 20.15763         | 49.49             | 0.00          |
| Java                | HTTP 1.1   | 1               | 1000      | 9         | 9      | 12       | 14          | 16        | 6   | 36  | 0.000%    | 20.16373         | 49.50             | 0.00          |
| Java                | HTTP 2     | 1               | 1000      | 8         | 8      | 11       | 13          | 16        | 6   | 25  | 0.000%    | 20.16617         | 49.51             | 0.00          |
| -------------       | ---------- | --------------- | --------- | --------- | -----  | -----    | ----------- | --------- | --- | --- | --------- | ---------------  | ----------------- | ------------- |
| Ballerina (AOT)     | HTTP 1.1   | 2               | 10000     | 9         | 10     | 12       | 13          | 16        | 6   | 31  | 0.000%    | 99.99900         | 256.74            | 0.00          |
| Ballerina (AOT)     | HTTP 2     | 2               | 10000     | 9         | 9      | 12       | 13          | 15        | 6   | 22  | 0.000%    | 100.00000        | 256.74            | 0.00          |
| Ballerina           | HTTP 1.1   | 2               | 10000     | 8         | 8      | 10       | 11          | 13        | 5   | 24  | 0.000%    | 100.01800        | 256.78            | 0.00          |
| Ballerina           | HTTP 2     | 2               | 10000     | 8         | 9      | 10       | 11          | 13        | 5   | 20  | 0.000%    | 100.02200        | 256.79            | 0.00          |
| Java (AOT)          | HTTP 1.1   | 2               | 10000     | 9         | 9      | 11       | 12          | 13        | 7   | 32  | 0.000%    | 100.00700        | 245.52            | 0.00          |
| Java (AOT)          | HTTP 2     | 2               | 10000     | 9         | 10     | 11       | 12          | 16        | 7   | 32  | 0.000%    | 99.98800         | 245.48            | 0.00          |
| Java                | HTTP 1.1   | 2               | 10000     | 9         | 9      | 10       | 11          | 13        | 5   | 24  | 0.000%    | 100.00800        | 245.53            | 0.00          |
| Java                | HTTP 2     | 2               | 10000     | 9         | 9      | 11       | 11          | 14        | 6   | 28  | 0.000%    | 100.00800        | 245.53            | 0.00          |

#### 4 - API Gateway - Java

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Median | 90% Line | 95% Line    | 99% Line  | Min | Max | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) |
|---------------------|------------|-----------------|-----------|-----------|--------|----------|-------------|-----------|-----|-----|-----------|------------------|-------------------|---------------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 1000      | 10        | 10     | 12       | 13          | 15        | 8   | 21  | 0.000%    | 20.15763         | 51.75             | 0.00          |
| Ballerina (AOT)     | HTTP 2     | 1               | 1000      | 10        | 10     | 14       | 15          | 18        | 8   | 22  | 0.000%    | 20.15763         | 51.75             | 0.00          |
| Ballerina           | HTTP 1.1   | 1               | 1000      | 12        | 11     | 16       | 17          | 21        | 8   | 31  | 0.000%    | 20.15926         | 51.76             | 0.00          |
| Ballerina           | HTTP 2     | 1               | 1000      | 10        | 10     | 12       | 13          | 16        | 7   | 21  | 0.000%    | 20.15926         | 51.76             | 0.00          |
| Java (AOT)          | HTTP 1.1   | 1               | 1000      | 10        | 10     | 13       | 15          | 17        | 8   | 20  | 0.000%    | 20.15682         | 49.49             | 0.00          |
| Java (AOT)          | HTTP 2     | 1               | 1000      | 10        | 10     | 13       | 15          | 16        | 8   | 20  | 0.000%    | 20.15804         | 49.49             | 0.00          |
| Java                | HTTP 1.1   | 1               | 1000      | 10        | 10     | 12       | 13          | 15        | 8   | 26  | 0.000%    | 20.15641         | 49.49             | 0.00          |
| Java                | HTTP 2     | 1               | 1000      | 10        | 10     | 12       | 13          | 15        | 8   | 24  | 0.000%    | 20.16007         | 49.49             | 0.00          |
| -------------       | ---------- | --------------- | --------- | --------- | -----  | -----    | ----------- | --------- | --- | --- | --------- | ---------------  | ----------------- | ------------- |
| Ballerina (AOT)     | HTTP 1.1   | 2               | 10000     | 10        | 10     | 12       | 13          | 15        | 7   | 43  | 0.000%    | 100.00100        | 256.74            | 0.00          |
| Ballerina (AOT)     | HTTP 2     | 2               | 10000     | 10        | 10     | 12       | 13          | 15        | 7   | 21  | 0.000%    | 99.97101         | 256.66            | 0.00          |
| Ballerina           | HTTP 1.1   | 2               | 10000     | 9         | 9      | 11       | 12          | 13        | 6   | 18  | 0.000%    | 100.01500        | 256.78            | 0.00          |
| Ballerina           | HTTP 2     | 2               | 10000     | 9         | 9      | 11       | 11          | 12        | 5   | 18  | 0.000%    | 100.00900        | 256.76            | 0.00          |
| Java (AOT)          | HTTP 1.1   | 2               | 10000     | 11        | 10     | 13       | 17          | 32        | 7   | 45  | 0.000%    | 99.97601         | 245.45            | 0.00          |
| Java (AOT)          | HTTP 2     | 2               | 10000     | 11        | 10     | 13       | 17          | 32        | 7   | 44  | 0.000%    | 100.00000        | 245.51            | 0.00          |
| Java                | HTTP 1.1   | 2               | 10000     | 10        | 10     | 12       | 12          | 14        | 8   | 32  | 0.000%    | 100.00100        | 245.51            | 0.00          |
| Java                | HTTP 2     | 2               | 10000     | 10        | 10     | 12       | 13          | 14        | 7   | 26  | 0.000%    | 100.00300        | 245.52            | 0.00          |

### Total elapsed time

| Technology      | Average Elapsed time (ms) |
|-----------------|---------------------------|
| Ballerina (AOT) | ~13.815                   |
| Ballerina       | ~9.929                    |
| Java (AOT)      | ~9.229                    |
| Java            | ~10.487                   |

### System Stress Test requests

For this test, a stepping thread group was used, in order to increase the number of threads overtime, starting with 1 till the first timeout error is reached.

| Technology      | Number of threads simultaneous | Samples |
|-----------------|--------------------------------|---------|
| Ballerina (AOT) | 15                             | 10846   |
| Ballerina       | 15                             | 10246   |
| Java (AOT)      | 7627                           | 40181   |
| Java            | 7651                           | 118546  |

### Startup times:

Each technology was tested 10 times and bellows are the average startup times.

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

This analysis compares metrics like response time, Throughput, and elapsed duration time to assess Ballerina's performance against Java.

- **Response time**: Ballerina and Java showed similar response times, with Ballerina slightly faster in some cases.
- **Throughput**: The Throughput was consistent with different configurations, and both technologies handled a similar
  number of requests per second, with Ballerina being slightly better in most cases.
- **Elapsed duration time**: Ballerina performed better than Ballerina AOT, but it was not enough to surpass Java AOT.

Ballerina delivered a strong performance in terms of Response time and Throughput. 
However, in terms of elapsed duration time, Ballerina AOT has the worst average time, and Ballerina takes second place with more than ~7.6% average elapsed time than Java AOT.

## Startup times

With the AOT compilation, Ballerina demonstrates a mean time of ~66ms to launch the API Gateway application, decreasing its startup time by ~89.6%.

## Stress Test

From the results of the stress test, is clear that Ballerina cant handle a lot of threads simultaneously with a high load of requests at the same time. 
Compared to Java, Ballerina needs to improve its performance under stress to be a good candidate for distributed applications.

## HTTP /1.1 vs HTTP/2.0

The differences between HTTP 1.1 and HTTP 2.0 are minimal, and both protocols show similar performance, with HTTP 2.0 having a slight advantage in some cases. 
These results indicate that the choice of HTTP protocol may not be a significant factor in overall performance for this specific test setup, or the implementation does not leverage the HTTP/2 features, leading to similar results for both protocols.

## Conclusion

In conclusion, Ballerina demonstrates competitive performance capabilities compared to Java across various metrics like Response times, Throughput, and Startup times, mainly benefiting from its AOT compilation feature for faster application launches. 
However, there are areas where further optimization could enhance its performance, such as reducing response times under stress and improving elapsed duration time to match or surpass Java's AOT efficiency.
