#!/bin/bash
# 🪙⭐ Mario PowerUp Coin Collection System - Advanced Achievement Tracker ⭐🪙
# Professional gamification system using proper Claude Code JSON hook protocol
# Tracks multi-dimensional progress across Mario worlds with persistent achievements

# Security and error handling
set -euo pipefail

# Constants for the Mario universe
readonly ACHIEVEMENT_DIR="$HOME/.claude/achievements"
readonly COIN_FILE="$ACHIEVEMENT_DIR/total-coins.txt" 
readonly STREAK_FILE="$ACHIEVEMENT_DIR/current-streak.txt"
readonly WORLD_FILE="$ACHIEVEMENT_DIR/current-world.txt"
readonly LEVEL_FILE="$ACHIEVEMENT_DIR/power-level.txt"
readonly STATS_FILE="$ACHIEVEMENT_DIR/tool-usage-stats.json"
readonly LOG_FILE="$ACHIEVEMENT_DIR/achievement-log.txt"

# Tool scoring system - different tools award different points
declare -A TOOL_SCORES=(
    ["Write"]=10         # Creating new content
    ["Edit"]=5           # Modifying existing content  
    ["MultiEdit"]=15     # Complex multi-file operations
    ["Bash"]=8           # Command execution
    ["Task"]=25          # Subagent collaboration
    ["Read"]=2           # Learning and exploration
    ["Grep"]=3           # Code investigation
    ["Glob"]=3           # File discovery
    ["WebFetch"]=5       # External research
    ["WebSearch"]=5      # Information gathering
)

# Achievement thresholds for different celebration levels
declare -A ACHIEVEMENT_LEVELS=(
    [1000]="🏰 Bowser's Castle - Enterprise Mastery!"
    [500]="👻 Ghost House - Advanced Debugging!"
    [250]="🌊 Water World - Algorithm Depths!"
    [100]="🏜️ Desert Land - Testing Wasteland!"
    [50]="🌋 Volcano - Performance Optimization!"
)

# Utility functions
log_achievement() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> "$LOG_FILE"
}

create_achievement_dir() {
    if [[ ! -d "$ACHIEVEMENT_DIR" ]]; then
        mkdir -p "$ACHIEVEMENT_DIR"
        chmod 700 "$ACHIEVEMENT_DIR"  # Secure permissions
        log_achievement "Achievement directory initialized"
    fi
}

initialize_files() {
    [[ ! -f "$COIN_FILE" ]] && echo "0" > "$COIN_FILE"
    [[ ! -f "$STREAK_FILE" ]] && echo "0" > "$STREAK_FILE"
    [[ ! -f "$WORLD_FILE" ]] && echo "1-1" > "$WORLD_FILE"
    [[ ! -f "$LEVEL_FILE" ]] && echo "1" > "$LEVEL_FILE"
    [[ ! -f "$STATS_FILE" ]] && echo '{}' > "$STATS_FILE"
    [[ ! -f "$LOG_FILE" ]] && touch "$LOG_FILE"
}

parse_json_input() {
    local json_input="$1"
    
    # Use Python for robust JSON parsing
    python3 << EOF
import json, sys, os
try:
    data = json.loads('''$json_input''')
    
    # Extract relevant data
    tool_name = data.get('tool_name', '')
    tool_response = data.get('tool_response', {})
    hook_event = data.get('hook_event_name', '')
    
    # Determine success based on tool response
    success = True
    if isinstance(tool_response, dict):
        success = tool_response.get('success', True)
        # Also check for common success indicators
        if 'error' in tool_response or 'failed' in str(tool_response).lower():
            success = False
    
    # Output parsed data as environment variables
    print(f"export PARSED_TOOL_NAME='{tool_name}'")
    print(f"export PARSED_SUCCESS='{str(success).lower()}'")
    print(f"export PARSED_HOOK_EVENT='{hook_event}'")
    
    # Additional context extraction
    if 'tool_input' in data:
        tool_input = data['tool_input']
        if isinstance(tool_input, dict):
            file_path = tool_input.get('file_path', tool_input.get('filePath', ''))
            command = tool_input.get('command', '')
            print(f"export PARSED_FILE_PATH='{file_path}'")
            print(f"export PARSED_COMMAND='{command[:50]}'")  # First 50 chars for privacy
        
except json.JSONDecodeError as e:
    print(f"export PARSED_TOOL_NAME='unknown'", file=sys.stderr)
    print(f"export PARSED_SUCCESS='false'", file=sys.stderr)
    sys.exit(1)
except Exception as e:
    print(f"export PARSED_TOOL_NAME='unknown'", file=sys.stderr) 
    print(f"export PARSED_SUCCESS='false'", file=sys.stderr)
    sys.exit(1)
EOF
}

update_tool_statistics() {
    local tool_name="$1"
    local success="$2"
    
    python3 << EOF
import json
import os

stats_file = "$STATS_FILE"
tool_name = "$tool_name"
success = "$success" == "true"

try:
    with open(stats_file, 'r') as f:
        stats = json.load(f)
except:
    stats = {}

if tool_name not in stats:
    stats[tool_name] = {"total": 0, "success": 0, "failure": 0}

stats[tool_name]["total"] += 1
if success:
    stats[tool_name]["success"] += 1
else:
    stats[tool_name]["failure"] += 1

with open(stats_file, 'w') as f:
    json.dump(stats, f, indent=2)
EOF
}

calculate_coins_awarded() {
    local tool_name="$1"
    local base_score=${TOOL_SCORES[$tool_name]:-5}  # Default 5 coins
    
    # Bonus calculations
    local bonus=0
    
    # Language detection bonus (if file extension detected)
    if [[ -n "$PARSED_FILE_PATH" ]]; then
        case "$PARSED_FILE_PATH" in
            *.py) bonus=$((bonus + 2)) ;;      # Python
            *.js|*.ts|*.tsx|*.jsx) bonus=$((bonus + 2)) ;;  # JavaScript/TypeScript
            *.rs) bonus=$((bonus + 3)) ;;      # Rust (advanced language)
            *.go) bonus=$((bonus + 3)) ;;      # Go 
            *.c|*.cpp|*.cc) bonus=$((bonus + 4)) ;; # C/C++ (system programming)
            *.hs) bonus=$((bonus + 4)) ;;      # Haskell (functional programming)
        esac
    fi
    
    # Streak bonus
    local current_streak=$(cat "$STREAK_FILE" 2>/dev/null || echo "0")
    if [[ $current_streak -ge 10 ]]; then
        bonus=$((bonus + 5))  # Star power bonus
    elif [[ $current_streak -ge 5 ]]; then
        bonus=$((bonus + 2))  # Fire flower bonus  
    fi
    
    echo $((base_score + bonus))
}

determine_world_and_level() {
    local total_coins="$1"
    local world="1-1"
    local level=1
    
    if [[ $total_coins -ge 1000 ]]; then
        world="8-1"; level=50    # Bowser's Castle - Master Developer
    elif [[ $total_coins -ge 500 ]]; then
        world="7-1"; level=35    # Sky Land - Senior Developer  
    elif [[ $total_coins -ge 300 ]]; then
        world="6-1"; level=28    # Ice Land - Advanced Developer
    elif [[ $total_coins -ge 200 ]]; then
        world="5-1"; level=22    # Giant Land - Intermediate Developer
    elif [[ $total_coins -ge 100 ]]; then
        world="4-1"; level=16    # Ghost House - Junior Developer+
    elif [[ $total_coins -ge 50 ]]; then
        world="3-1"; level=12    # Water World - Junior Developer
    elif [[ $total_coins -ge 25 ]]; then
        world="2-1"; level=8     # Desert Land - Apprentice
    else
        world="1-1"; level=$((total_coins / 5 + 1))  # Grass Land - Beginner
    fi
    
    echo "$world"
    echo "$level" > "$LEVEL_FILE"
}

generate_celebration() {
    local tool_name="$1"
    local coins_awarded="$2"  
    local total_coins="$3"
    local current_streak="$4"
    local world="$5"
    
    # Major milestone celebrations
    for threshold in $(printf '%s\n' "${!ACHIEVEMENT_LEVELS[@]}" | sort -nr); do
        if [[ $total_coins -ge $threshold ]] && [[ $((total_coins - coins_awarded)) -lt $threshold ]]; then
            echo ""
            echo "🎊 ═══════════════════════════════════════ 🎊"
            echo "🌟        MAJOR ACHIEVEMENT UNLOCKED!        🌟"  
            echo "🎊 ═══════════════════════════════════════ 🎊"
            echo ""
            echo "${ACHIEVEMENT_LEVELS[$threshold]}"
            echo "💰 Total Coins: $total_coins"
            echo "⭐ Power Level: $(cat "$LEVEL_FILE")"
            echo ""
            echo "🎵 *VICTORY FANFARE* 🎵"
            echo ""
            log_achievement "MAJOR_MILESTONE: $total_coins coins - ${ACHIEVEMENT_LEVELS[$threshold]}"
            return
        fi
    done
    
    # Regular celebrations based on milestones
    if [[ $((total_coins % 100)) -eq 0 ]] && [[ $total_coins -gt 0 ]]; then
        echo "🌟 ⭐ CENTURY CLUB! ⭐ 🌟"
        echo "👑 $total_coins coins collected! You're becoming legendary!"
        echo "🎮 Current World: $world | Power Level: $(cat "$LEVEL_FILE")"
    elif [[ $((total_coins % 50)) -eq 0 ]] && [[ $total_coins -gt 0 ]]; then
        echo "✨ 🍄 SUPER MARIO! 🍄 ✨"
        echo "⚡ $total_coins coins! You've powered up significantly!"
        echo "🌍 World: $world | Level: $(cat "$LEVEL_FILE")"
    elif [[ $((total_coins % 25)) -eq 0 ]] && [[ $total_coins -gt 0 ]]; then
        echo "🎯 Quarter Century Achievement! $total_coins coins collected!"
        echo "🚀 Your coding skills are growing legendary!"
    elif [[ $((total_coins % 10)) -eq 0 ]] && [[ $total_coins -gt 0 ]]; then
        echo "✨ *coin chime* Nice milestone! $total_coins coins total!"
        echo "🎮 Keep up the excellent work!"
    else
        # Standard coin collection
        echo "🪙 *ding* +$coins_awarded coins! ($total_coins total) | Great $tool_name usage!"
    fi
    
    # Streak celebrations  
    if [[ $current_streak -ge 20 ]]; then
        echo "🌟 ⚡ INVINCIBILITY STAR! ⚡ 🌟"
        echo "🔥 $current_streak consecutive successes! YOU ARE UNSTOPPABLE!"
    elif [[ $current_streak -ge 10 ]]; then
        echo "⭐ STAR POWER ACTIVATED! $current_streak in a row!"
        echo "🌟 Nothing can stop you now! Invincible!"
    elif [[ $current_streak -ge 5 ]]; then
        echo "🔥 Fire Flower Power! $current_streak successes!"
        echo "🌸 You're blazing through challenges!"
    fi
}

# Main execution
main() {
    local input_data
    input_data=$(cat)
    
    # Initialize system
    create_achievement_dir
    initialize_files
    
    # Parse JSON input using the official Claude Code format
    if ! eval "$(parse_json_input "$input_data")"; then
        echo "❌ Error parsing hook input" >&2
        exit 1
    fi
    
    # Only process PostToolUse events
    if [[ "$PARSED_HOOK_EVENT" != "PostToolUse" ]]; then
        exit 0  # Silently ignore non-PostToolUse events
    fi
    
    # Update tool usage statistics
    update_tool_statistics "$PARSED_TOOL_NAME" "$PARSED_SUCCESS"
    
    # Process successful operations
    if [[ "$PARSED_SUCCESS" == "true" ]]; then
        # Read current stats
        local total_coins
        local current_streak
        total_coins=$(cat "$COIN_FILE" 2>/dev/null || echo "0")
        current_streak=$(cat "$STREAK_FILE" 2>/dev/null || echo "0")
        
        # Calculate coins awarded
        local coins_awarded
        coins_awarded=$(calculate_coins_awarded "$PARSED_TOOL_NAME")
        
        # Update totals
        total_coins=$((total_coins + coins_awarded))
        current_streak=$((current_streak + 1))
        
        # Persist updates
        echo "$total_coins" > "$COIN_FILE"
        echo "$current_streak" > "$STREAK_FILE"
        
        # Determine world progression
        local new_world
        new_world=$(determine_world_and_level "$total_coins")
        echo "$new_world" > "$WORLD_FILE"
        
        # Generate celebration
        generate_celebration "$PARSED_TOOL_NAME" "$coins_awarded" "$total_coins" "$current_streak" "$new_world"
        
        # Log the achievement
        log_achievement "SUCCESS: $PARSED_TOOL_NAME (+$coins_awarded coins, $total_coins total, $current_streak streak)"
        
    else
        # Handle failures gracefully
        echo "0" > "$STREAK_FILE"  # Reset streak
        echo "💚 Don't worry! Even Mario needs extra lives sometimes!"
        echo "🍄 Try again, legendary developer! You've got this!"
        echo "🎮 Failure is just another step toward mastery!"
        
        log_achievement "RESET: $PARSED_TOOL_NAME failed, streak reset"
    fi
}

# Execute main function with error handling
main "$@"