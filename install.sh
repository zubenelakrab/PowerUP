#!/bin/bash

# 🍄⭐ Mario Bros PowerUps Installer ⭐🍄
# Proper Claude Code integration with slash commands

echo "🍄⭐ Mario Bros PowerUps - Installation Starting ⭐🍄"
echo ""
echo "Installing Mario PowerUps to ~/.claude directory with proper slash commands..."
echo ""

# Create .claude directory structure if it doesn't exist
if [ ! -d "$HOME/.claude" ]; then
    echo "📁 Creating ~/.claude directory..."
    mkdir -p "$HOME/.claude"
fi

# Create commands directory for slash commands
if [ ! -d "$HOME/.claude/commands" ]; then
    echo "📁 Creating ~/.claude/commands directory..."
    mkdir -p "$HOME/.claude/commands"
fi

# Create agents directory for subagents
if [ ! -d "$HOME/.claude/agents" ]; then
    echo "📁 Creating ~/.claude/agents directory..."
    mkdir -p "$HOME/.claude/agents"
fi

# Create hooks directory for development hooks
if [ ! -d "$HOME/.claude/hooks" ]; then
    echo "📁 Creating ~/.claude/hooks directory..."
    mkdir -p "$HOME/.claude/hooks"
fi

# Check if PowerUps already exist
if [ -d "$HOME/.claude/powerups" ]; then
    echo "⚠️  Mario PowerUps already installed!"
    echo ""
    read -p "Do you want to overwrite the existing installation? (y/N): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "🚫 Installation cancelled."
        exit 0
    fi
    echo "🗑️  Removing existing PowerUps..."
    rm -rf "$HOME/.claude/powerups" "$HOME/.claude/orchestra" "$HOME/.claude/ULTIMATE_COMMAND_REFERENCE.md" 
    rm -f "$HOME/.claude/commands/mario-"* "$HOME/.claude/commands/luigi-"* "$HOME/.claude/commands/peach-"* "$HOME/.claude/commands/bowser-"* "$HOME/.claude/commands/dr-mario-"* "$HOME/.claude/commands/fire-trio"* "$HOME/.claude/commands/smart-builder"* "$HOME/.claude/commands/fortress"* "$HOME/.claude/commands/chaos-engine"*
    rm -f "$HOME/.claude/agents/mario-"* "$HOME/.claude/agents/luigi-"* "$HOME/.claude/agents/peach-"* "$HOME/.claude/agents/bowser-"* "$HOME/.claude/agents/dr-mario-"*
    rm -f "$HOME/.claude/hooks/mario-"* "$HOME/.claude/hooks/power-up-"* "$HOME/.claude/hooks/coin-collect"*
fi

# Copy PowerUps files
echo "📋 Installing Mario PowerUps files..."

# Copy powerups directory
if [ -d "powerups" ]; then
    cp -r powerups "$HOME/.claude/"
    echo "✅ Powerups directory installed"
else
    echo "❌ Error: powerups directory not found!"
    exit 1
fi

# Copy orchestra directory
if [ -d "orchestra" ]; then
    cp -r orchestra "$HOME/.claude/"
    echo "✅ Orchestra system installed"
else
    echo "❌ Error: orchestra directory not found!"
    exit 1
fi

# Copy command reference
if [ -f "ULTIMATE_COMMAND_REFERENCE.md" ]; then
    cp ULTIMATE_COMMAND_REFERENCE.md "$HOME/.claude/"
    echo "✅ Command reference installed"
else
    echo "❌ Error: ULTIMATE_COMMAND_REFERENCE.md not found!"
    exit 1
fi

# Copy main documentation files
if [ -f "CLAUDE.md" ]; then
    cp CLAUDE.md "$HOME/.claude/MARIO_POWERUPS_CLAUDE.md"
    echo "✅ Main documentation installed"
fi

if [ -f "README.md" ]; then
    cp README.md "$HOME/.claude/MARIO_POWERUPS_README.md"
    echo "✅ README installed"
fi

# Create slash commands
echo "🎮 Creating slash commands..."

# Helper function to create command file
create_command() {
    local cmd_name="$1"
    local display_name="$2" 
    local description="$3"
    local character_file="$4"
    
    cat > "$HOME/.claude/commands/$cmd_name.md" << EOF
---
name: $cmd_name
description: $description
---

# $display_name

$(cat "powerups/characters/$character_file" 2>/dev/null || echo "Character prompt for $display_name")
EOF
    echo "✅ /$cmd_name command created"
}

# Main character commands
create_command "mario-code" "🍄 Mario - Full Stack Hero" "Mario's enthusiastic coding implementation" "mario.md"
create_command "luigi-debug" "👻 Luigi - Debug Master" "Luigi's careful debugging and testing" "luigi.md"
create_command "peach-architect" "👸 Princess Peach - Architecture Queen" "Peach's elegant system architecture" "princess-peach.md"
create_command "bowser-optimize" "🐢 Bowser - Performance King" "Bowser's raw optimization power" "bowser.md"
create_command "dr-mario-checkup" "🩺 Dr. Mario - System Health" "Dr. Mario's system diagnostics" "dr-mario.md"

# Status and utility commands
cat > "$HOME/.claude/commands/mario-status.md" << 'EOF'
---
name: mario-status
description: Check your current Mario PowerUp status and progress
---

# 🍄⭐ Mario PowerUp Status Check ⭐🍄

Display current power level, coins collected, achievements unlocked, and available PowerUps. Show a summary of recent activities and suggest next steps for legendary development adventures.

**Status Report includes:**
- 🎮 Current power level and active abilities
- 🪙 Coins collected and achievements earned  
- 🍄 Available PowerUps and fusion teams
- 🌍 World progress and completed challenges
- 🎯 Suggested next adventures

*"Let's-a-check how legendary your coding journey has become!"* - Mario
EOF

cat > "$HOME/.claude/commands/mario-orchestra.md" << 'EOF'
---
name: mario-orchestra
description: Launch multi-agent AI Orchestra for complex collaborative tasks
---

# 🎼 Mario AI Orchestra - Multi-Agent Collaboration

Activate the complete AI Orchestra where legendary Mario characters collaborate in real-time to solve complex engineering challenges. This creates a symphony of intelligence where Mario, Luigi, Peach, Bowser, and other characters work together.

**How to use:**
Provide a complex challenge that requires multiple perspectives and approaches. The Orchestra will:

1. 🌟 **Rosalina** analyzes the system architecture and trade-offs
2. 🍄 **Mario** provides enthusiastic implementation strategies  
3. 👻 **Luigi** identifies edge cases and testing approaches
4. 👸 **Princess Peach** designs elegant user-facing solutions
5. 🐢 **Bowser** optimizes for raw performance and scale
6. 🩺 **Dr. Mario** ensures system health and reliability

The characters communicate and build upon each other's insights to create breakthrough solutions that transcend individual capabilities.

**Example usage:**
`/mario-orchestra "Design a real-time collaborative code editor with multiplayer features"`

*"When legendary characters unite their powers, they create symphonies of code!"* - Rosalina
EOF

echo "✅ Status and Orchestra commands created"

# Create subagents
echo "🤖 Creating Mario character subagents..."

# Helper function to create agent file
create_agent() {
    local agent_name="$1"
    local display_name="$2" 
    local description="$3"
    local character_file="$4"
    local tools="$5"
    
    cat > "$HOME/.claude/agents/$agent_name.md" << EOF
---
name: $agent_name
description: $description
tools: $tools
---

# $display_name

$(cat "powerups/characters/$character_file" 2>/dev/null || echo "Character prompt for $display_name")
EOF
    echo "✅ $agent_name subagent created"
}

# Create character subagents
create_agent "mario-hero" "🍄 Mario - Full Stack Hero" "Mario's enthusiastic coding and problem-solving" "mario.md" "Read, Write, Edit, Bash, Grep, Glob"
create_agent "luigi-debugger" "👻 Luigi - Debug Master" "Luigi's careful debugging and testing expertise" "luigi.md" "Read, Grep, Bash, Edit, Write"
create_agent "peach-architect" "👸 Princess Peach - Architecture Queen" "Peach's elegant system design and architecture" "princess-peach.md" "Read, Write, Edit, Grep, Glob"
create_agent "bowser-optimizer" "🐢 Bowser - Performance King" "Bowser's raw optimization and performance tuning" "bowser.md" "Read, Edit, Bash, Grep, Write"
create_agent "dr-mario-diagnostics" "🩺 Dr. Mario - System Health" "Dr. Mario's system diagnostics and health monitoring" "dr-mario.md" "Read, Bash, Grep, Edit, Write"

# Create comprehensive Mario development hooks
echo "🪝 Creating Mario PowerUp Hook System..."

# 🪙 Coin Collection & Achievement Hook (Post-Tool)
cat > "$HOME/.claude/hooks/coin-collector.sh" << 'EOF'
#!/bin/bash
# 🪙 Mario Coin Collection System
# Celebrates successful tool usage and tracks achievements

TOOL_NAME="$1"
STATUS="$2"
TOOL_INPUT="$3"

if [ "$STATUS" = "success" ]; then
    # Track coins in persistent file
    COIN_FILE="$HOME/.claude/mario-coins.txt"
    STREAK_FILE="$HOME/.claude/mario-streak.txt"
    WORLD_FILE="$HOME/.claude/mario-world-progress.txt"
    
    # Initialize files if they don't exist
    [ ! -f "$COIN_FILE" ] && echo "0" > "$COIN_FILE"
    [ ! -f "$STREAK_FILE" ] && echo "0" > "$STREAK_FILE" 
    [ ! -f "$WORLD_FILE" ] && echo "1-1" > "$WORLD_FILE"
    
    # Update coins and streak
    COINS=$(cat "$COIN_FILE")
    STREAK=$(cat "$STREAK_FILE")
    COINS=$((COINS + 1))
    STREAK=$((STREAK + 1))
    echo "$COINS" > "$COIN_FILE"
    echo "$STREAK" > "$STREAK_FILE"
    
    # Celebrate based on achievement level
    if [ $((COINS % 100)) -eq 0 ]; then
        echo "🌟 *VICTORY FANFARE* 1-UP! You've collected $COINS coins!"
        echo "👑 LEGENDARY DEVELOPER STATUS ACHIEVED!"
        echo "🏰 Welcome to Bowser's Castle - Enterprise Level Unlocked!"
    elif [ $((COINS % 50)) -eq 0 ]; then
        echo "⭐ *power-up music* SUPER MARIO! $COINS coins collected!"
        echo "🍄 You've grown bigger and stronger as a developer!"
    elif [ $((COINS % 10)) -eq 0 ]; then
        echo "✨ *coin chime* Nice work! $COINS coins collected!"
        echo "🎮 Your coding power is growing legendary!"
    else
        echo "🪙 *ding* Coin collected! ($COINS total) Great $TOOL_NAME usage!"
    fi
    
    # Special streak celebrations
    if [ $STREAK -ge 10 ]; then
        echo "⭐ STAR POWER ACTIVATED! $STREAK consecutive successes!"
        echo "🌟 You're INVINCIBLE! Nothing can stop you now!"
    elif [ $STREAK -ge 5 ]; then
        echo "🔥 Fire Flower Power! $STREAK in a row! You're on fire!"
    fi
    
    # World progression based on coin milestones
    if [ $COINS -ge 800 ]; then
        echo "8-1" > "$WORLD_FILE"
        echo "🏰 Bowser's Castle! You've reached the final challenge!"
    elif [ $COINS -ge 400 ]; then
        echo "4-1" > "$WORLD_FILE"
        echo "👻 Ghost House! Time for some spooky debugging!"
    elif [ $COINS -ge 200 ]; then
        echo "3-1" > "$WORLD_FILE"  
        echo "🌊 Water World! Diving deep into algorithms!"
    elif [ $COINS -ge 100 ]; then
        echo "2-1" > "$WORLD_FILE"
        echo "🏜️ Desert Land! Surviving the debugging wasteland!"
    fi
else
    # Reset streak on failure but stay encouraging
    echo "0" > "$STREAK_FILE"
    echo "💚 Don't worry! Even Mario loses a life sometimes!"
    echo "🍄 Try again, hero! You've got this!"
fi
EOF

chmod +x "$HOME/.claude/hooks/coin-collector.sh"
echo "✅ Coin collection system created"

# 🛡️ Mario Safety Guardian Hook (Pre-Tool)
cat > "$HOME/.claude/hooks/mario-safety-guardian.sh" << 'EOF'
#!/bin/bash
# 🛡️ Mario Safety Guardian System
# Protective wisdom before dangerous operations

TOOL_NAME="$1"
TOOL_INPUT="$2"

# Dangerous bash command detection
if [ "$TOOL_NAME" = "Bash" ]; then
    if echo "$TOOL_INPUT" | grep -q -E "(rm -rf|sudo.*rm|format|mkfs|dd if=|>.*passwd|chmod 777|>.*hosts)"; then
        echo "⚠️  🍄 MARIO SAYS: 'Mamma mia! That looks dangerous!'"
        echo "🎮 Remember: With great power comes great responsibility!"
        echo "🛡️  Double-check your command before proceeding, hero!"
        echo "💡 Tip: Test dangerous commands in a safe environment first!"
    elif echo "$TOOL_INPUT" | grep -q -E "(git push.*force|git reset.*hard|npm publish)"; then
        echo "🚨 Luigi whispers: 'That could affect others! Are you sure?'"
        echo "👻 Consider the consequences, my friend!"
    fi
fi

# Encourage good practices
if [ "$TOOL_NAME" = "Write" ] || [ "$TOOL_NAME" = "Edit" ]; then
    echo "✨ Princess Peach suggests: 'Remember to test your elegant changes!'"
elif [ "$TOOL_NAME" = "Bash" ] && echo "$TOOL_INPUT" | grep -q "npm install\|pip install"; then
    echo "🍄 Toad's tip: 'Great choice! Adding new power-ups to your toolkit!'"
fi
EOF

chmod +x "$HOME/.claude/hooks/mario-safety-guardian.sh" 
echo "✅ Mario safety guardian created"

# 🎮 Git Operations Hook (Koopa Troopa Precision)
cat > "$HOME/.claude/hooks/koopa-troopa-git.sh" << 'EOF'
#!/bin/bash
# 🐢 Koopa Troopa Git Operations Hook
# Celebrates git mastery with shell-like precision

TOOL_NAME="$1"
STATUS="$2"
TOOL_INPUT="$3"

if [ "$TOOL_NAME" = "Bash" ] && echo "$TOOL_INPUT" | grep -q "git"; then
    if [ "$STATUS" = "success" ]; then
        if echo "$TOOL_INPUT" | grep -q "git commit"; then
            echo "🐢 *shell sound* Excellent commit precision!"
            echo "⚡ Your git-fu grows stronger with each shell maneuver!"
        elif echo "$TOOL_INPUT" | grep -q "git push"; then
            echo "🚀 Koopa Troopa launch sequence complete!"
            echo "📡 Code successfully delivered to the cloud kingdom!"
        elif echo "$TOOL_INPUT" | grep -q "git pull"; then
            echo "🔄 Koopa shell spin! Fresh code retrieved!"
            echo "🌟 Your local kingdom is now synchronized!"
        fi
    fi
fi
EOF

chmod +x "$HOME/.claude/hooks/koopa-troopa-git.sh"
echo "✅ Koopa Troopa git operations hook created"

# 🦕 Yoshi Testing Encouragement Hook
cat > "$HOME/.claude/hooks/yoshi-test-runner.sh" << 'EOF'
#!/bin/bash
# 🦕 Yoshi Testing Encouragement System
# Supportive testing companion

TOOL_NAME="$1" 
STATUS="$2"
TOOL_INPUT="$3"

if [ "$TOOL_NAME" = "Bash" ] && echo "$TOOL_INPUT" | grep -q -E "(test|jest|pytest|npm test|yarn test|go test)"; then
    if [ "$STATUS" = "success" ]; then
        echo "🦕 *happy Yoshi sound* Yoshi is proud of your testing!"
        echo "🥚 All tests hatched successfully! Great job, friend!"
        echo "🌟 Your code is as reliable as Yoshi's flutter jump!"
    else
        echo "🦕 *concerned Yoshi sound* Don't worry! Even Yoshi falls off platforms!"
        echo "💚 Yoshi believes in you! Try again, we can fix this together!"
        echo "🎯 Every failed test is a lesson learned!"
    fi
fi
EOF

chmod +x "$HOME/.claude/hooks/yoshi-test-runner.sh"
echo "✅ Yoshi testing companion created"

# 🐢 Bowser Performance Optimization Hook
cat > "$HOME/.claude/hooks/bowser-performance.sh" << 'EOF'
#!/bin/bash
# 🐢 Bowser Performance Domination System
# Raw optimization power tracking

TOOL_NAME="$1"
STATUS="$2"
TOOL_INPUT="$3"

# Detect performance-related commands
if echo "$TOOL_INPUT" | grep -q -E "(optimize|performance|benchmark|profil|speed|fast|cache|index)"; then
    if [ "$STATUS" = "success" ]; then
        echo "🐢 GRAAAHHH! BOWSER APPROVES OF YOUR OPTIMIZATION!"
        echo "⚡ This system is now 23% more POWERFUL!"
        echo "🔥 NOTHING can slow down this LEGENDARY performance!"
        echo "👑 You've earned Bowser's respect through raw optimization power!"
    fi
fi

# Build process celebrations
if [ "$TOOL_NAME" = "Bash" ] && echo "$TOOL_INPUT" | grep -q -E "(build|compile|webpack|rollup)"; then
    if [ "$STATUS" = "success" ]; then
        echo "🏗️  CASTLE CONSTRUCTION COMPLETE!"
        echo "🐢 Bowser's engineers approve of this solid build!"
    fi
fi
EOF

chmod +x "$HOME/.claude/hooks/bowser-performance.sh"
echo "✅ Bowser performance system created"

# Create settings.json with hook configuration
echo "⚙️  Configuring Mario PowerUp hooks..."

SETTINGS_FILE="$HOME/.claude/settings.json"
BACKUP_FILE="$HOME/.claude/settings.json.mario-backup"

# Backup existing settings if they exist
if [ -f "$SETTINGS_FILE" ]; then
    cp "$SETTINGS_FILE" "$BACKUP_FILE"
    echo "📋 Existing settings backed up to settings.json.mario-backup"
fi

# Create or update settings.json with comprehensive Mario hooks
cat > "$SETTINGS_FILE" << 'EOF'
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": ".*",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/coin-collector.sh \"{{tool_name}}\" \"{{status}}\" \"{{tool_input}}\""
          }
        ]
      },
      {
        "matcher": "Bash.*git.*",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/koopa-troopa-git.sh \"{{tool_name}}\" \"{{status}}\" \"{{tool_input}}\""
          }
        ]
      },
      {
        "matcher": "Bash.*(test|jest|pytest).*",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/yoshi-test-runner.sh \"{{tool_name}}\" \"{{status}}\" \"{{tool_input}}\""
          }
        ]
      },
      {
        "matcher": "Bash.*(optimize|performance|build).*",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/bowser-performance.sh \"{{tool_name}}\" \"{{status}}\" \"{{tool_input}}\""
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash.*",
        "hooks": [
          {
            "type": "command", 
            "command": "$HOME/.claude/hooks/mario-safety-guardian.sh \"{{tool_name}}\" \"{{tool_input}}\""
          }
        ]
      }
    ]
  },
  "mario_powerups": {
    "version": "2.0.0",
    "characters_enabled": true,
    "coin_collection": true,
    "safety_checks": true,
    "achievement_system": true,
    "world_progression": true,
    "streak_tracking": true,
    "workflow_hooks": true
  }
}
EOF

echo "✅ Mario PowerUp hooks configured in settings.json"

echo ""
echo "🎉 Mario Bros PowerUps Installation Complete! 🎉"
echo ""
echo "📁 Installed to: ~/.claude/"
echo "🎭 Characters: $(ls -1 "$HOME/.claude/powerups/characters/" | wc -l) legendary characters ready"
echo "🌍 Worlds: $(ls -1 "$HOME/.claude/powerups/worlds/" | wc -l) adventure worlds available"
echo "🎁 Items: $(ls -1 "$HOME/.claude/powerups/items/" | wc -l) magical items unlocked"
echo "🎼 Orchestra: Multi-agent AI collaboration system active"
echo "⚡ Slash Commands: $(ls -1 "$HOME/.claude/commands/"mario-* 2>/dev/null | wc -l) commands installed"
echo "🤖 Subagents: $(ls -1 "$HOME/.claude/agents/"mario-* "$HOME/.claude/agents/"luigi-* "$HOME/.claude/agents/"peach-* "$HOME/.claude/agents/"bowser-* "$HOME/.claude/agents/"dr-mario-* 2>/dev/null | wc -l) characters available"
echo "🪝 Hooks: $(ls -1 "$HOME/.claude/hooks/"*.sh 2>/dev/null | wc -l) interactive development hooks active"
echo ""
echo "🎮 Quick Start:"
echo "   Slash Commands:"
echo "     /mario-code - 🍄 Mario's enthusiastic coding"
echo "     /luigi-debug - 👻 Luigi's careful debugging"  
echo "     /peach-architect - 👸 Peach's elegant architecture"
echo "     /bowser-optimize - 🐢 Bowser's performance power"
echo "     /dr-mario-checkup - 🩺 Dr. Mario's system health"
echo "     /mario-status - Check your PowerUp status"
echo "     /mario-orchestra - Launch multi-agent collaboration"
echo ""
echo "   Subagents (use with Task tool):"
echo "     mario-hero - Full-stack problem solving"
echo "     luigi-debugger - Expert debugging and testing"
echo "     peach-architect - Elegant system architecture"
echo "     bowser-optimizer - Raw performance optimization"
echo "     dr-mario-diagnostics - System health monitoring"
echo ""
echo "   🪙 Coin Collection: Earn coins, track streaks, and progress through 8 worlds!"
echo "   🛡️  Safety Guardian: Mario protects you from dangerous commands!"
echo "   🎮 Workflow Hooks: Git celebrations, testing support, performance tracking!"
echo "   🌟 Achievement System: Milestones, streaks, and legendary status unlocks!"
echo ""
echo "📚 Full Command Reference: ~/.claude/ULTIMATE_COMMAND_REFERENCE.md"
echo ""
echo "🍄⭐ Let's-a-go code with the complete Mario PowerUp system! ⭐🍄"