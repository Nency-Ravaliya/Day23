#1. System Performance Monitoring Script

## Overview

Maintaining optimal system performance is critical for ensuring smooth operation and preventing downtime. Regular monitoring of system metrics such as disk usage, memory usage, and CPU load helps in identifying potential issues before they become critical. This script automates the process of checking these key system performance metrics, logging the results, and providing basic error handling.

## Problem Statement

System administrators and IT professionals need reliable tools to monitor the performance of their systems. Manual checks can be time-consuming and error-prone. Automated scripts can provide timely insights into system health and resource usage. This script addresses the need for:
- **Disk Usage Monitoring**: To track how much disk space is being used and identify potential storage issues.
- **Memory Usage Monitoring**: To ensure that sufficient memory is available for applications and services.
- **CPU Load Monitoring**: To assess the CPU load and detect performance bottlenecks.

By automating these checks, the script helps in proactive system management, enabling faster response to performance issues.

## Script

```bash
chmod +x system_check.sh
sudo ./system_check.sh

#2 Log Management Script

## Overview

Effective log management is essential for maintaining system performance and ensuring that logs do not consume excessive storage space. Automated log management helps in rotating, compressing, and archiving logs, thereby improving system efficiency and facilitating long-term data storage. This script automates these tasks to keep log files manageable and organized.

## Problem Statement

Logs are crucial for monitoring and troubleshooting system and application issues. However, logs can quickly grow in size, consuming valuable disk space and potentially leading to system performance issues. Manually managing logs can be time-consuming and prone to errors. Automated log management addresses these challenges by:
- **Log Rotation**: Regularly rotating logs to prevent them from becoming too large, which helps in maintaining manageable log sizes.
- **Log Compression**: Compressing old logs to save disk space while preserving log data for future reference.
- **Log Deletion**: Removing logs that are older than a specified number of days to prevent disk space from being exhausted.

The script provides a solution for automating these log management tasks, ensuring that logs are handled efficiently and that storage space is optimized.

## Script

```bash
chmod +x log_manage.sh
sudo ./log_manage.sh

#3 Advanced Shell Scripting - Loops, Conditions, Functions, and Error Handling

## Overview

Effective shell scripting requires modularity, error handling, and the ability to manage complex tasks efficiently. This script demonstrates advanced shell scripting techniques by refactoring basic operations into a modular format with functions, loops, and conditionals. It includes robust error handling to address potential issues such as missing files or insufficient permissions, and provides logging to track script execution and errors.

## Problem Statement

Basic shell scripts often handle straightforward tasks but can become cumbersome and error-prone as complexity increases. Refactoring scripts to include:
- **Functions**: To modularize code and reuse it for repeatable tasks.
- **Loops and Conditions**: To handle multiple items and make decisions based on conditions.
- **Error Handling**: To manage scenarios like missing files or permissions issues gracefully.
- **Logging**: To track the script’s execution and diagnose errors.

By implementing these features, the script becomes more flexible, maintainable, and reliable.

## Script

```bash
chmod +x logs_error_handling.sh
sudo ./logs_error_handling.sh

#4 Log Checking and Troubleshooting Script

## Overview

Logs are crucial for diagnosing system and application issues. Regularly analyzing logs helps in identifying common problems such as memory issues or failed service starts. This script automates the process of reading through system and application logs, detecting errors or warnings, and providing troubleshooting steps based on the log analysis.

## Problem Statement

System administrators and developers need efficient tools to parse logs and diagnose issues quickly. Manually reviewing logs can be labor-intensive and may lead to missed errors. Automated log checking helps by:
- **Parsing Logs**: Efficiently reading and analyzing large log files.
- **Identifying Issues**: Detecting common problems such as out-of-memory errors or failed service starts.
- **Providing Troubleshooting Steps**: Offering actionable steps based on identified issues to facilitate quick resolution.

The script addresses these needs by providing automated log analysis and troubleshooting guidance.

## Script

```bash
chmod +x troubleshooting_logs.sh
./troubleshooting_logs.sh






