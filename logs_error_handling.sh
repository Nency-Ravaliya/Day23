#!/bin/bash

# Configuration
LOG_DIR="/var/log"                # Default directory containing logs
ARCHIVE_DIR="/var/log/archive"    # Directory to store archived logs
REPORT_FILE="logs_error_handling_report.log" # File to log the report
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

# Log error messages
log_error() {
    local message=$1
    echo "[ERROR] $DATE - $message" >> $REPORT_FILE
}

# Log info messages
log_info() {
    local message=$1
    echo "[INFO] $DATE - $message" >> $REPORT_FILE
}

# Function to check if a directory exists
check_directory() {
    local dir=$1
    if [ ! -d "$dir" ]; then
        log_error "Directory $dir does not exist."
        exit 1
    fi
}

# Function to check file size
check_file_size() {
    local file=$1
    du -m "$file" | cut -f1
}

# Function to rotate log files
rotate_logs() {
    log_info "Starting log rotation..."
    for log_file in $LOG_DIR/*.log; do
        if [ -f "$log_file" ]; then
            log_size_mb=$(check_file_size "$log_file")
            if [ $log_size_mb -ge $MAX_LOG_SIZE_MB ]; then
                timestamp=$(date +"%Y%m%d_%H%M%S")
                archive_file="$ARCHIVE_DIR/$(basename $log_file)_$timestamp"
                if mv "$log_file" "$archive_file"; then
                    if gzip "$archive_file"; then
                        log_info "Rotated and compressed: $(basename $log_file)"
                    else
                        log_error "Failed to compress $archive_file"
                    fi
                else
                    log_error "Failed to move $log_file to $archive_file"
                fi
            else
                log_info "No rotation needed for: $(basename $log_file)"
            fi
        else
            log_error "No log files found in $LOG_DIR"
        fi
    done
}

# Function to delete old logs
delete_old_logs() {
    log_info "Starting old log deletion..."
    if find $ARCHIVE_DIR -type f -name "*.gz" -mtime +$RETENTION_DAYS -exec rm {} \; -exec log_info "Deleted old log: {}" \; 2>> $REPORT_FILE; then
        log_info "Old logs deletion completed."
    else
        log_error "Error occurred while deleting old logs."
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

log_info "Log management completed."
