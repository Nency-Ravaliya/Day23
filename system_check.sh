#!/bin/bash

# Define log file location
LOGFILE="/var/log/system_monitor.log"

# Function to check disk usage
check_disk_usage() {
    echo "Checking disk usage..." | tee -a $LOGFILE
    df -h | tee -a $LOGFILE
    if [ $? -ne 0 ]; then
        echo "Error checking disk usage" | tee -a $LOGFILE
    else
        echo "Disk usage check completed successfully" | tee -a $LOGFILE
    fi
}

# Function to check memory usage
check_memory_usage() {
    echo "Checking memory usage..." | tee -a $LOGFILE
    free -h | tee -a $LOGFILE
    if [ $? -ne 0 ]; then
        echo "Error checking memory usage" | tee -a $LOGFILE
    else
        echo "Memory usage check completed successfully" | tee -a $LOGFILE
    fi
}

# Function to check CPU load
check_cpu_load() {
    echo "Checking CPU load..." | tee -a $LOGFILE
    top -bn1 | grep "Cpu(s)" | tee -a $LOGFILE
    if [ $? -ne 0 ]; then
        echo "Error checking CPU load" | tee -a $LOGFILE
    else
        echo "CPU load check completed successfully" | tee -a $LOGFILE
    fi
}

# Create log file if it does not exist
if [ ! -f $LOGFILE ]; then
    touch $LOGFILE
fi

# Run all checks
check_disk_usage
check_memory_usage
check_cpu_load

echo "System monitoring completed." | tee -a $LOGFILE
