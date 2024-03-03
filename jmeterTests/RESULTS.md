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

| Technology             | Protocol | Endpoint                                  |
|------------------------|----------|-------------------------------------------|
| Ballerina GraalVM (GV) | HTTP 1.1 | `http://localhost:9090/users/getAllUsers` |
| Ballerina GraalVM (GV) | HTTP 2   | `http://localhost:9090/users/getAllUsers` |
| Ballerina              | HTTP 1.1 | `http://localhost:9090/users/getAllUsers` |
| Ballerina              | HTTP 2   | `http://localhost:9090/users/getAllUsers` |
| Spring Boot            | HTTP 1.1 | `http://localhost:8080/users/getAllUsers` |
| Spring Boot            | HTTP 2   | `http://localhost:8080/users/getAllUsers` |

## Results

Bellow are the results obtained from the test:

### Report Summary

| Technology    | Protocol   | Configuration   | Samples   | Average   | Min   | Max   | Std. Dev.   | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) | Avg. Bytes   |
|---------------|------------|-----------------|-----------|-----------|-------|-------|-------------|-----------|------------------|-------------------|---------------|--------------|
| Ballerina GV  | HTTP 1.1   | 1               | 100       | 23        | 17    | 34    | 4.18        | 0.000     | 2.01935          | 4.83              | 0.00          | 2448.0       |
| Ballerina GV  | HTTP 2     | 1               | 100       | 22        | 16    | 32    | 4.06        | 0.000     | 2.01955          | 4.76              | 0.00          | 2405.0       |
| Ballerina     | HTTP 1.1   | 1               | 100       | 25        | 18    | 139   | 12.29       | 0.000     | 2.02298          | 4.84              | 0.00          | 2448.0       |
| Ballerina     | HTTP 2     | 1               | 100       | 25        | 18    | 152   | 13.52       | 0.000     | 2.02253          | 4.75              | 0.00          | 2405.0       |
| Spring Boot   | HTTP 1.1   | 1               | 100       | 23        | 17    | 116   | 10.08       | 0.000     | 2.02224          | 4.96              | 0.00          | 2514.0       |
| Spring Boot   | HTTP 2     | 1               | 100       | 22        | 17    | 116   | 10.18       | 0.000     | 2.02184          | 4.96              | 0.00          | 2514.0       |
| ------------- | ---------- | --------------- | --------- | --------- | ----- | ----- | ----------- | --------- | ---------------- | ----------------- | ------------- | ------------ |
| Ballerina GV  | HTTP 1.1   | 2               | 500       | 21        | 17    | 38    | 2.43        | 0.000     | 5.00902          | 11.97             | 0.00          | 2448.0       |
| Ballerina GV  | HTTP 2     | 2               | 500       | 18        | 15    | 32    | 1.72        | 0.000     | 5.00917          | 11.76             | 0.00          | 2405.0       |
| Ballerina     | HTTP 1.1   | 2               | 500       | 19        | 15    | 128   | 5.62        | 0.000     | 5.01128          | 11.98             | 0.00          | 2448.0       |
| Ballerina     | HTTP 2     | 2               | 500       | 19        | 15    | 143   | 6.59        | 0.000     | 5.00937          | 11.77             | 0.00          | 2405.0       |
| Spring Boot   | HTTP 1.1   | 2               | 500       | 18        | 14    | 61    | 3.43        | 0.000     | 5.00927          | 12.30             | 0.00          | 2514.0       |
| Spring Boot   | HTTP 2     | 2               | 500       | 17        | 14    | 51    | 2.57        | 0.000     | 5.00947          | 12.30             | 0.00          | 2514.0       |

## Stress Test request (~10% error rate)

For this test, the number of threads was increased as many as possible to simulate a stress test.

| Technology   | Protocol | Samples | Average | Min | Max | Std. Dev. | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) | Avg. Bytes |
|--------------|----------|---------|---------|-----|-----|-----------|-----------|------------------|-------------------|---------------|------------|
| Ballerina GV | HTTP 1.1 | 5900    | 39      | 3   | 307 | 39.49     | 7.695     | 124.64087        | 298.75            | 0.00          | 2454.4     |
| Ballerina GV | HTTP 2   | 5900    | 38      | 3   | 290 | 38.06     | 7.915     | 124.97352        | 294.73            | 0.00          | 2415.0     |
| Ballerina    | HTTP 1.1 | 2915    | 31      | 3   | 412 | 31.13     | 8.199     | 58.83065         | 141.03            | 0.00          | 2454.8     |
| Ballerina    | HTTP 2   | 2915    | 31      | 5   | 370 | 30.20     | 8.096     | 58.83778         | 138.77            | 0.00          | 2415.2     |
| Spring Boot  | HTTP 1.1 | 2915    | 27      | 4   | 248 | 21.40     | 8.096     | 58.62714         | 144.01            | 0.00          | 2515.4     |
| Spring Boot  | HTTP 2   | 2915    | 27      | 4   | 246 | 21.62     | 8.027     | 58.81997         | 144.49            | 0.00          | 2515.4     |
## Sample request overview

| Technology   | Protocol | Load Time | Connect Time | Latency | Sizes in bytes | Sent bytes | Headers size in bytes | Body size in bytes |
|--------------|----------|-----------|--------------|---------|----------------|------------|-----------------------|--------------------|
| Ballerina GV | HTTP 1.1 | 27        | 2            | 28      | 2448           | 0          | 235                   | 2213               |
| Ballerina GV | HTTP 2   | 27        | 1            | 28      | 2405           | 0          | 192                   | 2213               |
| Ballerina    | HTTP 1.1 | 31        | 1            | 31      | 2448           | 0          | 235                   | 2213               |
| Ballerina    | HTTP 2   | 29        | 1            | 30      | 2405           | 0          | 192                   | 2213               |
| Spring Boot  | HTTP 1.1 | 29        | 1            | 30      | 2514           | 0          | 387                   | 2127               |
| Spring Boot  | HTTP 2   | 26        | 2            | 26      | 2514           | 0          | 387                   | 2127               |

## Startup times:

| Technology   | Average Startup Time |
|--------------|----------------------|
| Ballerina GV | ~0.065s              |
| Ballerina    | ~0.669s              |
| Spring Boot  | ~1.644s              |

# Conclusion
