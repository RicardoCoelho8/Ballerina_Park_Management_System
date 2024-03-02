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
| Ballerina GV  | HTTP 1.1   | 1               | 100       |           |       |       |             |           |                  |                   |               |              |
| Ballerina GV  | HTTP 2     | 1               | 100       |           |       |       |             |           |                  |                   |               |              |
| Ballerina     | HTTP 1.1   | 1               | 100       |           |       |       |             |           |                  |                   |               |              |
| Ballerina     | HTTP 2     | 1               | 100       |           |       |       |             |           |                  |                   |               |              |
| Spring Boot   | HTTP 1.1   | 1               | 100       |           |       |       |             |           |                  |                   |               |              |
| Spring Boot   | HTTP 2     | 1               | 100       |           |       |       |             |           |                  |                   |               |              |
| ------------- | ---------- | --------------- | --------- | --------- | ----- | ----- | ----------- | --------- | ---------------- | ----------------- | ------------- | ------------ |
| Ballerina GV  | HTTP 1.1   | 2               | 500       |           |       |       |             |           |                  |                   |               |              |
| Ballerina GV  | HTTP 2     | 2               | 500       |           |       |       |             |           |                  |                   |               |              |
| Ballerina     | HTTP 1.1   | 2               | 500       |           |       |       |             |           |                  |                   |               |              |
| Ballerina     | HTTP 2     | 2               | 500       |           |       |       |             |           |                  |                   |               |              |
| Spring Boot   | HTTP 1.1   | 2               | 500       |           |       |       |             |           |                  |                   |               |              |
| Spring Boot   | HTTP 2     | 2               | 500       |           |       |       |             |           |                  |                   |               |              |

## Stress Test request (~10% error rate)

For this test, the number of threads was increased as many as possible to simulate a stress test.

| Technology   | Protocol | Samples | Average | Min | Max | Std. Dev. | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) | Avg. Bytes |
|--------------|----------|---------|---------|-----|-----|-----------|-----------|------------------|-------------------|---------------|------------|
| Ballerina GV | HTTP 1.1 | 100     |         |     |     |           |           |                  |                   |               |            |
| Ballerina GV | HTTP 2   | 100     |         |     |     |           |           |                  |                   |               |            |
| Ballerina    | HTTP 1.1 | 100     |         |     |     |           |           |                  |                   |               |            |
| Ballerina    | HTTP 2   | 100     |         |     |     |           |           |                  |                   |               |            |
| Spring Boot  | HTTP 1.1 | 100     |         |     |     |           |           |                  |                   |               |            |
| Spring Boot  | HTTP 2   | 100     |         |     |     |           |           |                  |                   |               |            |

## Sample request overview

| Technology   | Protocol | Load Time | Connect Time | Latency | Sizes in bytes | Sent bytes | Headers size in bytes | Body size in bytes |
|--------------|----------|-----------|--------------|---------|----------------|------------|-----------------------|--------------------|
| Ballerina GV | HTTP 1.1 |           |              |         |                |            |                       |                    |
| Ballerina GV | HTTP 2   |           |              |         |                |            |                       |                    |
| Ballerina    | HTTP 1.1 |           |              |         |                |            |                       |                    |
| Ballerina    | HTTP 2   |           |              |         |                |            |                       |                    |
| Spring Boot  | HTTP 1.1 |           |              |         |                |            |                       |                    |
| Spring Boot  | HTTP 2   |           |              |         |                |            |                       |                    |

## Startup times:

| Technology   | Average Startup Time |
|--------------|----------------------|
| Ballerina GV | ~0.065s              |
| Ballerina    | ~0.669s              |
| Spring Boot  | ~1.644s              |