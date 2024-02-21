# Performance Test Results

## Introduction

This report presents the result of the performance test conducted on the API Gateways implemented in **Ballerina** and *
*Spring Boot**.
The focus is on comparing the performance across two different protocol versions: **HTTP 1.1** and **HTTP 2**, for each
technology.

## Methodology

The tests utilized **Apache JMeter** to simulate various combinations of technology (Ballerina and Spring Boot) and
protocol (HTTP 1.1 and HTTP 2).
Each thread group was configured to represent a specific number of virtual users accessing the system simultaneously,
providing a comprehensive view of performance under different conditions.

### Test Configuration

In total inside the jmeter test there are 8 group threads, the first 4 threads are configured to simulate 100 users and
the last 4 threads are configured to simulate 500 users. The test was configured with the following parameters:

- **Configuration 1:**
    - **Number of Threads (users):** 100
    - **Ramp-Up Time:** 50 seconds
    - **Test Duration:** 60 seconds

- **Configuration 2:**
    - **Number of Threads (users):** 500
    - **Ramp-Up Time:** 100 seconds
    - **Test Duration:** 60 seconds

#### Endpoints Tested:

| Technology  | Protocol | Endpoint                                  |
|-------------|----------|-------------------------------------------|
| Ballerina   | HTTP 1.1 | `http://localhost:9090/users/getAllUsers` |
| Ballerina   | HTTP 2   | `http://localhost:9090/users/getAllUsers` |
| Spring Boot | HTTP 1.1 | `http://localhost:8080/users/getAllUsers` |
| Spring Boot | HTTP 2   | `http://localhost:8080/users/getAllUsers` |

## Results

Bellow are the results obtained from the test:

### Report Summary

| Technology    | Protocol   | Configuration   | Samples   | Average   | Min   | Max   | Std. Dev.   | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) | Avg. Bytes   |
|---------------|------------|-----------------|-----------|-----------|-------|-------|-------------|-----------|------------------|-------------------|---------------|--------------|
| Ballerina     | HTTP 1.1   | 1               | 100       | 27        | 17    | 437   | 41.69       | 0.00      | 2.0              | 4.83              | 0.00          | 2450.0       |
| Ballerina     | HTTP 2     | 1               | 100       | 27        | 17    | 417   | 39.77       | 0.00      | 2.0              | 4.75              | 0.00          | 2407.0       |
| Spring Boot   | HTTP 1.1   | 1               | 100       | 21        | 16    | 103   | 9.48        | 0.00      | 2.0              | 4.96              | 0.00          | 2514.0       |
| Spring Boot   | HTTP 2     | 1               | 100       | 20        | 14    | 87    | 7.98        | 0.00      | 2.0              | 4.96              | 0.00          | 2514.0       |
| ------------- | ---------- | --------------- | --------- | --------- | ----- | ----- | ----------- | --------- | ---------------- | ----------------- | ------------- | ------------ |
| Ballerina     | HTTP 1.1   | 2               | 500       | 22        | 16    | 365   | 17.07       | 0.00      | 5.0              | 11.98             | 0.00          | 2450.0       |
| Ballerina     | HTTP 2     | 2               | 500       | 19        | 15    | 299   | 13.59       | 0.00      | 5.0              | 11.77             | 0.00          | 2407.0       |
| Spring Boot   | HTTP 1.1   | 2               | 500       | 18        | 14    | 52    | 3.27        | 0.00      | 5.0              | 12.3              | 0.00          | 2514.0       |
| Spring Boot   | HTTP 2     | 2               | 500       | 19        | 15    | 48    | 3.67        | 0.00      | 5.0              | 12.30             | 0.00          | 2514.0       |

## Sample request overview

| Technology  | Protocol | Load Time | Connect Time | Latency | Sizes in bytes | Sent bytes | Headers size in bytes | Body size in bytes |
|-------------|----------|-----------|--------------|---------|----------------|------------|-----------------------|--------------------|
| Ballerina   | HTTP 1.1 | 46        | 1            | 46      | 2450           | 0          | 237                   | 2213               |
| Ballerina   | HTTP 2   | 46        | 1            | 46      | 2407           | 0          | 194                   | 2213               |
| Spring Boot | HTTP 1.1 | 35        | 1            | 36      | 2514           | 0          | 387                   | 2127               |
| Spring Boot | HTTP 2   | 35        | 1            | 36      | 2514           | 0          | 387                   | 2127               |