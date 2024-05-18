# Performance Test Results

## Introduction

This report presents the results of the performance test conducted on the API Gateways and User Microservices
implemented in **Ballerina** and **Spring Boot**.
The focus is on comparing the performance across two different protocol versions: **HTTP 1.1** and **HTTP 2**, for each
technology.

Some concepts were considered in the test, such as the use of **Ahead-of-Time (AOT) compilation** and **Just-in-Time (
JIT) compilation** when using **GraalVM** to compile the Ballerina code.

- **JIT Compilation** optimizes code at runtime, dynamically adapting to runtime conditions.
- **AOT Compilation** precompiles code into native machine code before execution, providing faster startup and reduced
  runtime overhead.

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

| Technology              | Protocol | Endpoint                                  |
|-------------------------|----------|-------------------------------------------|
| Ballerina GraalVM (AOT) | HTTP 1.1 | `http://localhost:9090/users/getAllUsers` |
| Ballerina GraalVM (AOT) | HTTP 2   | `http://localhost:9090/users/getAllUsers` |
| Ballerina               | HTTP 1.1 | `http://localhost:9090/users/getAllUsers` |
| Ballerina               | HTTP 2   | `http://localhost:9090/users/getAllUsers` |
| Spring Boot             | HTTP 1.1 | `http://localhost:8080/users/getAllUsers` |
| Spring Boot             | HTTP 2   | `http://localhost:8080/users/getAllUsers` |
| Spring Boot (AOT)       | HTTP 1.1 | `http://localhost:8080/users/getAllUsers` |
| Spring Boot (AOT)       | HTTP 2   | `http://localhost:8080/users/getAllUsers` |

## Results
Bellow are the results obtained from the tests:

### Report Summary

#### 1 - API Gateway - Ballerina (AOT)

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Min   | Max   | Std. Dev.   | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) | Avg. Bytes   |
|---------------------|------------|-----------------|-----------|-----------|-------|-------|-------------|-----------|------------------|-------------------|---------------|--------------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 100       | 15        | 12    | 24    | 2.06        | 0.000%    | 2.01955          | 4.84              | 0.00          | 2452.0       |
| Ballerina (AOT)     | HTTP 2     | 1               | 100       | 15        | 12    | 20    | 1.90        | 0.000%    | 2.02032          | 4.75              | 0.00          | 2409.0       |
| Ballerina           | HTTP 1.1   | 1               | 100       | 13        | 11    | 21    | 1.69        | 0.000%    | 2.01996          | 4.84              | 0.00          | 2452.0       |
| Ballerina           | HTTP 2     | 1               | 100       | 14        | 12    | 23    | 1.78        | 0.000%    | 2.01988          | 4.75              | 0.00          | 2409.0       |
| Spring Boot         | HTTP 1.1   | 1               | 100       | 15        | 12    | 31    | 3.01        | 0.000%    | 2.01979          | 4.84              | 0.00          | 2452.0       |
| Spring Boot         | HTTP 2     | 1               | 100       | 14        | 11    | 24    | 2.21        | 0.000%    | 2.01992          | 4.75              | 0.00          | 2409.0       |
| Spring Boot (AOT)   | HTTP 1.1   | 1               | 100       | 15        | 12    | 27    | 2.21        | 0.000%    | 2.01959          | 4.84              | 0.00          | 2452.0       |
| Spring Boot (AOT)   | HTTP 2     | 1               | 100       | 15        | 12    | 23    | 2.13        | 0.000%    | 2.02008          | 4.75              | 0.00          | 2409.0       |
| -------------       | ---------- | --------------- | --------- | --------- | ----- | ----- | ----------- | --------- | ---------------- | ----------------- | ------------- | ------------ |
| Ballerina (AOT)     | HTTP 1.1   | 2               | 500       | 13        | 11    | 20    | 1.56        | 0.000%    | 5.01002          | 12.00             | 0.00          | 2452.0       |
| Ballerina (AOT)     | HTTP 2     | 2               | 500       | 13        | 11    | 23    | 1.72        | 0.000%    | 5.00927          | 11.78             | 0.00          | 2409.0       |
| Ballerina           | HTTP 1.1   | 2               | 500       | 14        | 12    | 24    | 1.77        | 0.000%    | 5.01007          | 12.00             | 0.00          | 2452.0       |
| Ballerina           | HTTP 2     | 2               | 500       | 13        | 11    | 20    | 1.60        | 0.000%    | 5.00947          | 11.78             | 0.00          | 2409.0       |
| Spring Boot         | HTTP 1.1   | 2               | 500       | 14        | 11    | 31    | 1.81        | 0.000%    | 5.00982          | 12.00             | 0.00          | 2452.0       |
| Spring Boot         | HTTP 2     | 2               | 500       | 13        | 10    | 22    | 1.51        | 0.000%    | 5.00982          | 11.79             | 0.00          | 2409.0       |
| Spring Boot (AOT)   | HTTP 1.1   | 2               | 500       | 15        | 13    | 30    | 1.80        | 0.000%    | 5.00932          | 11.99             | 0.00          | 2452.0       |
| Spring Boot (AOT)   | HTTP 2     | 2               | 500       | 14        | 12    | 27    | 1.70        | 0.000%    | 5.00952          | 11.79             | 0.00          | 2409.0       |

#### 2 - API Gateway - Ballerina

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Min   | Max   | Std. Dev.   | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) | Avg. Bytes   |
|---------------------|------------|-----------------|-----------|-----------|-------|-------|-------------|-----------|------------------|-------------------|---------------|--------------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 100       | 15        | 13    | 21    | 1.89        | 0.000%    | 2.01992          | 4.84              | 0.00          | 2452.0       |
| Ballerina (AOT)     | HTTP 2     | 1               | 100       | 15        | 13    | 20    | 1.66        | 0.000%    | 2.01959          | 4.75              | 0.00          | 2409.0       |
| Ballerina           | HTTP 1.1   | 1               | 100       | 14        | 12    | 22    | 1.67        | 0.000%    | 2.02024          | 4.84              | 0.00          | 2452.0       |
| Ballerina           | HTTP 2     | 1               | 100       | 14        | 12    | 20    | 1.40        | 0.000%    | 2.02020          | 4.75              | 0.00          | 2409.0       |
| Spring Boot         | HTTP 1.1   | 1               | 100       | 13        | 10    | 19    | 1.42        | 0.000%    | 2.01967          | 4.84              | 0.00          | 2452.0       |
| Spring Boot         | HTTP 2     | 1               | 100       | 14        | 12    | 20    | 1.33        | 0.000%    | 2.01967          | 4.75              | 0.00          | 2409.0       |
| Spring Boot (AOT)   | HTTP 1.1   | 1               | 100       | 15        | 13    | 25    | 1.90        | 0.000%    | 2.01983          | 4.84              | 0.00          | 2452.0       |
| Spring Boot (AOT)   | HTTP 2     | 1               | 100       | 15        | 13    | 20    | 1.35        | 0.000%    | 2.02004          | 4.75              | 0.00          | 2409.0       |
| -------------       | ---------- | --------------- | --------- | --------- | ----- | ----- | ----------- | --------- | ---------------- | ----------------- | ------------- | ------------ |
| Ballerina (AOT)     | HTTP 1.1   | 2               | 500       | 15        | 13    | 28    | 1.71        | 0.000%    | 5.00977          | 12.00             | 0.00          | 2452.0       |
| Ballerina (AOT)     | HTTP 2     | 2               | 500       | 15        | 12    | 27    | 1.88        | 0.000%    | 5.00892          | 11.78             | 0.00          | 2409.0       |
| Ballerina           | HTTP 1.1   | 2               | 500       | 13        | 11    | 21    | 1.09        | 0.000%    | 5.00942          | 12.00             | 0.00          | 2452.0       |
| Ballerina           | HTTP 2     | 2               | 500       | 13        | 10    | 28    | 1.53        | 0.000%    | 5.00992          | 11.79             | 0.00          | 2409.0       |
| Spring Boot         | HTTP 1.1   | 2               | 500       | 12        | 10    | 21    | 1.12        | 0.000%    | 5.00942          | 12.00             | 0.00          | 2452.0       |
| Spring Boot         | HTTP 2     | 2               | 500       | 18        | 15    | 34    | 2.06        | 0.000%    | 5.00927          | 11.77             | 0.00          | 2407.0       |
| Spring Boot (AOT)   | HTTP 1.1   | 2               | 500       | 15        | 12    | 24    | 1.40        | 0.000%    | 5.00972          | 12.00             | 0.00          | 2452.0       |
| Spring Boot (AOT)   | HTTP 2     | 2               | 500       | 12        | 10    | 21    | 1.23        | 0.000%    | 5.00992          | 11.79             | 0.00          | 2409.0       |

#### 3 - API Gateway - Spring boot

| User MCS Technology | Protocol   | Configuration   | Samples   | Average   | Min   | Max   | Std. Dev.   | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) | Avg. Bytes   |
|---------------------|------------|-----------------|-----------|-----------|-------|-------|-------------|-----------|------------------|-------------------|---------------|--------------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 100       | 12        | 10    | 20    | 1.56        | 0.000%    | 2.02000          | 5.18              | 0.00          | 2627.0       |
| Ballerina (AOT)     | HTTP 2     | 1               | 100       | 12        | 11    | 17    | 0.99        | 0.000%    | 2.01992          | 5.18              | 0.00          | 2627.0       |
| Ballerina           | HTTP 1.1   | 1               | 100       | 16        | 14    | 24    | 2.10        | 0.000%    | 2.01967          | 5.18              | 0.00          | 2627.0       |
| Ballerina           | HTTP 2     | 1               | 100       | 14        | 11    | 21    | 1.56        | 0.000%    | 2.02000          | 5.18              | 0.00          | 2627.0       |
| Spring Boot         | HTTP 1.1   | 1               | 100       | 11        | 9     | 15    | 0.84        | 0.000%    | 2.01967          | 4.96              | 0.00          | 2514.0       |
| Spring Boot         | HTTP 2     | 1               | 100       | 11        | 9     | 20    | 1.32        | 0.000%    | 2.01959          | 4.96              | 0.00          | 2514.0       |
| Spring Boot (AOT)   | HTTP 1.1   | 1               | 100       | 13        | 11    | 21    | 1.39        | 0.000%    | 2.01983          | 4.96              | 0.00          | 2514.0       |
| Spring Boot (AOT)   | HTTP 2     | 1               | 100       | 13        | 11    | 19    | 1.45        | 0.000%    | 2.01979          | 4.96              | 0.00          | 2514.0       |
| -------------       | ---------- | --------------- | --------- | --------- | ----- | ----- | ----------- | --------- | ---------------- | ----------------- | ------------- | ------------ |
| Ballerina (AOT)     | HTTP 1.1   | 2               | 500       | 13        | 10    | 20    | 1.59        | 0.000%    | 5.00962          | 12.85             | 0.00          | 2627.0       |
| Ballerina (AOT)     | HTTP 2     | 2               | 500       | 11        | 10    | 18    | 1.11        | 0.000%    | 5.00942          | 12.85             | 0.00          | 2627.0       |
| Ballerina           | HTTP 1.1   | 2               | 500       | 12        | 10    | 26    | 1.55        | 0.000%    | 5.00972          | 12.85             | 0.00          | 2627.0       |
| Ballerina           | HTTP 2     | 2               | 500       | 11        | 10    | 18    | 0.92        | 0.000%    | 5.00937          | 12.85             | 0.00          | 2627.0       |
| Spring Boot         | HTTP 1.1   | 2               | 500       | 11        | 10    | 21    | 1.32        | 0.000%    | 5.00947          | 12.30             | 0.00          | 2514.0       |
| Spring Boot         | HTTP 2     | 2               | 500       | 12        | 10    | 17    | 0.92        | 0.000%    | 5.00937          | 12.30             | 0.00          | 2514.0       |
| Spring Boot (AOT)   | HTTP 1.1   | 2               | 500       | 14        | 11    | 48    | 4.28        | 0.000%    | 5.00912          | 12.30             | 0.00          | 2514.0       |
| Spring Boot (AOT)   | HTTP 2     | 2               | 500       | 14        | 12    | 23    | 1.57        | 0.000%    | 5.00932          | 12.30             | 0.00          | 2514.0       |

#### 4 - API Gateway - Spring boot (AOT)

| User MCS Technology | Protocol   | Configuration   | Samples | Average | Min | Max | Std. Dev. | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) | Avg. Bytes |
|---------------------|------------|-----------------|---------|---------|-----|-----|-----------|-----------|------------------|-------------------|---------------|------------|
| Ballerina (AOT)     | HTTP 1.1   | 1               | 100     | 13      | 10  | 18  | 1.34      | 0.000%    | 2.01943          | 5.18              | 0.00          | 2627.0     |
| Ballerina (AOT)     | HTTP 2     | 1               | 100     | 13      | 11  | 20  | 1.66      | 0.000%    | 2.02016          | 5.18              | 0.00          | 2627.0     |
| Ballerina           | HTTP 1.1   | 1               | 100     | 17      | 13  | 31  | 3.14      | 0.000%    | 2.01959          | 5.18              | 0.00          | 2627.0     |
| Ballerina           | HTTP 2     | 1               | 100     | 14      | 12  | 18  | 1.36      | 0.000%    | 2.01983          | 5.18              | 0.00          | 2627.0     |
| Spring Boot         | HTTP 1.1   | 1               | 100     | 13      | 12  | 24  | 2.43      | 0.000%    | 2.02028          | 4.96              | 0.00          | 2514.0     |
| Spring Boot         | HTTP 2     | 1               | 100     | 13      | 11  | 23  | 1.60      | 0.000%    | 2.01963          | 4.96              | 0.00          | 2514.0     |
| Spring Boot (AOT)   | HTTP 1.1   | 1               | 100     | 14      | 12  | 20  | 1.48      | 0.000%    | 2.01947          | 4.96              | 0.00          | 2514.0     |
| Spring Boot (AOT)   | HTTP 2     | 1               | 100     | 14      | 12  | 23  | 1.68      | 0.000%    | 2.02020          | 4.96              | 0.00          | 2514.0     |
| -------------       | ---------- | --------------- | ------- | ------- | --- | --- | --------- | --------- | ---------------- | ----------------- | ------------- | ---------- |
| Ballerina (AOT)     | HTTP 1.1   | 2               | 500     | 12      | 10  | 21  | 1.35      | 0.000%    | 5.00962          | 12.85             | 0.00          | 2627.0     |
| Ballerina (AOT)     | HTTP 2     | 2               | 500     | 12      | 10  | 18  | 1.51      | 0.000%    | 5.00932          | 12.85             | 0.00          | 2627.0     |
| Ballerina           | HTTP 1.1   | 2               | 500     | 13      | 10  | 33  | 1.87      | 0.000%    | 5.01007          | 12.85             | 0.00          | 2627.0     |
| Ballerina           | HTTP 2     | 2               | 500     | 12      | 10  | 27  | 1.64      | 0.000%    | 5.00947          | 12.85             | 0.00          | 2627.0     |
| Spring Boot         | HTTP 1.1   | 2               | 500     | 13      | 11  | 31  | 2.71      | 0.000%    | 5.00947          | 12.30             | 0.00          | 2514.0     |
| Spring Boot         | HTTP 2     | 2               | 500     | 12      | 10  | 25  | 2.37      | 0.000%    | 5.01002          | 12.30             | 0.00          | 2514.0     |
| Spring Boot (AOT)   | HTTP 1.1   | 2               | 500     | 14      | 11  | 32  | 2.93      | 0.000%    | 5.00962          | 12.30             | 0.00          | 2514.0     |
| Spring Boot (AOT)   | HTTP 2     | 2               | 500     | 14      | 11  | 32  | 1.84      | 0.000%    | 5.00912          | 12.30             | 0.00          | 2514.0     |

### System Stress Test requests (~10% error rate)

For this test, the number of threads was increased as many as possible to simulate a stress test.

| Technology        | Protocol | Samples | Average | Min | Max | Std. Dev. | Error (%) | Throughput (sec) | Received (KB/sec) | Sent (KB/sec) | Avg. Bytes |
|-------------------|----------|---------|---------|-----|-----|-----------|-----------|------------------|-------------------|---------------|------------|
| Ballerina (AOT)   | HTTP 1.1 | 5900    | 39      | 3   | 307 | 39.49     | 7.695     | 124.64087        | 298.75            | 0.00          | 2454.4     |
| Ballerina (AOT)   | HTTP 2   | 5900    | 38      | 3   | 290 | 38.06     | 7.915     | 124.97352        | 294.73            | 0.00          | 2415.0     |
| Ballerina         | HTTP 1.1 | 2915    | 31      | 3   | 412 | 31.13     | 8.199     | 58.83065         | 141.03            | 0.00          | 2454.8     |
| Ballerina         | HTTP 2   | 2915    | 31      | 5   | 370 | 30.20     | 8.096     | 58.83778         | 138.77            | 0.00          | 2415.2     |
| Spring Boot       | HTTP 1.1 | 2915    | 27      | 4   | 248 | 21.40     | 8.096     | 58.62714         | 144.01            | 0.00          | 2515.4     |
| Spring Boot       | HTTP 2   | 2915    | 27      | 4   | 246 | 21.62     | 8.027     | 58.81997         | 144.49            | 0.00          | 2515.4     |
| Spring Boot (AOT) | HTTP 1.1 | 5900    | 28      | 3   | 301 | 35.10     | 7.705     | 124.58124        | 295.23            | 0.00          | 2515.4     |
| Spring Boot (AOT) | HTTP 2   | 5900    | 28      | 3   | 295 | 33.61     | 7.695     | 124.60245        | 294.96            | 0.00          | 2515.0     |

### System Sample request overview

| Technology        | Protocol | Load Time | Connect Time | Latency | Sizes in bytes | Sent bytes | Headers size in bytes | Body size in bytes |
|-------------------|----------|-----------|--------------|---------|----------------|------------|-----------------------|--------------------|
| Ballerina (AOT)   | HTTP 1.1 | 27        | 2            | 28      | 2448           | 0          | 235                   | 2213               |
| Ballerina (AOT)   | HTTP 2   | 27        | 1            | 28      | 2405           | 0          | 192                   | 2213               |
| Ballerina         | HTTP 1.1 | 31        | 1            | 31      | 2448           | 0          | 235                   | 2213               |
| Ballerina         | HTTP 2   | 29        | 1            | 30      | 2405           | 0          | 192                   | 2213               |
| Spring Boot       | HTTP 1.1 | 29        | 1            | 30      | 2514           | 0          | 387                   | 2127               |
| Spring Boot       | HTTP 2   | 26        | 2            | 26      | 2514           | 0          | 387                   | 2127               |
| Spring Boot (AOT) | HTTP 2   | 26        | 2            | 26      | 2514           | 0          | 387                   | 2127               |
| Spring Boot (AOT) | HTTP 2   | 26        | 2            | 26      | 2514           | 0          | 387                   | 2127               |

### Startup times:
Each technology was tested 10 times and bellows are the average startup times.

#### API Gateway
| Technology        | Average Startup Time |
|-------------------|----------------------|
| Ballerina (AOT)   | ~0.066               |
| Ballerina         | ~0.635               |
| Spring Boot       | ~1.408               |
| Spring Boot (AOT) | ~0.088               |

#### User Microservice
| Technology        | Average Startup Time |
|-------------------|----------------------|
| Ballerina (AOT)   | ~0.081 s             |
| Ballerina         | ~0.818 s             |
| Spring Boot       | ~3.015 s             |
| Spring Boot (AOT) | ~0.228 s             |

# Results Analysis
## General Performance
This analysis compares important metrics like response time, throughput, error rate, and data transfer rates across various configurations and technologies.

- **Average Response Time**: Both Ballerina and Spring Boot showed similar response times, with Spring slightly faster in some cases.
- **Throughput**: The throughput was consistent with different configurations, and both technologies handled a similar number of requests per second.
- **Error Rate**: Both technologies have sustained a low error rate, demonstrating stable and reliable performance under the test conditions.
- **Data Transfer Rates**: The data transfer rates were consistent across the board, with minor variations between the two technologies.

Overall, both Ballerina and Spring Boot delivered strong performance, effectively handling the test conditions.

## Startup times
- **Ballerina**: Ballerina is renowned for its lightweight nature, specifically its quick startup times. With AOT compilation, Ballerina demonstrates an impressive mean time of 66ms to launch the API Gateway application, making it ideal for microservices and any environment that demands a rapid deployment.
- **Spring Boot (AOT)**: The Ahead-of-Time compilation in Spring Boot has substantially improved startup times compared to traditional compilation, bringing it much closer to Ballerina's times. While Spring Boot has not quite surpassed the average startup time of Ballerina AOT, the time difference between traditional and AOT compilation is greater than that of Ballerina, leaving no doubt that AOT compilation significantly enhances startup times.

## Stress Test
Under stress testing conditions, both technologies were pushed to their limits to evaluate their performance under heavy load.
Both technologies had similar performance in traditional and AOT compilation. AOT compilation allows applications to handle more requests due to performance optimizations such as unused code elimination, heap snapshotting, and static code initializations [Ballerina Team](https://ballerina.io/learn/graalvm-executable-overview/).

## Http 1.1 vs Http 2.0
The differences between HTTP 1.1 and HTTP 2.0 are minimal, and both protocols show similar performance, with HTTP 2.0 
having a slight advantage in some cases. This indicates that the choice of HTTP protocol may not be a significant factor
in overall performance for this specific test setup.

## Conclusion
Both Ballerina and Spring Boot (with AOT compilation) are capable of delivering high performance and reliability under various test conditions. 
Ballerina's lightweight nature and quick startup times make it an excellent choice for microservices and cloud-native applications. 
Spring Boot, with AOT compilation, has significantly improved its startup times, making it a strong contender for enterprise applications and systems requiring extensive Spring ecosystem support.

## Technology analysis

- **Ballerina**:
  - **Strengths**: Quick startup times, consistent performance, low resource consumption.
  - **Weaknesses**: Minor differences in performance metrics compared to Spring Boot in specific scenarios.

- **Spring Boot**:
  - **Strengths**: Improved startup times with AOT, robust performance under stress, well-established ecosystem.
  - **Weaknesses**: Slightly higher resource consumption and response times compared to Ballerina in some scenarios.

Both Ballerina and Spring Boot are suitable for different purposes and can be chosen based on specific project needs and environments. The decision between the two technologies will depend on the application's specific requirements and the infrastructure it operates within.