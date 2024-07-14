import http from 'k6/http';
import { sleep, check, fail } from 'k6';
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";
import { test } from 'k6/execution';

export const options = {
  summaryTrendStats: [
    "avg",
    "min",
    "med",
    "max",
    "p(50)",
    "p(90)",
    "p(95)",
    "p(99)",
    "p(99.99)",
    "count",
  ],
  summaryTimeUnit: "ms",
  insecureSkipTLSVerify: true,
  stages: Array.from({ length: 100 }, (_, i) => ({ duration: '1s', target: (i + 1) * 100 })),
};

export default function() {
  const isHttp2 = true;
  let authToken = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxIiwicm9sZSI6IlNVUEVSVklTT1IiLCJleHAiOjE3MjA4MzEwNDR9.QomuOOUeX3xucUuEDzNnbrLsGSfMjLh7HNxEBI0Zyx4';
  let checkResult;
  let res;
  let headers = {
    'Authorization': authToken,
  };

  if(isHttp2) {
    res = http.get('https://localhost:9090/users/getAllUsers', { headers: headers });

    checkResult = check(res, {
      'status is 200': (r) => r.status === 200,
      'protocol is HTTP/2': (r) => r.proto === 'HTTP/2.0',
    });

  } else {
    res = http.get('http://localhost:9090/users/getAllUsers', { headers: headers });

    checkResult = check(res, {
      'status is 200': (r) => r.status === 200,
      'protocol is HTTP/1': (r) => r.proto === 'HTTP/1.1',
    });
  }

  // If the check fails, log an error and fail the test
  if (!checkResult) {
    console.error(`Request failed. Status: ${res.status}, Protocol: ${res.proto}`);
    test.abort('Test aborted due to non-200 response.', 1); // Using 1 as the exit code for error
  }

  sleep(1);
}

export function handleSummary(data) {
  const requests = data.metrics.http_reqs.count;
  const duration = data.metrics.iteration_duration.sum / 1000; // Convert to seconds
  const throughput = requests / duration;

  // Add the throughput metric to the data
  data.throughput = throughput;

  return {
    "results/stressTest.html": htmlReport(data),
    stdout: `Throughput: ${throughput} requests/sec`,
  };
}