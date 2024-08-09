#!/bin/bash

# Configuration
SYSTEM_LOGS="/var/log/syslog"      # Path to the system log file
APPLICATION_LOGS="/var/log" # Path to the application log file
REPORT_FILE="log_troubleshooting_report.log" # File to log the report
DATE=$(date +"%Y-%m-%d %H:%M:%S")

# Initialize or create report file
initialize_report() {
    echo "Log Checking and Troubleshooting Report - $DATE" > $REPORT_FILE
    echo "-------------------------------------------------" >> $REPORT_FILE
    echo "Types of Logs Checked:" >> $REPORT_FILE
    echo "- System Logs: $SYSTEM_LOGS" >> $REPORT_FILE
    echo "- Application Logs: $APPLICATION_LOGS" >> $REPORT_FILE
    echo "" >> $REPORT_FILE
}

# Log messages
log_message() {
    local level=$1
    local message=$2
    echo "[$level] $DATE - $message" >> $REPORT_FILE
}

# Check system logs for common issues
check_system_logs() {
    log_message "INFO" "Checking system logs for common issues..."

    # Check for out-of-memory errors
    grep -i "out of memory" $SYSTEM_LOGS >> $REPORT_FILE
    if [ $? -eq 0 ]; then
        log_message "WARNING" "Out of memory errors found in system logs."
        echo "Possible causes:" >> $REPORT_FILE
        echo "- Insufficient RAM or swap space." >> $REPORT_FILE
        echo "- Memory leaks in applications." >> $REPORT_FILE
        echo "- Heavy processes consuming too much memory." >> $REPORT_FILE
        echo "" >> $REPORT_FILE
    fi

    # Check for failed service starts
    grep -i "failed to start" $SYSTEM_LOGS >> $REPORT_FILE
    if [ $? -eq 0 ]; then
        log_message "WARNING" "Failed service starts found in system logs."
        echo "Possible causes:" >> $REPORT_FILE
        echo "- Incorrect service configuration." >> $REPORT_FILE
        echo "- Missing dependencies or incorrect permissions." >> $REPORT_FILE
        echo "- Service not installed or not available." >> $REPORT_FILE
        echo "" >> $REPORT_FILE
    fi
}

# Check application logs for common issues
check_application_logs() {
    log_message "INFO" "Checking application logs for common issues..."

    # Check for application errors
    grep -i "error" $APPLICATION_LOGS >> $REPORT_FILE
    if [ $? -eq 0 ]; then
        log_message "WARNING" "Application errors found in application logs."
        echo "Possible causes:" >> $REPORT_FILE
        echo "- Application bugs or misconfigurations." >> $REPORT_FILE
        echo "- Issues with external services or APIs." >> $REPORT_FILE
        echo "- Resource limits or permissions issues." >> $REPORT_FILE
        echo "" >> $REPORT_FILE
    fi

    # Check for application warnings
    grep -i "warning" $APPLICATION_LOGS >> $REPORT_FILE
    if [ $? -eq 0 ]; then
        log_message "INFO" "Application warnings found in application logs."
        echo "Possible causes:" >> $REPORT_FILE
        echo "- Potential issues that could escalate into errors." >> $REPORT_FILE
        echo "- Suboptimal configurations or usage patterns." >> $REPORT_FILE
        echo "- External dependencies or temporary issues." >> $REPORT_FILE
        echo "" >> $REPORT_FILE
    fi
}

# Execute the log checking functions
initialize_report
check_system_logs
check_application_logs

log_message "INFO" "Log checking and troubleshooting completed."
