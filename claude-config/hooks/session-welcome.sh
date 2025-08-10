#!/bin/bash
# 🎮👋 Mario Session Welcome System - Legendary Greeting & Setup 👋🎮
# Advanced session initialization using proper Claude Code SessionStart hook protocol
# Provides intelligent project setup, achievement status, and Mario personality

# Security and error handling
set -euo pipefail

# Constants
readonly WELCOME_DIR="$HOME/.claude/welcome-system"
readonly SESSION_HISTORY_FILE="$WELCOME_DIR/session-history.jsonl"
readonly PROJECT_CACHE_FILE="$WELCOME_DIR/project-cache.json"
readonly DAILY_STATS_FILE="$WELCOME_DIR/daily-stats-$(date +%Y-%m-%d).json"

# Achievement files
readonly ACHIEVEMENT_DIR="$HOME/.claude/achievements"
readonly COIN_FILE="$ACHIEVEMENT_DIR/total-coins.txt"
readonly STREAK_FILE="$ACHIEVEMENT_DIR/current-streak.txt" 
readonly WORLD_FILE="$ACHIEVEMENT_DIR/current-world.txt"
readonly LEVEL_FILE="$ACHIEVEMENT_DIR/power-level.txt"

# Mario character greetings based on time of day and achievement level
declare -A TIME_GREETINGS=(
    ["morning"]="☀️ 🍄 Good morning! Mario's ready for a legendary day of coding!"
    ["afternoon"]="🌅 🎮 Good afternoon! Time for some Super Mario engineering!"
    ["evening"]="🌙 ⭐ Good evening! Let's finish strong like defeating Bowser!"
    ["night"]="🌌 🦉 Working late? Even Mario needs his rest, but let's code wisely!"
)

# Achievement level greetings
declare -A LEVEL_GREETINGS=(
    ["beginner"]="🍄 Welcome, new adventurer! Every legendary developer started at World 1-1!"
    ["junior"]="🌸 Fire Flower power! You're growing stronger with each challenge!"
    ["intermediate"]="⭐ Star Power activated! You're becoming a coding legend!"
    ["senior"]="👑 Royal status! Princess Peach would be proud of your elegant solutions!"
    ["master"]="🏰 Bowser's Castle Master! You've reached the highest level of coding mastery!"
)

# Project type detection and setup suggestions
declare -A PROJECT_SUGGESTIONS=(
    ["javascript"]="🟨 JavaScript detected! Consider using /luigi-debug for thorough testing."
    ["python"]="🐍 Python detected! /dr-mario-checkup can analyze your code health."
    ["rust"]="⚡ Rust detected! /bowser-optimize will love this performance-focused language."
    ["go"]="🚀 Go detected! Perfect for /rosalina-systems-analysis of distributed systems."
    ["react"]="⚛️ React detected! /peach-architect can help design elegant component hierarchies."
    ["docker"]="🐋 Docker detected! /captain-toad-environment-setup for container optimization."
)

# Utility functions
create_welcome_dirs() {
    if [[ ! -d "$WELCOME_DIR" ]]; then
        mkdir -p "$WELCOME_DIR"
        chmod 700 "$WELCOME_DIR"
        touch "$SESSION_HISTORY_FILE"
        
        # Initialize project cache
        cat > "$PROJECT_CACHE_FILE" << 'EOF'
{
  "version": "1.0",
  "projects": {},
  "last_accessed": {},
  "quick_setups": []
}
EOF
    fi
    
    # Create achievement dir if needed
    if [[ ! -d "$ACHIEVEMENT_DIR" ]]; then
        mkdir -p "$ACHIEVEMENT_DIR"
        chmod 700 "$ACHIEVEMENT_DIR"
        echo "0" > "$COIN_FILE"
        echo "0" > "$STREAK_FILE"
        echo "1-1" > "$WORLD_FILE"
        echo "1" > "$LEVEL_FILE"
    fi
}

get_time_period() {
    local hour=$(date +%H)
    
    if [[ $hour -ge 6 && $hour -lt 12 ]]; then
        echo "morning"
    elif [[ $hour -ge 12 && $hour -lt 18 ]]; then
        echo "afternoon"
    elif [[ $hour -ge 18 && $hour -lt 22 ]]; then
        echo "evening"
    else
        echo "night"
    fi
}

determine_skill_level() {
    local total_coins="$1"
    local current_world="$2"
    
    if [[ $total_coins -ge 1000 ]] || [[ "$current_world" == "8-1" ]]; then
        echo "master"
    elif [[ $total_coins -ge 300 ]] || [[ "$current_world" =~ ^[5-7] ]]; then
        echo "senior"
    elif [[ $total_coins -ge 100 ]] || [[ "$current_world" =~ ^[3-4] ]]; then
        echo "intermediate"
    elif [[ $total_coins -ge 25 ]] || [[ "$current_world" == "2-1" ]]; then
        echo "junior"
    else
        echo "beginner"
    fi
}

analyze_project_structure() {
    local working_dir="$1"
    local detected_types=()
    local setup_suggestions=()
    local quick_commands=()
    
    if [[ -d "$working_dir" ]]; then
        cd "$working_dir" 2>/dev/null || return 0
        
        # Detect project types
        [[ -f "package.json" ]] && detected_types+=("javascript")
        [[ -f "requirements.txt" || -f "setup.py" || -f "pyproject.toml" ]] && detected_types+=("python")
        [[ -f "Cargo.toml" ]] && detected_types+=("rust")
        [[ -f "go.mod" ]] && detected_types+=("go")
        [[ -f "Dockerfile" || -f "docker-compose.yml" ]] && detected_types+=("docker")
        
        # React/Frontend detection
        if [[ -f "package.json" ]] && grep -q "react\|next\|gatsby" package.json 2>/dev/null; then
            detected_types+=("react")
        fi
        
        # Generate suggestions based on detected types
        for type in "${detected_types[@]}"; do
            if [[ -n "${PROJECT_SUGGESTIONS[$type]:-}" ]]; then
                setup_suggestions+=("${PROJECT_SUGGESTIONS[$type]}")
            fi
        done
        
        # Quick command suggestions based on common files
        [[ -f "package.json" ]] && quick_commands+=("/mario-code 'review package.json dependencies'")
        [[ -f "README.md" ]] && quick_commands+=("/toad-docs 'enhance README documentation'")
        [[ -d "tests" || -d "test" || -d "__tests__" ]] && quick_commands+=("/luigi-debug 'analyze test coverage'")
        [[ -d "src" || -d "lib" ]] && quick_commands+=("/peach-architect 'review project architecture'")
    fi
    
    printf '%s\n' "${detected_types[@]}"
    printf '%s\n' "---SUGGESTIONS---"
    printf '%s\n' "${setup_suggestions[@]}"
    printf '%s\n' "---COMMANDS---"
    printf '%s\n' "${quick_commands[@]}"
}

log_session_start() {
    local working_dir="$1"
    local project_types="$2"
    local skill_level="$3"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    local log_entry
    log_entry=$(python3 << EOF
import json
import os

log_entry = {
    "timestamp": "$timestamp",
    "working_directory": "$working_dir",
    "project_types": "$project_types".split(),
    "skill_level": "$skill_level",
    "session_id": os.environ.get('CLAUDE_SESSION_ID', 'unknown'),
    "daily_session_count": 1
}

print(json.dumps(log_entry))
EOF
)
    
    echo "$log_entry" >> "$SESSION_HISTORY_FILE"
}

generate_achievement_status() {
    local total_coins="${1:-0}"
    local current_streak="${2:-0}"
    local current_world="${3:-1-1}"
    local power_level="${4:-1}"
    
    echo ""
    echo "🏆 ═══════ MARIO POWERUP STATUS ═══════ 🏆"
    echo "💰 Total Coins: $total_coins"
    echo "🔥 Current Streak: $current_streak"
    echo "🌍 Current World: $current_world"
    echo "⭐ Power Level: $power_level"
    
    # Progress bar visualization
    local progress_percent=$((total_coins * 100 / 1000))  # Max 1000 coins = 100%
    local progress_bars=$((progress_percent / 10))
    local progress_bar=""
    
    for i in $(seq 1 10); do
        if [[ $i -le $progress_bars ]]; then
            progress_bar+="🟩"
        else
            progress_bar+="⬜"
        fi
    done
    
    echo "📊 Progress to Master: $progress_bar ($progress_percent%)"
    echo "═══════════════════════════════════════"
}

generate_quick_start_menu() {
    local project_suggestions=("$@")
    
    echo ""
    echo "🚀 ═══════ QUICK START MENU ═══════ 🚀"
    echo ""
    echo "🎮 Essential Commands:"
    echo "  /mario-orchestra     - Multi-agent collaboration"
    echo "  /mario-status        - Check your complete status"
    echo "  /fire-trio          - Triple code review team"
    echo ""
    echo "👥 Character Commands:"
    echo "  /mario              - Enthusiastic implementation"
    echo "  /luigi              - Thorough debugging"
    echo "  /peach              - Elegant architecture"
    echo "  /bowser             - Performance optimization"
    echo "  /rosalina           - Systems thinking"
    echo ""
    
    if [[ ${#project_suggestions[@]} -gt 0 ]]; then
        echo "🎯 Project-Specific Suggestions:"
        for suggestion in "${project_suggestions[@]}"; do
            echo "  $suggestion"
        done
        echo ""
    fi
    
    echo "💡 Pro Tip: Use /mario-orchestra for complex multi-step tasks!"
    echo "══════════════════════════════════════════"
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
    
    # Output parsed data as environment variables
    print(f"export PARSED_HOOK_EVENT='{hook_event}'")
    print(f"export PARSED_WORKING_DIR='{working_directory}'")
    print(f"export PARSED_SESSION_ID='{session_info.get('id', 'unknown')}'")
    
except Exception as e:
    print(f"# JSON parsing error: {str(e)}", file=sys.stderr)
    print("export PARSED_HOOK_EVENT='unknown'")
    print("export PARSED_WORKING_DIR='.'")
    print("export PARSED_SESSION_ID='unknown'")
    sys.exit(1)
EOF
}

# Main welcome function
main() {
    local input_data
    input_data=$(cat)
    
    # Initialize welcome system
    create_welcome_dirs
    
    # Parse JSON input using official Claude Code format
    if ! eval "$(parse_json_input "$input_data")"; then
        echo "❌ Error parsing session welcome input" >&2
        exit 1
    fi
    
    # Only process SessionStart events
    if [[ "$PARSED_HOOK_EVENT" != "SessionStart" ]]; then
        exit 0  # Silently ignore non-SessionStart events
    fi
    
    # Load current achievement status
    local total_coins=$(cat "$COIN_FILE" 2>/dev/null || echo "0")
    local current_streak=$(cat "$STREAK_FILE" 2>/dev/null || echo "0")
    local current_world=$(cat "$WORLD_FILE" 2>/dev/null || echo "1-1")
    local power_level=$(cat "$LEVEL_FILE" 2>/dev/null || echo "1")
    
    # Determine skill level and time-based greeting
    local skill_level=$(determine_skill_level "$total_coins" "$current_world")
    local time_period=$(get_time_period)
    
    # Analyze project structure
    readarray -t project_analysis < <(analyze_project_structure "$PARSED_WORKING_DIR")
    local suggestions_start_idx=-1
    local commands_start_idx=-1
    
    # Find section markers
    for i in "${!project_analysis[@]}"; do
        [[ "${project_analysis[$i]}" == "---SUGGESTIONS---" ]] && suggestions_start_idx=$((i + 1))
        [[ "${project_analysis[$i]}" == "---COMMANDS---" ]] && commands_start_idx=$((i + 1))
    done
    
    # Extract sections
    local project_types=()
    local suggestions=()
    local quick_commands=()
    
    if [[ $suggestions_start_idx -gt 0 ]]; then
        project_types=("${project_analysis[@]:0:$((suggestions_start_idx - 1))}")
        if [[ $commands_start_idx -gt 0 ]]; then
            suggestions=("${project_analysis[@]:$suggestions_start_idx:$((commands_start_idx - suggestions_start_idx - 1))}")
            quick_commands=("${project_analysis[@]:$commands_start_idx}")
        else
            suggestions=("${project_analysis[@]:$suggestions_start_idx}")
        fi
    else
        project_types=("${project_analysis[@]}")
    fi
    
    # Generate welcome message
    echo ""
    echo "🎊 ══════════════════════════════════════════════════════════ 🎊"
    echo "🍄              WELCOME TO THE MARIO POWERUP SYSTEM!              🍄"
    echo "🎊 ══════════════════════════════════════════════════════════ 🎊"
    echo ""
    
    # Time-based greeting
    echo "${TIME_GREETINGS[$time_period]}"
    echo ""
    
    # Skill level greeting
    echo "${LEVEL_GREETINGS[$skill_level]}"
    echo ""
    
    # Achievement status
    generate_achievement_status "$total_coins" "$current_streak" "$current_world" "$power_level"
    
    # Project analysis
    if [[ ${#project_types[@]} -gt 0 ]]; then
        echo ""
        echo "📁 Project Analysis:"
        printf '  🎯 Detected: %s\n' "${project_types[@]}"
    fi
    
    # Quick start menu with suggestions
    generate_quick_start_menu "${suggestions[@]}"
    
    # Additional quick commands if detected
    if [[ ${#quick_commands[@]} -gt 0 ]]; then
        echo ""
        echo "⚡ Smart Suggestions for This Project:"
        for cmd in "${quick_commands[@]}"; do
            echo "  $cmd"
        done
    fi
    
    echo ""
    echo "🌟 Ready to create legendary code? Let's-a-go! 🌟"
    echo ""
    
    # Log session start
    log_session_start "$PARSED_WORKING_DIR" "$(IFS=,; echo "${project_types[*]}")" "$skill_level"
}

# Execute main function with error handling
main "$@"