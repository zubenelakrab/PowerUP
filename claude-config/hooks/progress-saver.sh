#!/bin/bash
# 💾🍄 Mario Progress Saver - Session Persistence & Recovery System 🍄💾
# Advanced session state management using Claude Code Stop/PreCompact hook protocols
# Automatically saves progress and provides recovery options for interrupted sessions

# Security and error handling
set -euo pipefail

# Constants
readonly PROGRESS_DIR="$HOME/.claude/progress-saves"
readonly SESSION_SAVES_DIR="$PROGRESS_DIR/sessions"
readonly AUTO_SAVES_DIR="$PROGRESS_DIR/auto-saves"
readonly RECOVERY_LOG_FILE="$PROGRESS_DIR/recovery-log.jsonl"

# Achievement and context files
readonly ACHIEVEMENT_DIR="$HOME/.claude/achievements"
readonly CONTEXT_DIR="$HOME/.claude/context-analysis"

# Progress checkpoint data structure
readonly CHECKPOINT_VERSION="2.0"

# Mario character messages for different save scenarios
declare -A MARIO_SAVE_MESSAGES=(
    ["auto_save"]="💾 🍄 Mario's Auto-Save: Progress safely stored! Even Bowser can't steal your achievements!"
    ["manual_save"]="🎮 ⭐ Manual checkpoint saved! Just like hitting a checkpoint flag!"
    ["session_end"]="👋 🏰 Session ending - All your legendary progress is safely stored in the castle!"
    ["emergency_save"]="🚨 💚 Emergency save activated! Even during chaos, Mario protects your 1-UPs!"
    ["context_compact"]="🧠 ♻️ Context optimization - Mario's organizing your adventure memories efficiently!"
)

# Utility functions
create_progress_dirs() {
    for dir in "$PROGRESS_DIR" "$SESSION_SAVES_DIR" "$AUTO_SAVES_DIR"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
            chmod 700 "$dir"
        fi
    done
    
    if [[ ! -f "$RECOVERY_LOG_FILE" ]]; then
        touch "$RECOVERY_LOG_FILE"
        chmod 600 "$RECOVERY_LOG_FILE"
    fi
}

generate_session_id() {
    # Generate a unique session ID based on timestamp and random component
    local timestamp=$(date +%Y%m%d-%H%M%S)
    local random_component=$(openssl rand -hex 4 2>/dev/null || echo "$(date +%N | cut -c1-8)")
    echo "mario-session-$timestamp-$random_component"
}

collect_achievement_data() {
    local achievement_data="{}"
    
    if [[ -d "$ACHIEVEMENT_DIR" ]]; then
        achievement_data=$(python3 << 'EOF'
import json, os

achievement_dir = os.environ.get('ACHIEVEMENT_DIR', '')
data = {}

files_to_collect = {
    'total_coins': 'total-coins.txt',
    'current_streak': 'current-streak.txt', 
    'current_world': 'current-world.txt',
    'power_level': 'power-level.txt'
}

try:
    for key, filename in files_to_collect.items():
        file_path = os.path.join(achievement_dir, filename)
        if os.path.exists(file_path):
            with open(file_path, 'r') as f:
                content = f.read().strip()
                # Try to convert to int if it's numeric
                try:
                    data[key] = int(content) if content.isdigit() else content
                except:
                    data[key] = content
        else:
            data[key] = 0 if key in ['total_coins', 'current_streak', 'power_level'] else '1-1'
    
    # Load tool usage stats if available
    stats_file = os.path.join(achievement_dir, 'tool-usage-stats.json')
    if os.path.exists(stats_file):
        with open(stats_file, 'r') as f:
            data['tool_usage_stats'] = json.load(f)
    else:
        data['tool_usage_stats'] = {}
        
    print(json.dumps(data))
except Exception as e:
    print('{}')
EOF
)
    fi
    
    echo "$achievement_data"
}

collect_context_data() {
    local context_data="{}"
    
    if [[ -d "$CONTEXT_DIR" ]]; then
        context_data=$(python3 << 'EOF'
import json, os, glob

context_dir = os.environ.get('CONTEXT_DIR', '')
data = {}

try:
    # Collect recent context analysis logs (last 50 entries)
    enhancement_log = os.path.join(context_dir, 'enhancement-log.jsonl')
    if os.path.exists(enhancement_log):
        recent_enhancements = []
        with open(enhancement_log, 'r') as f:
            lines = f.readlines()
            for line in lines[-50:]:  # Last 50 entries
                try:
                    recent_enhancements.append(json.loads(line.strip()))
                except:
                    continue
        data['recent_enhancements'] = recent_enhancements
    
    # Collect project patterns
    patterns_file = os.path.join(context_dir, 'project-patterns.json')
    if os.path.exists(patterns_file):
        with open(patterns_file, 'r') as f:
            data['project_patterns'] = json.load(f)
    
    print(json.dumps(data))
except Exception as e:
    print('{}')
EOF
)
    fi
    
    echo "$context_data"
}

create_progress_checkpoint() {
    local session_id="$1"
    local save_type="$2"
    local working_dir="$3"
    local additional_context="$4"
    
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local checkpoint_file=""
    
    case "$save_type" in
        "auto_save")
            checkpoint_file="$AUTO_SAVES_DIR/auto-save-$(date +%Y%m%d-%H%M%S).json"
            ;;
        "session_end")
            checkpoint_file="$SESSION_SAVES_DIR/session-$session_id.json"
            ;;
        "emergency_save")
            checkpoint_file="$PROGRESS_DIR/emergency-save-$(date +%Y%m%d-%H%M%S).json"
            ;;
        "context_compact")
            checkpoint_file="$PROGRESS_DIR/pre-compact-$(date +%Y%m%d-%H%M%S).json"
            ;;
        *)
            checkpoint_file="$PROGRESS_DIR/manual-save-$(date +%Y%m%d-%H%M%S).json"
            ;;
    esac
    
    # Collect all progress data
    local achievement_data=$(collect_achievement_data)
    local context_data=$(collect_context_data)
    
    # Create comprehensive checkpoint
    local checkpoint_data
    checkpoint_data=$(python3 << EOF
import json
import os

checkpoint = {
    "version": "$CHECKPOINT_VERSION",
    "timestamp": "$timestamp",
    "session_id": "$session_id",
    "save_type": "$save_type",
    "working_directory": "$working_dir",
    "additional_context": "$additional_context",
    "achievement_data": $achievement_data,
    "context_data": $context_data,
    "system_info": {
        "hostname": os.uname().nodename,
        "platform": os.uname().sysname,
        "user": os.environ.get('USER', 'unknown')
    }
}

print(json.dumps(checkpoint, indent=2))
EOF
)
    
    # Save checkpoint securely
    echo "$checkpoint_data" > "$checkpoint_file"
    chmod 600 "$checkpoint_file"
    
    echo "$checkpoint_file"
}

log_progress_event() {
    local save_type="$1"
    local checkpoint_file="$2"
    local session_id="$3"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    local log_entry
    log_entry=$(python3 << EOF
import json
import os

log_entry = {
    "timestamp": "$timestamp",
    "event_type": "progress_save",
    "save_type": "$save_type",
    "checkpoint_file": "$checkpoint_file",
    "session_id": "$session_id",
    "file_size": os.path.getsize("$checkpoint_file") if os.path.exists("$checkpoint_file") else 0
}

print(json.dumps(log_entry))
EOF
)
    
    echo "$log_entry" >> "$RECOVERY_LOG_FILE"
}

cleanup_old_saves() {
    # Keep only last 10 auto-saves and 5 emergency saves
    local auto_saves=($(ls -t "$AUTO_SAVES_DIR"/auto-save-*.json 2>/dev/null || true))
    local emergency_saves=($(ls -t "$PROGRESS_DIR"/emergency-save-*.json 2>/dev/null || true))
    
    # Remove old auto-saves (keep 10 most recent)
    if [[ ${#auto_saves[@]} -gt 10 ]]; then
        for file in "${auto_saves[@]:10}"; do
            rm -f "$file"
        done
    fi
    
    # Remove old emergency saves (keep 5 most recent)
    if [[ ${#emergency_saves[@]} -gt 5 ]]; then
        for file in "${emergency_saves[@]:5}"; do
            rm -f "$file"
        done
    fi
    
    # Remove session saves older than 30 days
    find "$SESSION_SAVES_DIR" -name "session-*.json" -type f -mtime +30 -delete 2>/dev/null || true
}

generate_recovery_guide() {
    local checkpoint_file="$1"
    local save_type="$2"
    
    echo ""
    echo "🔧 ═══════ MARIO'S RECOVERY GUIDE ═══════ 🔧"
    echo ""
    echo "📁 Progress saved to: $(basename "$checkpoint_file")"
    echo "💾 Save type: $save_type"
    echo ""
    echo "🚀 To restore this session later:"
    echo "   1. Navigate to your project directory"
    echo "   2. Run: /mario-restore-session $(basename "$checkpoint_file" .json)"
    echo "   3. Mario will restore your achievements and context!"
    echo ""
    echo "🍄 Your progress includes:"
    echo "   • 🪙 Coin totals and achievement streaks"
    echo "   • 🌍 World progression and power level"
    echo "   • 🧠 Context analysis and project patterns"
    echo "   • 📊 Tool usage statistics"
    echo ""
    echo "💡 Pro tip: Use /mario-list-saves to see all available saves"
    echo "════════════════════════════════════════════"
}

parse_json_input() {
    local json_input="$1"
    
    python3 << EOF
import json, sys, os
try:
    data = json.loads('''$json_input''')
    
    # Extract relevant data
    hook_event = data.get('hook_event_name', '')
    working_directory = data.get('working_directory', os.getcwd())
    session_info = data.get('session_info', {})
    compaction_reason = data.get('compaction_reason', '')
    
    # Output parsed data as environment variables
    print(f"export PARSED_HOOK_EVENT='{hook_event}'")
    print(f"export PARSED_WORKING_DIR='{working_directory}'")
    print(f"export PARSED_SESSION_ID='{session_info.get('id', 'mario-session-' + str(hash(os.getcwd()))[-8:])}'")
    print(f"export PARSED_COMPACTION_REASON='{compaction_reason}'")
    
except Exception as e:
    print(f"# JSON parsing error: {str(e)}", file=sys.stderr)
    print("export PARSED_HOOK_EVENT='unknown'")
    print("export PARSED_WORKING_DIR='.'")
    print("export PARSED_SESSION_ID='mario-session-unknown'")
    print("export PARSED_COMPACTION_REASON=''")
    sys.exit(1)
EOF
}

# Main progress saving function
main() {
    local input_data
    input_data=$(cat)
    
    # Initialize progress system
    create_progress_dirs
    
    # Parse JSON input using official Claude Code format
    if ! eval "$(parse_json_input "$input_data")"; then
        echo "❌ Error parsing progress save input" >&2
        exit 1
    fi
    
    # Determine save type based on hook event
    local save_type=""
    local additional_context=""
    
    case "$PARSED_HOOK_EVENT" in
        "Stop")
            save_type="session_end"
            additional_context="Normal session termination"
            ;;
        "PreCompact")
            save_type="context_compact"
            additional_context="Pre-compaction save: $PARSED_COMPACTION_REASON"
            ;;
        "SessionStart")
            # Auto-save from previous session on new start
            save_type="auto_save"
            additional_context="Session transition auto-save"
            ;;
        *)
            # Skip unknown events
            exit 0
            ;;
    esac
    
    # Create progress checkpoint
    local checkpoint_file
    checkpoint_file=$(create_progress_checkpoint "$PARSED_SESSION_ID" "$save_type" "$PARSED_WORKING_DIR" "$additional_context")
    
    # Log the save event
    log_progress_event "$save_type" "$checkpoint_file" "$PARSED_SESSION_ID"
    
    # Clean up old saves
    cleanup_old_saves
    
    # Display appropriate Mario message
    echo "${MARIO_SAVE_MESSAGES[$save_type]}"
    
    # Provide recovery guidance for session ends
    if [[ "$save_type" == "session_end" ]] || [[ "$save_type" == "context_compact" ]]; then
        generate_recovery_guide "$checkpoint_file" "$save_type"
    fi
    
    # For context compaction, provide optimization info
    if [[ "$save_type" == "context_compact" ]]; then
        echo ""
        echo "🧠 Context optimization in progress..."
        echo "💾 Your session state has been safely preserved!"
        echo "🍄 Mario's memory management keeps your adventure running smoothly!"
    fi
}

# Execute main function with error handling  
main "$@"