#!/bin/bash
# 🛡️🍄 Mario Safety Guardian - Advanced Security & Development Safety System 🍄🛡️
# Professional security validation using proper Claude Code JSON hook protocol
# Blocks dangerous operations with Mario character personality and detailed analysis

# Security and error handling
set -euo pipefail

# Constants
readonly SAFETY_LOG_DIR="$HOME/.claude/safety-analysis"
readonly SAFETY_LOG_FILE="$SAFETY_LOG_DIR/security-log.jsonl"  # JSONL format for better parsing
readonly BLOCKED_COMMANDS_FILE="$SAFETY_LOG_DIR/blocked-commands.txt"
readonly RISK_PATTERNS_FILE="$SAFETY_LOG_DIR/risk-patterns.json"

# Risk level definitions
declare -A RISK_COLORS=(
    ["CRITICAL"]="🚨"
    ["HIGH"]="⚠️"
    ["MEDIUM"]="⚡"
    ["LOW"]="ℹ️"
    ["INFO"]="✅"
)

# Mario character responses by risk level
declare -A MARIO_RESPONSES=(
    ["CRITICAL"]="🚨 MARIO SAYS: 'MAMMA MIA! That's-a VERY dangerous! I can't-a let you do that!'"
    ["HIGH"]="⚠️ MARIO SAYS: 'Wahoo! Let's-a think about this first! That could be risky!'"
    ["MEDIUM"]="⚡ MARIO SAYS: 'Careful there, friend! Mario wants to keep you safe!'"
    ["LOW"]="✅ MARIO SAYS: 'That looks-a good to me! Go for it!'"
    ["INFO"]="🍄 MARIO SAYS: 'Nice work! You're using the tools like a pro!'"
)

# Critical risk patterns that should be blocked
declare -a CRITICAL_PATTERNS=(
    "rm -rf /"
    "sudo.*rm.*-rf.*/"
    "mkfs\."
    "dd.*if=/dev/zero"
    "dd.*if=/dev/urandom" 
    "format.*C:"
    "del.*C:\\\\Windows"
    ">.*passwd"
    "chmod.*777.*/"
    "chown.*root.*/"
    "sudo.*shutdown"
    "sudo.*halt"
    "sudo.*reboot"
    "init.*0"
    ":(){ :|:& };:"  # Fork bomb
    "curl.*\|.*sh"
    "wget.*\|.*bash"
    "eval.*\$\("
)

# High risk patterns that need warnings
declare -a HIGH_RISK_PATTERNS=(
    "git.*push.*--force"
    "git.*reset.*--hard.*HEAD"
    "npm.*publish"
    "pypi.*upload"
    "docker.*push"
    "kubectl.*delete"
    "terraform.*destroy"
    "aws.*delete"
    "gcloud.*delete"
    "find.*-delete"
    "truncate.*-s.*0"
    "shred.*-"
)

# Medium risk patterns
declare -a MEDIUM_RISK_PATTERNS=(
    "rm.*-r"
    "mv.*/"
    "cp.*-r.*/"
    "tar.*-"
    "zip.*-r"
    "chmod.*-R"
    "chown.*-R"
    "git.*reset"
    "git.*checkout.*--"
)

# Utility functions
create_safety_dirs() {
    if [[ ! -d "$SAFETY_LOG_DIR" ]]; then
        mkdir -p "$SAFETY_LOG_DIR"
        chmod 700 "$SAFETY_LOG_DIR"
        touch "$SAFETY_LOG_FILE" "$BLOCKED_COMMANDS_FILE"
        
        # Initialize risk patterns file
        cat > "$RISK_PATTERNS_FILE" << 'EOF'
{
  "version": "1.0",
  "last_updated": "2024-01-01",
  "patterns": {
    "critical": [],
    "high": [],
    "medium": [],
    "custom": []
  }
}
EOF
    fi
}

log_security_event() {
    local risk_level="$1"
    local tool_name="$2"
    local command_hash="$3"
    local decision="$4"
    local reason="$5"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    # Create structured JSON log entry
    local log_entry
    log_entry=$(python3 << EOF
import json
import sys

log_entry = {
    "timestamp": "$timestamp",
    "risk_level": "$risk_level",
    "tool_name": "$tool_name", 
    "command_hash": "$command_hash",
    "decision": "$decision",
    "reason": "$reason",
    "mario_response": "${MARIO_RESPONSES[$risk_level]:-Unknown response}",
    "hook_version": "2.0"
}

print(json.dumps(log_entry))
EOF
)
    
    echo "$log_entry" >> "$SAFETY_LOG_FILE"
}

generate_command_hash() {
    local command="$1"
    echo "$command" | sha256sum | cut -d' ' -f1 | cut -c1-12  # First 12 chars of SHA256
}

validate_file_path() {
    local file_path="$1"
    local risk_level="LOW"
    local warnings=()
    
    # Path traversal detection
    if [[ "$file_path" =~ \.\./|\.\./.*|\.\.\\ ]]; then
        risk_level="CRITICAL"
        warnings+=("Path traversal attempt detected")
    fi
    
    # Sensitive file detection
    case "$file_path" in
        *.env|*.key|*.pem|*.p12|*.pfx)
            risk_level="HIGH"
            warnings+=("Sensitive file type detected")
            ;;
        */etc/passwd|*/etc/shadow|*/etc/hosts)
            risk_level="CRITICAL"
            warnings+=("System configuration file access")
            ;;
        */.ssh/*|*/.gnupg/*)
            risk_level="HIGH"
            warnings+=("Security credential directory access")
            ;;
        */node_modules/*|*/vendor/*|*/.git/*)
            risk_level="INFO"
            warnings+=("Package/version control directory access")
            ;;
    esac
    
    echo "$risk_level"
    printf '%s\n' "${warnings[@]}"
}

analyze_command_risk() {
    local command="$1"
    local risk_level="LOW"
    local risk_reasons=()
    
    # Check critical patterns (should be blocked)
    for pattern in "${CRITICAL_PATTERNS[@]}"; do
        if [[ "$command" =~ $pattern ]]; then
            risk_level="CRITICAL"
            risk_reasons+=("Critical system operation: matches pattern '$pattern'")
            break  # Stop at first critical match
        fi
    done
    
    # Check high risk patterns (if not already critical)
    if [[ "$risk_level" != "CRITICAL" ]]; then
        for pattern in "${HIGH_RISK_PATTERNS[@]}"; do
            if [[ "$command" =~ $pattern ]]; then
                risk_level="HIGH"
                risk_reasons+=("High risk operation: matches pattern '$pattern'")
            fi
        done
    fi
    
    # Check medium risk patterns (if not already higher risk)
    if [[ "$risk_level" == "LOW" ]]; then
        for pattern in "${MEDIUM_RISK_PATTERNS[@]}"; do
            if [[ "$command" =~ $pattern ]]; then
                risk_level="MEDIUM" 
                risk_reasons+=("Medium risk operation: matches pattern '$pattern'")
            fi
        done
    fi
    
    # Additional context-based analysis
    if [[ "$command" =~ sudo && "$risk_level" == "LOW" ]]; then
        risk_level="MEDIUM"
        risk_reasons+=("Elevated privileges requested")
    fi
    
    echo "$risk_level"
    printf '%s\n' "${risk_reasons[@]}"
}

create_json_response() {
    local decision="$1"
    local risk_level="$2"
    local reason="$3"
    
    python3 << EOF
import json

response = {
    "hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "permissionDecision": "$decision",
        "permissionDecisionReason": "$reason"
    },
    "suppressOutput": False
}

print(json.dumps(response, indent=2))
EOF
}

generate_security_advice() {
    local tool_name="$1"
    local risk_level="$2"
    local command="$3"
    
    echo ""
    echo "🎯 MARIO'S SECURITY GUIDANCE:"
    
    case "$risk_level" in
        "CRITICAL")
            echo "🚨 This operation could cause IRREVERSIBLE system damage!"
            echo "💡 Recommended: Test in isolated environment first"
            echo "🛡️  Best Practice: Always have verified backups before risky operations"
            echo "👑 Mario's Wisdom: 'Even Bowser respects the power of system commands!'"
            ;;
        "HIGH")
            echo "⚠️  This operation affects shared resources or production systems"
            echo "👥 Team Impact: Consider how this affects other developers"
            echo "🧪 Testing: Verify in staging environment first"
            echo "🍄 Mario's Tip: 'Great power requires great responsibility!'"
            ;;
        "MEDIUM")
            echo "⚡ This operation modifies files or system state"
            echo "📋 Checklist: Ensure you have backups of affected data"
            echo "🔄 Recovery: Verify you can restore if something goes wrong"
            echo "👸 Princess Peach says: 'Elegant solutions include recovery plans!'"
            ;;
        "LOW"|"INFO")
            echo "✅ Standard development operation - looks safe!"
            echo "🎮 Good Practice: Using tools professionally"
            echo "🌟 Keep it up: You're developing safely!"
            ;;
    esac
    
    # Tool-specific advice
    case "$tool_name" in
        "Write"|"Edit"|"MultiEdit")
            echo "📝 Code Quality Tip: Consider adding tests for new functionality"
            echo "🧪 Testing: Validate your changes before committing"
            ;;
        "Bash")
            if [[ "$command" =~ npm.*install|pip.*install|cargo.*install ]]; then
                echo "📦 Dependency Security: Verify package sources and check for vulnerabilities"
                echo "🔒 Captain Toad's Adventure Tip: 'Great tools come from trusted sources!'"
            fi
            ;;
    esac
}

parse_json_input() {
    local json_input="$1"
    
    python3 << EOF
import json, sys
try:
    data = json.loads('''$json_input''')
    
    # Extract relevant data  
    tool_name = data.get('tool_name', '')
    hook_event = data.get('hook_event_name', '')
    
    # Extract tool input safely
    tool_input = data.get('tool_input', {})
    command = ''
    file_path = ''
    
    if isinstance(tool_input, dict):
        command = tool_input.get('command', '')
        file_path = tool_input.get('file_path', tool_input.get('filePath', ''))
    
    # Output parsed data as environment variables
    print(f"export PARSED_TOOL_NAME='{tool_name}'")
    print(f"export PARSED_HOOK_EVENT='{hook_event}'") 
    print(f"export PARSED_COMMAND='{command}'")
    print(f"export PARSED_FILE_PATH='{file_path}'")
    
except Exception as e:
    print(f"# JSON parsing error: {str(e)}", file=sys.stderr)
    print("export PARSED_TOOL_NAME='unknown'")
    print("export PARSED_HOOK_EVENT='unknown'")
    print("export PARSED_COMMAND=''")
    print("export PARSED_FILE_PATH=''")
    sys.exit(1)
EOF
}

# Main security analysis function
main() {
    local input_data
    input_data=$(cat)
    
    # Initialize security system
    create_safety_dirs
    
    # Parse JSON input using official Claude Code format
    if ! eval "$(parse_json_input "$input_data")"; then
        echo "❌ Error parsing security hook input" >&2
        exit 1
    fi
    
    # Only process PreToolUse events
    if [[ "$PARSED_HOOK_EVENT" != "PreToolUse" ]]; then
        exit 0  # Silently ignore non-PreToolUse events
    fi
    
    # Analyze the operation for security risks
    local risk_level="LOW"
    local risk_reasons=()
    local command_hash=""
    local decision="allow"
    
    # Generate command hash for logging
    if [[ -n "$PARSED_COMMAND" ]]; then
        command_hash=$(generate_command_hash "$PARSED_COMMAND")
    fi
    
    # Analyze Bash commands for security risks
    if [[ "$PARSED_TOOL_NAME" == "Bash" ]] && [[ -n "$PARSED_COMMAND" ]]; then
        readarray -t analysis_result < <(analyze_command_risk "$PARSED_COMMAND")
        risk_level="${analysis_result[0]}"
        risk_reasons=("${analysis_result[@]:1}")
        
        # Decision logic based on risk level
        case "$risk_level" in
            "CRITICAL")
                decision="deny"
                echo "$PARSED_COMMAND" >> "$BLOCKED_COMMANDS_FILE"
                ;;
            "HIGH")
                decision="ask"  # Let user decide
                ;;
            *)
                decision="allow"
                ;;
        esac
        
    # Analyze file operations
    elif [[ "$PARSED_TOOL_NAME" =~ ^(Write|Edit|MultiEdit|Read)$ ]] && [[ -n "$PARSED_FILE_PATH" ]]; then
        readarray -t file_analysis < <(validate_file_path "$PARSED_FILE_PATH")
        risk_level="${file_analysis[0]}"
        risk_reasons=("${file_analysis[@]:1}")
        
        case "$risk_level" in
            "CRITICAL")
                decision="deny"
                ;;
            "HIGH")
                decision="ask"
                ;;
            *)
                decision="allow"
                ;;
        esac
    fi
    
    # Create reason string for logging and response
    local combined_reason="${MARIO_RESPONSES[$risk_level]}"
    if [[ ${#risk_reasons[@]} -gt 0 ]]; then
        combined_reason="$combined_reason | $(IFS='; '; echo "${risk_reasons[*]}")"
    fi
    
    # Log the security event
    log_security_event "$risk_level" "$PARSED_TOOL_NAME" "$command_hash" "$decision" "$combined_reason"
    
    # Generate response based on decision
    case "$decision" in
        "deny")
            # Block the operation with JSON response
            create_json_response "deny" "$risk_level" "$combined_reason"
            generate_security_advice "$PARSED_TOOL_NAME" "$risk_level" "$PARSED_COMMAND"
            ;;
        "ask")
            # Ask user for confirmation
            create_json_response "ask" "$risk_level" "$combined_reason" 
            generate_security_advice "$PARSED_TOOL_NAME" "$risk_level" "$PARSED_COMMAND"
            ;;
        *)
            # Allow operation (but still provide helpful guidance)
            if [[ "$risk_level" != "INFO" && "$risk_level" != "LOW" ]]; then
                generate_security_advice "$PARSED_TOOL_NAME" "$risk_level" "$PARSED_COMMAND"
            else
                echo "${MARIO_RESPONSES[$risk_level]}"
            fi
            ;;
    esac
}

# Execute main function with error handling
main "$@"