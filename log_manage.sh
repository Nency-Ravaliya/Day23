#!/bin/bash

# Configuration
LOG_DIR="/var/log"                # Directory containing logs
ARCHIVE_DIR="/var/log/archive"    # Directory to store archived logs
REPORT_FILE="log_management_report.log" # File to log the report
RETENTION_DAYS=30                # Number of days to retain logs
MAX_LOG_SIZE_MB=100              # Maximum size of log files in MB before rotation
DATE=$(date +"%Y-%m-%d %H:%M:%S")

# Create log directories if they do not exist
mkdir -p $LOG_DIR
mkdir -p $ARCHIVE_DIR

# Initialize or create report file
initialize_report() {
    echo "Log Management Report - $DATE" > $REPORT_FILE
    echo "---------------------------------" >> $REPORT_FILE
}

# Log messages
log_message() {
    local level=$1
    local message=$2
    echo "[$level] $DATE - $message" >> $REPORT_FILE
}

# Function to check if a directory exists
check_directory() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        log_message "ERROR" "Directory $dir does not exist."
        exit 1
    fi
}

# Function to rotate log files
rotate_logs() {
    log_message "INFO" "Starting log rotation..."
    for log_file in $LOG_DIR/*.log; do
        if [ -f "$log_file" ]; then
            log_size_mb=$(du -m "$log_file" | cut -f1)
            if [ $log_size_mb -ge $MAX_LOG_SIZE_MB ]; then
                timestamp=$(date +"%Y%m%d_%H%M%S")
                archive_file="$ARCHIVE_DIR/$(basename $log_file)_$timestamp"
                if mv "$log_file" "$archive_file"; then
                    if gzip "$archive_file"; then
                        log_message "INFO" "Rotated and compressed: $(basename $log_file)"
                    else
                        log_message "ERROR" "Failed to compress $archive_file"
                    fi
                else
                    log_message "ERROR" "Failed to move $log_file to $archive_file"
                fi
            else
                log_message "INFO" "No rotation needed for: $(basename $log_file)"
            fi
        else
            log_message "INFO" "No log files found in $LOG_DIR"
        fi
    done
}

# Function to delete old logs
delete_old_logs() {
    log_message "INFO" "Starting old log deletion..."
    find $ARCHIVE_DIR -type f -name "*.gz" -mtime +$RETENTION_DAYS -exec rm {} \; -exec log_message "INFO" "Deleted old log: {}" \; 2>> $REPORT_FILE
    if [ $? -eq 0 ]; then
        log_message "INFO" "Old logs deletion completed."
    else
        log_message "ERROR" "Error occurred while deleting old logs."
    fi
}

# Check directories before proceeding
check_directory $LOG_DIR
check_directory $ARCHIVE_DIR

# Initialize the report file
initialize_report

# Run log management tasks
rotate_logs
delete_old_logs

log_message "INFO" "Log management completed."
