Here’s a clean and concise Markdown version of your E2E test pipeline documentation. You can easily convert this to Word using any Markdown editor or copy-paste into Word with minimal formatting tweaks.

⸻

End-to-End Integration Test Pipeline Documentation

Objective

This pipeline automates the validation of data flow between upstream and downstream systems using Cucumber tests triggered by GitLab CI. It ensures the integrity of stock files, Kafka message handling, and final database updates.

⸻

Pipeline Stages Overview

1. Trigger & Initial Setup
	•	GitLab CI triggers pipeline on new commit or merge.
	•	Sonar Scan runs to check code quality.
	•	E2E Test Suite is initiated.

⸻

2. Health Checks
	•	Perform health checks for:
	•	LIR system
	•	Feeder system

⸻

3. Stock File Processing
	•	Manually upload stock files to S3 bucket before test.
	•	Push uploaded stock files to CLS S3 path.

⸻

4. File Verification & Kafka Flow
	•	Check if file is received by the Feeder.
	•	Simulate real-world flow:
	•	Verify file presence in MMT, CVT, and DS buckets.
	•	Publish Kafka messages to respective topics:
	•	MMT Kafka
	•	CVT Kafka
	•	DS Kafka

⸻

5. Feeder Validation
	•	Feeder listens to Kafka topics.
	•	Validates and aggregates data.
	•	Updates Feeder database.

⸻

6. Reporting
	•	Generate test results via Allure Reports.
	•	Report URL is generated and available in job console.

⸻

7. Cleanup
	•	Delete test data from the database.
	•	Delete reports older than 10 days from storage.

⸻

Notes
	•	Manual Step: User must upload correct stock files to S3 before execution.
	•	All data interactions (Kafka messages, DB updates) are done using real systems, no mocks.
