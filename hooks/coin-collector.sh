#!/bin/bash
# Professional Development Achievement Tracking System
# Tracks successful tool usage and provides motivation through gamification
# Part of the Mario PowerUps professional development framework

# Parse JSON input from Claude Code hook system (proper format)
# Read JSON from stdin and parse using Python
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; data = json.loads(sys.stdin.read()); print(data.get('tool_name', ''))")
TOOL_RESPONSE=$(echo "$INPUT" | python3 -c "import sys, json; data = json.loads(sys.stdin.read()); print(data.get('tool_response', {}))" 2>/dev/null || echo "{}")

# Check if the tool operation was successful
SUCCESS=$(echo "$TOOL_RESPONSE" | python3 -c "import sys, json; response = json.loads(sys.stdin.read() if sys.stdin.read() else '{}'); print('true' if response else 'true')" 2>/dev/null || echo "true")

if [ "$SUCCESS" = "true" ]; then
    # Configuration: Achievement tracking file locations
    # These files persist across sessions to maintain development progress
    ACHIEVEMENT_DIR="$HOME/.claude/achievements"
    COIN_FILE="$ACHIEVEMENT_DIR/total-achievements.txt"
    STREAK_FILE="$ACHIEVEMENT_DIR/current-streak.txt"
    WORLD_FILE="$ACHIEVEMENT_DIR/skill-level.txt"
    
    # Ensure achievement directory exists with proper permissions
    mkdir -p "$ACHIEVEMENT_DIR"
    
    # Initialize tracking files with default values if they don't exist
    [ ! -f "$COIN_FILE" ] && echo "0" > "$COIN_FILE"
    [ ! -f "$STREAK_FILE" ] && echo "0" > "$STREAK_FILE" 
    [ ! -f "$WORLD_FILE" ] && echo "beginner" > "$WORLD_FILE"
    
    # Read current achievement counters safely
    TOTAL_ACHIEVEMENTS=$(cat "$COIN_FILE" 2>/dev/null || echo "0")
    CURRENT_STREAK=$(cat "$STREAK_FILE" 2>/dev/null || echo "0")
    
    # Increment achievement counters atomically
    TOTAL_ACHIEVEMENTS=$((TOTAL_ACHIEVEMENTS + 1))
    CURRENT_STREAK=$((CURRENT_STREAK + 1))
    
    # Write updated counters back to files
    echo "$TOTAL_ACHIEVEMENTS" > "$COIN_FILE"
    echo "$CURRENT_STREAK" > "$STREAK_FILE"
    
    # Celebrate based on achievement level
    if [ $((TOTAL_ACHIEVEMENTS % 100)) -eq 0 ]; then
        echo "🌟 *VICTORY FANFARE* 1-UP! You've collected $TOTAL_ACHIEVEMENTS coins!"
        echo "👑 LEGENDARY DEVELOPER STATUS ACHIEVED!"
        echo "🏰 Welcome to Bowser's Castle - Enterprise Level Unlocked!"
    elif [ $((TOTAL_ACHIEVEMENTS % 50)) -eq 0 ]; then
        echo "⭐ *power-up music* SUPER MARIO! $TOTAL_ACHIEVEMENTS coins collected!"
        echo "🍄 You've grown bigger and stronger as a developer!"
    elif [ $((TOTAL_ACHIEVEMENTS % 10)) -eq 0 ]; then
        echo "✨ *coin chime* Nice work! $TOTAL_ACHIEVEMENTS coins collected!"
        echo "🎮 Your coding power is growing legendary!"
    else
        echo "🪙 *ding* Coin collected! ($TOTAL_ACHIEVEMENTS total) Great $TOOL_NAME usage!"
    fi
    
    # Special streak celebrations
    if [ $CURRENT_STREAK -ge 10 ]; then
        echo "⭐ STAR POWER ACTIVATED! $CURRENT_STREAK consecutive successes!"
        echo "🌟 You're INVINCIBLE! Nothing can stop you now!"
    elif [ $CURRENT_STREAK -ge 5 ]; then
        echo "🔥 Fire Flower Power! $CURRENT_STREAK in a row! You're on fire!"
    fi
    
    # World progression based on coin milestones
    if [ $TOTAL_ACHIEVEMENTS -ge 800 ]; then
        echo "8-1" > "$WORLD_FILE"
        echo "🏰 Bowser's Castle! You've reached the final challenge!"
    elif [ $TOTAL_ACHIEVEMENTS -ge 400 ]; then
        echo "4-1" > "$WORLD_FILE"
        echo "👻 Ghost House! Time for some spooky debugging!"
    elif [ $TOTAL_ACHIEVEMENTS -ge 200 ]; then
        echo "3-1" > "$WORLD_FILE"  
        echo "🌊 Water World! Diving deep into algorithms!"
    elif [ $TOTAL_ACHIEVEMENTS -ge 100 ]; then
        echo "2-1" > "$WORLD_FILE"
        echo "🏜️ Desert Land! Surviving the debugging wasteland!"
    fi
else
    # Reset streak on failure but stay encouraging
    echo "0" > "$STREAK_FILE"
    echo "💚 Don't worry! Even Mario loses a life sometimes!"
    echo "🍄 Try again, hero! You've got this!"
fi
