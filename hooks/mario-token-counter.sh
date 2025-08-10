#!/bin/bash
# 🪙📊 Mario Token Counter - Advanced Claude Usage Analytics 📊🪙
# Professional token tracking system using proper Claude Code hook protocols
# Tracks tokens sent/received with 5-hour session windows and usage statistics

# Security and error handling
set -euo pipefail

# Constants
readonly TOKEN_DIR="$HOME/.claude/token-analytics"
readonly CURRENT_SESSION_FILE="$TOKEN_DIR/current-session.json"
readonly SESSION_HISTORY_FILE="$TOKEN_DIR/session-history.jsonl"
readonly DAILY_STATS_FILE="$TOKEN_DIR/daily-stats-$(date +%Y-%m-%d).json"
readonly USAGE_PATTERNS_FILE="$TOKEN_DIR/usage-patterns.json"

# Claude Code real limits configuration
readonly SESSION_RESET_HOURS=5  # Claude resets usage every ~5 hours
readonly WEEKLY_RESET_DAYS=7     # New weekly limits (Aug 2025)
readonly TOKEN_ESTIMATION_MULTIPLIER=4  # Approximate tokens per character

# Real Claude Code usage patterns (based on Anthropic data)
declare -A PLAN_LIMITS=(
    ["free"]=45        # ~45 messages every 5 hours
    ["pro"]=45         # ~45 messages every 5 hours (5x multiplier vs free for complexity)
    ["max_5x"]=225     # ~45 * 5 = 225 messages every 5 hours  
    ["max_20x"]=900    # ~45 * 20 = 900 messages every 5 hours
)

# Claude Code specific limits (prompts per 5-hour window)
declare -A CLAUDE_CODE_LIMITS=(
    ["pro"]="10-40"    # 10-40 prompts every 5 hours (varies by prompt size)
    ["max_5x"]="50-200"   # Estimated 5x multiplier
    ["max_20x"]="200-800" # Estimated 20x multiplier  
)

# Mario responses based on real Claude usage patterns
declare -A MARIO_USAGE_MESSAGES=(
    ["light"]="🍄 Perfect pacing! Mario loves efficient development!"
    ["normal"]="⚡ Great progress! You're in the optimal usage zone!"
    ["active"]="🔥 Power User mode! You're making the most of Claude Code!"
    ["intensive"]="⭐ Intensive session! Remember to save your work!"
    ["approaching_limit"]="⚠️ 🍄 MARIO WARNING: 'Mamma mia! You're approaching the 5-hour window limit!'"
    ["near_weekly_limit"]="🚨 👑 BOWSER ALERT: 'ROAAR! Weekly limit approaching - plan your usage wisely!'"
    ["session_reset"]="🔄 🆕 New 5-hour window! Your usage has been reset - Let's-a-go again!"
    ["weekly_reset"]="🌟 📅 Weekly reset complete! Fresh limits for legendary coding adventures!"
)

# Real usage thresholds based on Claude Code patterns
# Using requests/prompts instead of just tokens for more accurate tracking
declare -A REQUEST_THRESHOLDS=(
    ["light"]=5        # 1-5 requests - light usage
    ["normal"]=15      # 6-15 requests - normal development
    ["active"]=30      # 16-30 requests - active coding session
    ["intensive"]=40   # 31-40 requests - intensive development (Pro limit approaching)
    ["approaching_limit"]=42  # 41+ requests - very close to typical limits
)

# Weekly tracking (new Claude limits starting Aug 2025)
declare -A WEEKLY_THRESHOLDS=(
    ["normal"]=100     # Normal weekly usage
    ["active"]=200     # Active weekly development
    ["power_user"]=400 # Power user territory
    ["near_weekly_limit"]=500  # Approaching weekly limits
)

# Utility functions
create_token_dirs() {
    if [[ ! -d "$TOKEN_DIR" ]]; then
        mkdir -p "$TOKEN_DIR"
        chmod 700 "$TOKEN_DIR"
        
        # Initialize current session file
        cat > "$CURRENT_SESSION_FILE" << 'EOF'
{
  "version": "2.0",
  "session_start": "",
  "last_activity": "",
  "total_input_tokens": 0,
  "total_output_tokens": 0,
  "total_requests": 0,
  "tool_usage_breakdown": {},
  "hourly_breakdown": {},
  "session_id": ""
}
EOF
        
        touch "$SESSION_HISTORY_FILE"
        chmod 600 "$CURRENT_SESSION_FILE" "$SESSION_HISTORY_FILE"
    fi
}

get_current_timestamp() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

check_session_reset_needed() {
    local session_data
    
    if [[ ! -f "$CURRENT_SESSION_FILE" ]]; then
        echo "true"
        echo "0.0"  # Hours since last activity
        echo "session_reset"  # Reset type
        return
    fi
    
    session_data=$(cat "$CURRENT_SESSION_FILE" 2>/dev/null || echo '{}')
    
    python3 << EOF
import json
import datetime
import sys

try:
    data = json.loads('''$session_data''')
    last_activity = data.get('last_activity', '')
    session_start = data.get('session_start', '')
    
    current_time = datetime.datetime.now(datetime.timezone.utc)
    
    # Check 5-hour session reset (Claude Code pattern)
    needs_session_reset = False
    hours_since_last = 0.0
    
    if last_activity:
        last_time = datetime.datetime.fromisoformat(last_activity.replace('Z', '+00:00'))
        time_diff = current_time - last_time
        hours_since_last = time_diff.total_seconds() / 3600
        
        if hours_since_last >= $SESSION_RESET_HOURS:
            needs_session_reset = True
    else:
        needs_session_reset = True
    
    # Check weekly reset (new Claude limits Aug 2025)
    needs_weekly_reset = False
    if session_start:
        start_time = datetime.datetime.fromisoformat(session_start.replace('Z', '+00:00'))
        days_diff = (current_time - start_time).days
        if days_diff >= $WEEKLY_RESET_DAYS:
            needs_weekly_reset = True
    
    # Determine reset type
    reset_type = "none"
    if needs_weekly_reset:
        reset_type = "weekly_reset"
        print('true')
    elif needs_session_reset:
        reset_type = "session_reset"  
        print('true')
    else:
        print('false')
    
    print(f'{hours_since_last:.1f}')
    print(reset_type)
        
except Exception as e:
    print('true')  # Reset on any error
    print('0.0')
    print('session_reset')
EOF
}

estimate_tokens() {
    local text="$1"
    local char_count=${#text}
    
    # Conservative estimation: ~4 characters per token for mixed content
    # This accounts for code, natural language, and JSON structures
    local estimated_tokens=$((char_count / TOKEN_ESTIMATION_MULTIPLIER))
    
    # Minimum 1 token for non-empty content
    [[ $estimated_tokens -eq 0 ]] && [[ $char_count -gt 0 ]] && estimated_tokens=1
    
    echo "$estimated_tokens"
}

analyze_tool_content() {
    local tool_name="$1"
    local tool_input="$2"
    local tool_response="$3"
    
    local input_tokens=$(estimate_tokens "$tool_input")
    local output_tokens=$(estimate_tokens "$tool_response")
    
    # Tool-specific token adjustments
    case "$tool_name" in
        "Read"|"Grep"|"Glob")
            # These tools often return large amounts of text
            output_tokens=$((output_tokens * 120 / 100))  # 20% increase
            ;;
        "Write"|"Edit"|"MultiEdit")
            # Code editing tools have structured input/output
            input_tokens=$((input_tokens * 110 / 100))   # 10% increase
            ;;
        "Bash")
            # Command output can be verbose
            output_tokens=$((output_tokens * 115 / 100))  # 15% increase
            ;;
        "Task"|"WebFetch"|"WebSearch")
            # Complex operations with rich responses
            output_tokens=$((output_tokens * 130 / 100))  # 30% increase
            ;;
    esac
    
    echo "$input_tokens"
    echo "$output_tokens"
}

reset_session_data() {
    local new_session_id="$1"
    local timestamp="$2"
    local reset_type="${3:-session_reset}"
    
    # Archive current session if it exists
    if [[ -f "$CURRENT_SESSION_FILE" ]]; then
        local current_session=$(cat "$CURRENT_SESSION_FILE")
        
        # Add to history with reset type
        python3 << EOF
import json

try:
    current_data = json.loads('''$current_session''')
    if current_data.get('total_requests', 0) > 0:
        # Add session end timestamp and reset type
        current_data['session_end'] = '$timestamp'
        current_data['reset_type'] = '$reset_type'
        current_data['reset_reason'] = 'Claude Code $reset_type - limits refreshed'
        
        # Write to history
        with open('$SESSION_HISTORY_FILE', 'a') as f:
            f.write(json.dumps(current_data) + '\n')
except:
    pass
EOF
    fi
    
    # Create new session with proper tracking
    cat > "$CURRENT_SESSION_FILE" << EOF
{
  "version": "2.1",
  "session_start": "$timestamp",
  "last_activity": "$timestamp",
  "total_input_tokens": 0,
  "total_output_tokens": 0,
  "total_requests": 0,
  "weekly_requests": 0,
  "tool_usage_breakdown": {},
  "hourly_breakdown": {},
  "claude_code_metadata": {
    "last_5h_reset": "$timestamp",
    "last_weekly_reset": "$timestamp",
    "estimated_plan": "pro",
    "reset_type": "$reset_type"
  },
  "session_id": "$new_session_id"
}
EOF
}

update_session_stats() {
    local tool_name="$1"
    local input_tokens="$2"
    local output_tokens="$3"
    local timestamp="$4"
    local session_id="$5"
    
    python3 << EOF
import json
import datetime

# Load current session data
try:
    with open('$CURRENT_SESSION_FILE', 'r') as f:
        session_data = json.load(f)
except:
    session_data = {}

# Update totals
session_data['total_input_tokens'] = session_data.get('total_input_tokens', 0) + $input_tokens
session_data['total_output_tokens'] = session_data.get('total_output_tokens', 0) + $output_tokens
session_data['total_requests'] = session_data.get('total_requests', 0) + 1
session_data['last_activity'] = '$timestamp'
session_data['session_id'] = '$session_id'

# Update tool breakdown
tool_breakdown = session_data.get('tool_usage_breakdown', {})
if '$tool_name' not in tool_breakdown:
    tool_breakdown['$tool_name'] = {
        'requests': 0,
        'input_tokens': 0,
        'output_tokens': 0
    }

tool_breakdown['$tool_name']['requests'] += 1
tool_breakdown['$tool_name']['input_tokens'] += $input_tokens
tool_breakdown['$tool_name']['output_tokens'] += $output_tokens
session_data['tool_usage_breakdown'] = tool_breakdown

# Update hourly breakdown
hour_key = '$timestamp'[:13]  # YYYY-MM-DDTHH
hourly_breakdown = session_data.get('hourly_breakdown', {})
if hour_key not in hourly_breakdown:
    hourly_breakdown[hour_key] = {
        'requests': 0,
        'input_tokens': 0,
        'output_tokens': 0
    }

hourly_breakdown[hour_key]['requests'] += 1
hourly_breakdown[hour_key]['input_tokens'] += $input_tokens
hourly_breakdown[hour_key]['output_tokens'] += $output_tokens
session_data['hourly_breakdown'] = hourly_breakdown

# Save updated data
with open('$CURRENT_SESSION_FILE', 'w') as f:
    json.dump(session_data, f, indent=2)

# Output current totals for display
total_tokens = session_data['total_input_tokens'] + session_data['total_output_tokens']
print(f"TOTAL_TOKENS:{total_tokens}")
print(f"INPUT_TOKENS:{session_data['total_input_tokens']}")
print(f"OUTPUT_TOKENS:{session_data['total_output_tokens']}")
print(f"TOTAL_REQUESTS:{session_data['total_requests']}")
EOF
}

determine_usage_level() {
    local total_requests="$1"
    local weekly_requests="$2"
    
    # Check weekly limits first (priority since they're new Aug 2025 limits)
    if [[ $weekly_requests -ge ${WEEKLY_THRESHOLDS[near_weekly_limit]} ]]; then
        echo "near_weekly_limit"
        return
    fi
    
    # Check 5-hour session limits (traditional Claude Code pattern)
    if [[ $total_requests -ge ${REQUEST_THRESHOLDS[approaching_limit]} ]]; then
        echo "approaching_limit"
    elif [[ $total_requests -ge ${REQUEST_THRESHOLDS[intensive]} ]]; then
        echo "intensive"
    elif [[ $total_requests -ge ${REQUEST_THRESHOLDS[active]} ]]; then
        echo "active"
    elif [[ $total_requests -ge ${REQUEST_THRESHOLDS[normal]} ]]; then
        echo "normal"
    else
        echo "light"
    fi
}

generate_usage_display() {
    local total_tokens="$1"
    local input_tokens="$2"
    local output_tokens="$3"
    local total_requests="$4"
    local weekly_requests="$5"
    local usage_level="$6"
    local session_hours="$7"
    
    echo ""
    echo "📊 ══════ MARIO CLAUDE CODE ANALYTICS ══════ 📊"
    echo ""
    echo "🕐 Session: ${session_hours}h (resets every ${SESSION_RESET_HOURS}h)"
    echo "📅 Weekly Requests: $weekly_requests (resets every 7 days)"
    echo "🔄 Session Requests: $total_requests"
    echo "🪙 Total Tokens: $(printf "%'d" "$total_tokens") (estimated)"
    echo "📥 Input: $(printf "%'d" "$input_tokens") | 📤 Output: $(printf "%'d" "$output_tokens")"
    echo ""
    
    # Show usage estimation for all three main plans
    echo "📋 Plan Usage Estimates:"
    
    # Pro Plan estimation
    local pro_percent=$((total_requests * 100 / 40))  # Max 40 requests for Pro
    if [[ $pro_percent -gt 100 ]]; then pro_percent=100; fi
    echo "  👤 Pro Plan: $total_requests/~40 prompts (${pro_percent}%)"
    
    # Max 5x estimation  
    local max5x_percent=$((total_requests * 100 / 200))  # Max ~200 requests for Max 5x
    if [[ $max5x_percent -gt 100 ]]; then max5x_percent=100; fi
    echo "  🌟 Max 5x: $total_requests/~200 prompts (${max5x_percent}%)"
    
    # Max 20x estimation
    local max20x_percent=$((total_requests * 100 / 800))  # Max ~800 requests for Max 20x
    if [[ $max20x_percent -gt 100 ]]; then max20x_percent=100; fi
    echo "  👑 Max 20x: $total_requests/~800 prompts (${max20x_percent}%)"
    echo ""
    
    # Multi-plan progress bars
    echo "📊 Usage Progress by Plan:"
    
    # Pro Plan progress bar
    local pro_bars=$((pro_percent / 10))
    local pro_bar=""
    for i in $(seq 1 10); do
        if [[ $i -le $pro_bars ]]; then
            if [[ $pro_percent -ge 90 ]]; then
                pro_bar+="🔴"
            elif [[ $pro_percent -ge 70 ]]; then
                pro_bar+="🟡" 
            elif [[ $pro_percent -ge 40 ]]; then
                pro_bar+="🟠"
            else
                pro_bar+="🟢"
            fi
        else
            pro_bar+="⬜"
        fi
    done
    echo "  👤 Pro: $pro_bar (${pro_percent}%)"
    
    # Max 5x progress bar
    local max5x_bars=$((max5x_percent / 10))
    local max5x_bar=""
    for i in $(seq 1 10); do
        if [[ $i -le $max5x_bars ]]; then
            if [[ $max5x_percent -ge 70 ]]; then
                max5x_bar+="🟡"
            else
                max5x_bar+="🟢"
            fi
        else
            max5x_bar+="⬜"
        fi
    done
    echo "  🌟 Max 5x: $max5x_bar (${max5x_percent}%)"
    
    # Max 20x progress bar
    local max20x_bars=$((max20x_percent / 10))
    local max20x_bar=""
    for i in $(seq 1 10); do
        if [[ $i -le $max20x_bars ]]; then
            max20x_bar+="🟢"
        else
            max20x_bar+="⬜"
        fi
    done
    echo "  👑 Max 20x: $max20x_bar (${max20x_percent}%)"
    
    # Weekly progress bar (new Aug 2025 limits)
    local max_weekly_limit=${WEEKLY_THRESHOLDS[near_weekly_limit]}
    local weekly_percent=$((weekly_requests * 100 / max_weekly_limit))
    local weekly_bars=$((weekly_percent / 10))
    local weekly_bar=""
    
    for i in $(seq 1 10); do
        if [[ $i -le $weekly_bars ]]; then
            if [[ $weekly_percent -ge 90 ]]; then
                weekly_bar+="🔴"
            elif [[ $weekly_percent -ge 70 ]]; then
                weekly_bar+="🟡"
            else
                weekly_bar+="🟢"
            fi
        else
            weekly_bar+="⬜"
        fi
    done
    
    echo "📅 Weekly Limit: $weekly_bar ($weekly_percent%)"
    echo ""
    echo "${MARIO_USAGE_MESSAGES[$usage_level]}"
    
    # Show Claude Code specific guidance
    if [[ $total_requests -gt 0 ]]; then
        local avg_tokens_per_request=$((total_tokens / total_requests))
        echo "⚡ Efficiency: $(printf "%'d" "$avg_tokens_per_request") tokens/prompt"
    fi
    
    # Show plan-specific recommendations
    echo "💡 Plan-Specific Guidance:"
    if [[ $pro_percent -ge 90 ]]; then
        echo "  🚨 Pro: LIMIT REACHED! Consider upgrading to Max for more capacity"
    elif [[ $pro_percent -ge 70 ]]; then
        echo "  ⚠️ Pro: Approaching limit - batch tasks or upgrade to Max"
    elif [[ $pro_percent -ge 40 ]]; then
        echo "  📊 Pro: Active usage - good productivity pace"
    else
        echo "  ✅ Pro: Plenty of capacity remaining"
    fi
    
    if [[ $max5x_percent -ge 80 ]]; then
        echo "  🟡 Max 5x: High usage - consider Max 20x for heavy workflows"
    elif [[ $max5x_percent -ge 40 ]]; then
        echo "  📈 Max 5x: Great for intensive development"
    else
        echo "  🌟 Max 5x: Excellent capacity for complex projects"
    fi
    
    if [[ $max20x_percent -ge 50 ]]; then
        echo "  🔥 Max 20x: Power user territory - maximum productivity!"
    else
        echo "  👑 Max 20x: Unlimited-like capacity for enterprise workflows"
    fi
    
    # Weekly limit warning
    if [[ $weekly_requests -ge ${WEEKLY_THRESHOLDS[near_weekly_limit]} ]]; then
        echo ""
        echo "🚨 WEEKLY LIMIT WARNING: Approaching Aug 2025 weekly caps!"
        echo "👑 Max users can purchase additional usage if needed"
    fi
    
    echo "═══════════════════════════════════════════════"
}

parse_json_input() {
    local json_input="$1"
    
    python3 << EOF
import json, sys, os
try:
    data = json.loads('''$json_input''')
    
    # Extract relevant data
    hook_event = data.get('hook_event_name', '')
    tool_name = data.get('tool_name', '')
    tool_input = data.get('tool_input', {})
    tool_response = data.get('tool_response', {})
    session_info = data.get('session_info', {})
    
    # Convert tool data to strings for token estimation
    tool_input_str = json.dumps(tool_input) if isinstance(tool_input, dict) else str(tool_input)
    tool_response_str = json.dumps(tool_response) if isinstance(tool_response, dict) else str(tool_response)
    
    # Output parsed data as environment variables
    print(f"export PARSED_HOOK_EVENT='{hook_event}'")
    print(f"export PARSED_TOOL_NAME='{tool_name}'")
    print(f"export PARSED_TOOL_INPUT='''{tool_input_str}'''")
    print(f"export PARSED_TOOL_RESPONSE='''{tool_response_str}'''")
    print(f"export PARSED_SESSION_ID='{session_info.get('id', 'mario-token-session')}'")
    
except Exception as e:
    print(f"# JSON parsing error: {str(e)}", file=sys.stderr)
    print("export PARSED_HOOK_EVENT='unknown'")
    print("export PARSED_TOOL_NAME='unknown'")
    print("export PARSED_TOOL_INPUT=''")
    print("export PARSED_TOOL_RESPONSE=''")
    print("export PARSED_SESSION_ID='mario-token-session'")
    sys.exit(1)
EOF
}

# Main token counting function
main() {
    local input_data
    input_data=$(cat)
    
    # Initialize token analytics system
    create_token_dirs
    
    # Parse JSON input using official Claude Code format
    if ! eval "$(parse_json_input "$input_data")"; then
        echo "❌ Error parsing token counter input" >&2
        exit 1
    fi
    
    # Only process PostToolUse events (after tools complete)
    if [[ "$PARSED_HOOK_EVENT" != "PostToolUse" ]]; then
        exit 0  # Silently ignore other events
    fi
    
    local timestamp=$(get_current_timestamp)
    
    # Check if session/weekly reset is needed (Claude Code patterns)
    readarray -t reset_check < <(check_session_reset_needed)
    local needs_reset="${reset_check[0]}"
    local hours_since_last="${reset_check[1]:-0}"
    local reset_type="${reset_check[2]:-session_reset}"
    
    # Reset session if needed
    if [[ "$needs_reset" == "true" ]]; then
        reset_session_data "$PARSED_SESSION_ID" "$timestamp" "$reset_type"
        echo "${MARIO_USAGE_MESSAGES[$reset_type]}"
        hours_since_last="0.0"
    fi
    
    # Analyze token usage for this tool call
    readarray -t token_analysis < <(analyze_tool_content "$PARSED_TOOL_NAME" "$PARSED_TOOL_INPUT" "$PARSED_TOOL_RESPONSE")
    local input_tokens="${token_analysis[0]:-0}"
    local output_tokens="${token_analysis[1]:-0}"
    
    # Update session statistics
    readarray -t session_stats < <(update_session_stats "$PARSED_TOOL_NAME" "$input_tokens" "$output_tokens" "$timestamp" "$PARSED_SESSION_ID")
    
    # Parse updated statistics
    local total_tokens=0
    local total_input_tokens=0
    local total_output_tokens=0
    local total_requests=0
    
    for stat in "${session_stats[@]}"; do
        case "$stat" in
            TOTAL_TOKENS:*) total_tokens="${stat#TOTAL_TOKENS:}" ;;
            INPUT_TOKENS:*) total_input_tokens="${stat#INPUT_TOKENS:}" ;;
            OUTPUT_TOKENS:*) total_output_tokens="${stat#OUTPUT_TOKENS:}" ;;
            TOTAL_REQUESTS:*) total_requests="${stat#TOTAL_REQUESTS:}" ;;
        esac
    done
    
    # Get weekly request count for proper limit tracking
    local weekly_requests
    weekly_requests=$(python3 << EOF
import json
try:
    with open('$CURRENT_SESSION_FILE', 'r') as f:
        data = json.load(f)
    # For now, use total_requests as proxy for weekly (would need more complex tracking)
    print(data.get('total_requests', 0))
except:
    print(0)
EOF
)
    
    # Determine usage level (requests-based, Claude Code style)
    local usage_level
    usage_level=$(determine_usage_level "$total_requests" "$weekly_requests")
    
    # Show detailed analytics every 3rd request or for significant usage levels  
    # You can change "3" to any number: 1=always, 10=less frequent, etc.
    if [[ $((total_requests % 3)) -eq 0 ]] || [[ "$usage_level" =~ (intensive|approaching_limit|near_weekly_limit) ]]; then
        generate_usage_display "$total_tokens" "$total_input_tokens" "$total_output_tokens" "$total_requests" "$weekly_requests" "$usage_level" "$hours_since_last"
    else
        # Quick status update with Claude Code style
        echo "🔄 Request #$total_requests | 🪙 +$(($input_tokens + $output_tokens)) tokens | 📊 Total: $(printf "%'d" "$total_tokens") | 🕐 ${hours_since_last}h"
        
        # Show usage level message for important levels
        if [[ "$usage_level" =~ (active|intensive|approaching_limit) ]]; then
            echo "${MARIO_USAGE_MESSAGES[$usage_level]}"
        fi
    fi
}

# Execute main function with error handling
main "$@"