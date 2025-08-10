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

# Copy agents (subagents)
if [ -d "claude-config/agents" ]; then
    cp -r claude-config/agents/* "$HOME/.claude/agents/"
    echo "✅ Mario character subagents installed"
else
    echo "❌ Error: claude-config/agents directory not found!"
    exit 1
fi

# Copy commands (slash commands)  
if [ -d "claude-config/commands" ]; then
    cp -r claude-config/commands/* "$HOME/.claude/commands/"
    echo "✅ Mario slash commands installed"
else
    echo "❌ Error: claude-config/commands directory not found!"
    exit 1
fi

# Copy hooks (development hooks)
if [ -d "claude-config/hooks" ]; then
    cp -r claude-config/hooks/* "$HOME/.claude/hooks/"
    chmod +x "$HOME/.claude/hooks/"*.sh
    echo "✅ Mario development hooks installed"
else
    echo "❌ Error: claude-config/hooks directory not found!"
    exit 1
fi

# Copy powerups directory (legacy support)
if [ -d "powerups" ]; then
    cp -r powerups "$HOME/.claude/"
    echo "✅ Powerups directory installed"
fi

# Copy orchestra directory (legacy support)
if [ -d "orchestra" ]; then
    cp -r orchestra "$HOME/.claude/"
    echo "✅ Orchestra system installed"
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
echo "🎮 Creating intelligent multi-language slash commands..."

# Copy language detection service
if [ -f "language-detection-service.js" ]; then
    cp "language-detection-service.js" "$HOME/.claude/"
    chmod +x "$HOME/.claude/language-detection-service.js"
    echo "✅ Language detection service installed"
fi

# Copy i18n detection service
if [ -f "i18n-detection-service.js" ]; then
    cp "i18n-detection-service.js" "$HOME/.claude/"
    chmod +x "$HOME/.claude/i18n-detection-service.js"
    echo "✅ i18n detection service installed"
fi

# Copy essential documentation files directly to .claude
if [ -f "docs/reasoning-framework.md" ]; then
    cp "docs/reasoning-framework.md" "$HOME/.claude/"
    echo "✅ Reasoning framework documentation installed"
fi

if [ -f "docs/professional-code-guidelines.md" ]; then
    cp "docs/professional-code-guidelines.md" "$HOME/.claude/"
    echo "✅ Professional code guidelines installed"
fi

# Helper function to create intelligent command file
create_command() {
    local cmd_name="$1"
    local display_name="$2" 
    local description="$3"
    local character_file="$4"
    
    cat > "$HOME/.claude/commands/$cmd_name.md" << EOF
---
name: $cmd_name
description: $description with intelligent multi-language support
---

# $display_name - Intelligent Multi-Language Support

🧠 **Automatic Language Detection**: This command automatically detects programming languages from your input and provides specialized assistance across 70+ languages.

**Usage Examples:**
\`\`\`
/$cmd_name "create a REST API with authentication"
# → Auto-detects backend → Routes to appropriate specialist

/$cmd_name:python "implement user authentication system"  
# → Explicit Python → Routes to Python specialist

/$cmd_name --file="src/component.tsx" "optimize this code"
# → Detects TypeScript React → Routes to React specialist
\`\`\`

## Character Expertise Integration:

$(cat "powerups/characters/$character_file" 2>/dev/null || echo "Character prompt for $display_name")

## 🌍 **Supported Languages & Technologies:**

### 🌐 **Frontend Development**
- **Languages**: HTML, CSS, JavaScript, TypeScript, JSX, TSX  
- **Frameworks**: React, Vue, Angular, Svelte, Next.js, Nuxt.js
- **Styling**: Sass, SCSS, Tailwind CSS, Styled Components

### 🔧 **Backend Development**  
- **Languages**: Python, Node.js, Java, C#, Go, Rust, PHP, Ruby, Scala, Elixir
- **Frameworks**: Express, Django, Flask, Spring, Laravel, Rails, FastAPI

### 📱 **Mobile Development**
- **Languages**: Kotlin, Swift, Dart, Java, C#, JavaScript
- **Frameworks**: Flutter, React Native, Xamarin, Ionic, Cordova

### 📊 **Data Science & Analytics**
- **Languages**: Python, R, Julia, SQL, Scala, MATLAB
- **Libraries**: Pandas, NumPy, TensorFlow, PyTorch, Scikit-learn

### ⚡ **Systems Programming**
- **Languages**: C, C++, Rust, Go, Zig, Assembly, Fortran
- **Areas**: Embedded systems, Kernel development, Performance optimization

### 🚀 **DevOps & Infrastructure**
- **Languages**: Bash, PowerShell, YAML, Terraform, Ansible
- **Platforms**: Docker, Kubernetes, AWS, GCP, Azure, Jenkins

### 🧮 **Functional Programming**
- **Languages**: Haskell, OCaml, F#, Elm, Clojure, Erlang, Elixir
- **Paradigms**: Pure functions, Immutability, Type systems

### 🎮 **Game Development**
- **Languages**: C++, C#, Lua, GDScript, HLSL, GLSL
- **Engines**: Unity, Unreal Engine, Godot, Custom engines

### ⛓️ **Blockchain & Web3**
- **Languages**: Solidity, Vyper, Rust, Go, JavaScript
- **Platforms**: Ethereum, Polygon, Solana, Smart contracts

The intelligent system automatically routes your request to the most appropriate specialist for optimal results!

EOF
    echo "✅ /$cmd_name intelligent command created"
}

# Main character commands
# 🎮 CORE MARIO POWERUP COMMANDS (10 Essential)

# 1. Main coding assistant
create_command "mario-code" "🍄 Mario - Full Stack Hero" "Mario's enthusiastic coding implementation with multi-language support" "mario.md"

# 2. Debugging and testing
create_command "luigi-debug" "👻 Luigi - Debug Master" "Luigi's careful debugging, testing, and problem analysis" "luigi.md"

# 3. System architecture
create_command "peach-architect" "👸 Princess Peach - Architecture Queen" "Peach's elegant system architecture and design" "peach.md"

# 4. Performance optimization
create_command "bowser-optimize" "🐢 Bowser - Performance King" "Bowser's raw optimization power and scaling" "bowser.md"

# 5. System diagnostics
create_command "dr-mario-checkup" "🩺 Dr. Mario - System Health" "Dr. Mario's complete system diagnostics and health checks" "dr-mario.md"

# 6. Systems thinking
create_command "rosalina-systems-analysis" "🌟 Rosalina - Systems Master" "Rosalina's holistic systems thinking and trade-off analysis" "rosalina.md"

# 7. Internationalization
create_command "toadette-i18n" "🌍 Toadette - i18n Specialist" "Toadette's complete internationalization - analyze, implement, enhance" "toadette.md"

# 8. Code review team (fusion)
create_command "fire-trio" "🔥 Fire Trio - Code Review Team" "Mario + Luigi + Wario ultimate code review collaboration" "fire-trio.md"

# 9. Multi-agent collaboration (orchestra)
create_command "mario-orchestra" "🎼 Mario Orchestra - AI Collaboration" "Multi-agent AI collaboration for complex challenges" "mario-orchestra.md"

# 10. Complete project documentation specialist
create_command "toad-docs" "🍄 Toad - Documentation Librarian" "Complete project documentation with JSDoc, README, and API docs" "toad.md"

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

# Fusion team commands
cat > "$HOME/.claude/commands/fire-trio.md" << 'EOF'
---
name: fire-trio
description: Ultimate code review team - Mario + Luigi + Wario collaboration
---

# 🔥 The Fire Trio - Ultimate Code Review Team

**Members**: Mario + Luigi + Wario  
**Specialization**: Comprehensive code analysis combining enthusiasm, paranoid testing, and performance obsession

The Fire Trio brings together three distinct perspectives for the most thorough code review possible:

- 🍄 **Mario**: Enthusiastic implementation review with strategic thinking
- 👻 **Luigi**: Paranoid edge case analysis and comprehensive testing strategies  
- 💰 **Wario**: Performance obsession and resource optimization focus

**How to use:**
Provide code, a system, or a pull request that needs comprehensive review. The Fire Trio will analyze it from multiple angles, ensuring security, performance, maintainability, and robust testing coverage.

**Example usage:**
`/fire-trio "review this authentication middleware for security vulnerabilities"`

*"When fire power combines with testing paranoia and performance greed, no bug can hide!"* - The Fire Trio
EOF

cat > "$HOME/.claude/commands/smart-builder.md" << 'EOF'
---
name: smart-builder
description: Complete feature development - Princess Peach + Yoshi + Donkey Kong
---

# 🏗️ The Smart Builder - Complete Feature Development

**Members**: Princess Peach + Yoshi + Donkey Kong  
**Specialization**: End-to-end feature creation with elegant architecture, user validation, and powerful implementation

The Smart Builder team handles complete feature development from concept to implementation:

- 👸 **Princess Peach**: Elegant architectural design and user experience focus
- 🦕 **Yoshi**: Reliable user validation and testing companion
- 🦍 **Donkey Kong**: Powerful implementation and robust feature delivery

**How to use:**
Describe a feature or system you want built from scratch. The Smart Builder team will design, validate, and implement it with attention to architecture, user needs, and solid engineering practices.

**Example usage:**
`/smart-builder "create a real-time chat system with emoji reactions and file sharing"`

*"Great features are built with elegance, validation, and unstoppable power!"* - The Smart Builder Team
EOF

cat > "$HOME/.claude/commands/fortress.md" << 'EOF'
---
name: fortress
description: Secure architecture team - Mario + Princess Peach + Bowser
---

# 🏰 The Fortress - Secure Architecture Team

**Members**: Mario + Princess Peach + Bowser  
**Specialization**: Bulletproof security combining implementation security, architectural security, and adversarial testing

The Fortress team creates impenetrable security for your systems:

- 🍄 **Mario**: Implementation-level security best practices and secure coding
- 👸 **Princess Peach**: Elegant architectural security design and access control
- 🐢 **Bowser**: Adversarial testing and attack surface domination

**How to use:**
Provide a system, API, or application that needs security analysis or secure design. The Fortress will fortify it against all possible threats with multi-layered security approaches.

**Example usage:**
`/fortress "secure a financial trading API handling millions in transactions"`

*"No attack can breach the Fortress when heroes and villains unite for security!"* - The Fortress Alliance
EOF

cat > "$HOME/.claude/commands/chaos-engine.md" << 'EOF'
---
name: chaos-engine
description: Ultimate stress testing - Luigi + Wario + Bowser
---

# 🌪️ The Chaos Engine - Ultimate Stress Testing

**Members**: Luigi + Wario + Bowser  
**Specialization**: Maximum stress testing with paranoid edge cases, performance limits, and chaos engineering

The Chaos Engine pushes systems to their absolute breaking points:

- 👻 **Luigi**: Paranoid edge case discovery and comprehensive failure analysis
- 💰 **Wario**: Resource limit testing and performance boundary exploration
- 🐢 **Bowser**: Chaos engineering and maximum load domination

**How to use:**
Provide a system, application, or service that needs extreme stress testing. The Chaos Engine will find every possible failure mode, performance bottleneck, and breaking point.

**Example usage:**
`/chaos-engine "stress test social media platform for 10 million concurrent users"`

*"If it can survive the Chaos Engine, it can survive anything!"* - The Chaos Alliance
EOF

# Utility commands
cat > "$HOME/.claude/commands/mario-help.md" << 'EOF'
---
name: mario-help
description: Get detailed help for any Mario PowerUp command
---

# 🍄 Mario Help System

Get detailed information about any Mario PowerUp command, character, or system feature.

**Usage:**
- `/mario-help [command-name]` - Get help for a specific command
- `/mario-help characters` - List all available characters
- `/mario-help fusion` - Information about fusion teams
- `/mario-help hooks` - Information about development hooks
- `/mario-help achievements` - Achievement system details

**Examples:**
- `/mario-help luigi-debug` - Learn about Luigi's debugging capabilities
- `/mario-help fire-trio` - Understand the Fire Trio fusion team
- `/mario-help` - General help and available commands

*"Mamma mia! I'm here to help you navigate the Mushroom Kingdom of code!"* - Mario
EOF

cat > "$HOME/.claude/commands/mario-achievements.md" << 'EOF'
---
name: mario-achievements
description: View unlocked achievements and milestone progress
---

# 🏆 Mario Achievement System

View your current achievements, milestone progress, and legendary developer status.

**Achievement Categories:**
- 🍄 **PowerUp Mastery** - Using different characters and commands
- 🪙 **Coin Collection** - Successful tool usage and streak building
- 🌍 **World Progression** - Advancing through 8 coding worlds
- 🎭 **Character Bonds** - Building relationships with different characters
- 🎼 **Orchestra Conductor** - Multi-agent collaboration achievements

**Current Status Display:**
- Total coins collected and current streak
- World progression (1-1 through 8-1)
- Unlocked achievements and next milestones
- Character usage statistics
- Special titles earned

*"Every achievement is a step closer to legendary developer status!"* - Princess Peach
EOF

cat > "$HOME/.claude/commands/mario-leaderboard.md" << 'EOF'
---
name: mario-leaderboard
description: See your coding statistics and world progress
---

# 📊 Mario Development Leaderboard

Track your coding journey with detailed statistics and world progression metrics.

**Statistics Tracked:**
- 🪙 **Total Coins**: All-time successful tool usage
- 🔥 **Best Streak**: Longest consecutive success run
- 🌍 **Current World**: Your progression through 8 coding worlds
- 🎮 **Commands Used**: Most frequently used PowerUp commands
- 🤖 **Character Affinity**: Which characters you work with most
- ⏱️ **Session Activity**: Recent coding session patterns

**World Progression:**
- World 1-1 (0-99 coins): Grassland - Basic development
- World 2-1 (100-199 coins): Desert - Debugging mastery
- World 3-1 (200-399 coins): Water World - Algorithm mastery
- World 4-1 (400-799 coins): Ghost House - Legacy code mastery
- World 8-1 (800+ coins): Bowser's Castle - Enterprise architecture

**Personal Records**:
- Daily coin collection records
- Weekly streak achievements
- Monthly world progression
- Character collaboration diversity

*"The leaderboard shows your legendary journey through the Mushroom Kingdom!"* - King K. Rool
EOF

# Item-based PowerUp commands
cat > "$HOME/.claude/commands/super-mushroom-refactor.md" << 'EOF'
---
name: super-mushroom-refactor
description: Grow your code bigger and better with smart refactoring
---

# 🍄 Super Mushroom - Code Growth Power

Transform your code with the Super Mushroom's growth power! Make it bigger, better, and more maintainable.

**Super Mushroom Effects:**
- 📈 **Code Expansion**: Transform small functions into comprehensive, well-structured solutions
- 🏗️ **Architecture Growth**: Evolve simple scripts into scalable, maintainable systems
- 🔧 **Feature Enhancement**: Add robust error handling, logging, and documentation
- 🎯 **Best Practices**: Apply design patterns and coding standards
- 📚 **Documentation**: Generate comprehensive comments and documentation

**How to use:**
Provide code that needs to grow from basic implementation to production-ready quality. The Super Mushroom will enhance it with proper structure, error handling, testing considerations, and scalability.

**Example usage:**
`/super-mushroom-refactor "this simple login function needs production-ready features"`

*"Mamma mia! Watch your code grow bigger and stronger!"* - Mario with Super Mushroom Power
EOF

cat > "$HOME/.claude/commands/fire-flower-debug.md" << 'EOF'
---
name: fire-flower-debug
description: Debug code with fiery precision and error elimination
---

# 🌸 Fire Flower - Debugging Power

Unleash the Fire Flower's debugging power! Eliminate bugs with fiery precision and unstoppable determination.

**Fire Flower Effects:**
- 🔥 **Bug Elimination**: Identify and destroy errors with precision attacks
- 🎯 **Root Cause Analysis**: Trace problems to their source with fiery focus
- 🛡️ **Defensive Coding**: Add robust error handling and validation
- 📊 **Debug Tooling**: Implement logging, monitoring, and debugging aids
- ⚡ **Performance Debugging**: Find and eliminate performance bottlenecks

**How to use:**
Provide buggy code, error messages, or performance issues that need the Fire Flower's debugging power. You'll get targeted solutions that eliminate problems at their source.

**Example usage:**
`/fire-flower-debug "this async function is causing memory leaks and race conditions"`

*"With Fire Flower power, no bug can hide from Mario's fiery debugging!"* - Fire Mario
EOF

cat > "$HOME/.claude/commands/star-power-optimize.md" << 'EOF'
---
name: star-power-optimize
description: Invincible optimization mode that removes all performance bottlenecks
---

# ⭐ Star Power - Invincible Optimization

Activate Star Power for invincible optimization! Nothing can stop this legendary performance enhancement mode.

**Star Power Effects:**
- ⚡ **Ultimate Performance**: Maximum speed and efficiency optimization
- 🚀 **Scalability Boost**: Handle massive loads with invincible power
- 💎 **Memory Mastery**: Perfect memory usage and garbage collection
- 🔄 **Algorithm Excellence**: Optimal algorithms and data structures
- 🏆 **Benchmark Domination**: Achieve legendary performance metrics

**Star Power Duration**: This optimization power makes your code invincible to performance issues!

**How to use:**
Provide code or systems that need maximum performance optimization. Star Power will transform them into invincible, high-performance solutions that can handle any load.

**Example usage:**
`/star-power-optimize "this database query system needs to handle 1 million requests per second"`

*"⭐ INVINCIBLE! With Star Power, your code becomes unstoppable!"* - Mario with Star Power
EOF

cat > "$HOME/.claude/commands/1up-backup.md" << 'EOF'
---
name: 1up-backup
description: Create safety backups and recovery points before risky changes
---

# 💚 1-UP Mushroom - Safety & Recovery Power

Get an extra life with the 1-UP Mushroom! Create comprehensive safety backups before making risky changes.

**1-UP Protection:**
- 🛡️ **Code Backup**: Create safe copies before dangerous operations
- 📸 **State Snapshots**: Capture current working state and configuration
- 🔄 **Recovery Plans**: Detailed rollback procedures and safety nets
- 🎯 **Risk Assessment**: Analyze potential dangers and mitigation strategies
- 📋 **Checkpoint System**: Multiple recovery points for complex changes

**How to use:**
Use before making risky changes like major refactoring, dependency upgrades, or system modifications. The 1-UP Mushroom will create comprehensive backup and recovery strategies.

**Example usage:**
`/1up-backup "about to upgrade React from v16 to v18 across entire application"`

*"Don't worry! The 1-UP Mushroom gives you extra lives for risky adventures!"* - Mario collecting 1-UP
EOF

cat > "$HOME/.claude/commands/coin-collect.md" << 'EOF'
---
name: coin-collect
description: Collect achievement coins and track coding accomplishments
---

# 🪙 Coin Collection - Achievement Tracking

Collect coins for your coding achievements! Track your legendary developer journey through the Mushroom Kingdom.

**Coin Collection System:**
- 🎯 **Achievement Recognition**: Earn coins for successful tool usage and code completion
- 🔥 **Streak Bonuses**: Extra coins for consecutive successful actions
- 🌍 **World Progress**: Advance through 8 coding worlds as you collect coins
- 🏆 **Milestone Rewards**: Special celebrations at 10, 50, 100+ coin milestones
- 📊 **Progress Tracking**: Detailed statistics and leaderboard progression

**Current Collection Status:**
- View total coins collected across all sessions
- See current success streak and Fire Flower/Star Power status
- Track world progression from 1-1 (Beginner) to 8-1 (Enterprise Master)
- Display recent achievements and next milestone goals

**How to use:**
This command shows your current coin collection status and recent achievements. Coins are automatically collected through the hook system when you successfully use development tools.

*"🪙 *ding ding* Every coin brings you closer to legendary status!"* - Mario
EOF

# PowerUp Evolution/Combination commands
cat > "$HOME/.claude/commands/mario-luigi-debug.md" << 'EOF'
---
name: mario-luigi-debug
description: Brothers teamwork debugging - Mario's enthusiasm + Luigi's caution
---

# 🍄👻 Mario & Luigi - Brothers Debugging Power

The legendary Mario Brothers unite their powers for the ultimate debugging experience!

**Brothers Synergy:**
- 🍄 **Mario's Enthusiasm**: "Let's-a-go fix this bug with confidence and determination!"
- 👻 **Luigi's Caution**: "But wait, Mario! Let me check for edge cases and potential issues first!"
- 🤝 **Teamwork**: Perfect balance of bold action and careful analysis

**Combined Debugging Powers:**
- 🚀 **Fearless Problem Solving**: Mario's courage to tackle any bug
- 🔍 **Thorough Investigation**: Luigi's paranoid attention to every detail
- 🛡️ **Comprehensive Testing**: Both immediate fixes and long-term stability
- 🎯 **Balanced Approach**: Quick solutions validated with careful testing

**Example usage:**
`/mario-luigi-debug "this authentication system has intermittent failures"`

*"Mamma mia! Together we're unstoppable at debugging!"* - Mario & Luigi
EOF

cat > "$HOME/.claude/commands/peach-bowser-architect.md" << 'EOF'
---
name: peach-bowser-architect
description: Royal vs Raw architecture decisions - Elegance meets Power
---

# 👸🐢 Princess Peach & Bowser - Elegant Power Architecture

When royal elegance meets raw power, legendary architecture is born!

**Royal vs Raw Synergy:**
- 👸 **Princess Peach**: "Let us create something truly elegant and user-friendly"
- 🐢 **Bowser**: "GRAAAH! But it must be POWERFUL and SCALABLE!"
- ⚖️ **Perfect Balance**: Beauty with brute force, elegance with performance

**Combined Architecture Powers:**
- 🎨 **Elegant Design**: Beautiful, intuitive interfaces and APIs
- ⚡ **Raw Performance**: Uncompromising speed and scalability
- 🏰 **Royal Standards**: High-quality, maintainable architecture
- 💪 **Dominating Power**: Systems that can handle any load

**Example usage:**
`/peach-bowser-architect "design a high-performance API that's also developer-friendly"`

*"When elegance meets power, we create architectural masterpieces!"* - Peach & Bowser Alliance
EOF

cat > "$HOME/.claude/commands/fire-star-optimize.md" << 'EOF'
---
name: fire-star-optimize
description: Ultimate performance mode - Fire Flower + Star Power combination
---

# 🔥⭐ Fire Flower + Star Power - Ultimate Performance Mode

The most powerful optimization combination in the Mushroom Kingdom! Fire precision + Star invincibility!

**Ultimate Power Combination:**
- 🔥 **Fire Flower**: Precise bug elimination and targeted optimization
- ⭐ **Star Power**: Invincible performance that conquers all bottlenecks
- 💥 **ULTIMATE MODE**: Unstoppable optimization power that fears nothing!

**Supreme Optimization Effects:**
- ⚡ **Lightning Speed**: Absolute maximum performance optimization
- 🎯 **Precision Targeting**: Find and eliminate every bottleneck with fire precision
- 🛡️ **Invincible Performance**: Code that can handle infinite scale
- 🏆 **Legendary Status**: Performance that becomes the stuff of legends

**Power Duration**: This combination creates permanently optimized, invincible code!

**Example usage:**
`/fire-star-optimize "this system needs to be the fastest, most efficient solution possible"`

*"🔥⭐ ULTIMATE POWER! Nothing can stop this legendary optimization!"* - Fire Mario with Star Power
EOF

cat > "$HOME/.claude/commands/world-1-1.md" << 'EOF'
---
name: world-1-1
description: Start your coding journey - Basic programming fundamentals
---

# 🏔️ World 1-1 - Grassland Adventures

Welcome to World 1-1, where every legendary developer begins their journey through the Mushroom Kingdom of code!

**World 1-1 Features:**
- 🌱 **Beginner Friendly**: Perfect starting point for new adventures
- 🍄 **Foundation Building**: Core programming concepts and best practices
- 🎮 **Interactive Learning**: Hands-on experience with immediate feedback
- 🌟 **Achievement Unlocks**: Earn your first coins and power-ups
- 🚪 **Gateway to Adventure**: Opens the path to more advanced worlds

**Learning Topics:**
- Basic syntax and programming fundamentals
- Simple algorithms and data structures
- Code organization and clean coding practices
- Basic debugging and testing approaches
- Introduction to development tools and workflows

**Example usage:**
`/world-1-1 "teach me how to create my first Python web API"`

*"Welcome to the Mushroom Kingdom! Every expert was once a beginner!"* - Mario at World 1-1
EOF

cat > "$HOME/.claude/commands/world-8-1.md" << 'EOF'
---
name: world-8-1
description: Enterprise challenge - Bowser's Castle final boss level
---

# 🏰 World 8-1 - Bowser's Castle

The ultimate challenge! Face the final boss level where only legendary developers dare to tread!

**Bowser's Castle Features:**
- 🏰 **Enterprise Architecture**: Master-level system design challenges
- 👑 **Final Boss Battles**: Complex, real-world engineering problems
- 🔥 **Maximum Difficulty**: Advanced concepts that push your limits
- 💎 **Legendary Rewards**: Ultimate achievements for conquering the castle
- 🌟 **Master Developer Status**: Prove you've conquered the Mushroom Kingdom

**Enterprise Topics:**
- Large-scale system architecture and microservices
- High-availability, fault-tolerant system design
- Performance optimization at massive scale
- Security architecture and threat modeling
- DevOps, deployment pipelines, and infrastructure as code
- Team leadership and technical strategy

**Example usage:**
`/world-8-1 "design a globally distributed system for 100 million users"`

*"GRAAAH! Welcome to my castle! Only the strongest developers survive here!"* - Bowser
EOF

echo "✅ PowerUp evolution/combination commands created"
echo "✅ Item-based PowerUp commands created" 
echo "✅ Utility commands created"
echo "✅ Fusion team commands created"
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
create_agent "toadette-i18n" "🌍 Toadette - i18n Specialist" "Toadette's comprehensive internationalization analysis and implementation" "toadette-i18n.md" "Read, Write, Edit, Bash, Grep, Glob"
create_agent "toad-documentation" "🍄 Toad - Documentation Librarian" "Complete project documentation specialist with JSDoc generation and README creation" "toad-documentation.md" "Read, Write, Edit, MultiEdit, Grep, Glob, Bash"

# Copy comprehensive Mario development hooks
echo "🪝 Installing Mario PowerUp Hook System..."

# Copy hooks from the hooks directory
if [ -d "hooks" ]; then
    cp hooks/coin-collector.sh "$HOME/.claude/hooks/"
    cp hooks/mario-safety-guardian.sh "$HOME/.claude/hooks/"
    cp hooks/mario-context-enhancer.sh "$HOME/.claude/hooks/"
    cp hooks/session-welcome.sh "$HOME/.claude/hooks/"
    cp hooks/progress-saver.sh "$HOME/.claude/hooks/"
    cp hooks/mario-token-counter.sh "$HOME/.claude/hooks/"
    
    chmod +x "$HOME/.claude/hooks/"*.sh
    echo "✅ All advanced Mario hooks installed from hooks directory"
else
    # Fallback: Create hooks inline if directory doesn't exist
    echo "⚠️  Hooks directory not found, creating inline..."
    
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
fi  # Close the hooks if block

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
            "command": "$HOME/.claude/hooks/coin-collector.sh"
          }
        ]
      },
      {
        "matcher": "Bash.*git.*",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/koopa-troopa-git.sh"
          }
        ]
      },
      {
        "matcher": "Bash.*(test|jest|pytest).*",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/yoshi-test-runner.sh"
          }
        ]
      },
      {
        "matcher": "Bash.*(optimize|performance|build).*",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/bowser-performance.sh"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command", 
            "command": "$HOME/.claude/hooks/mario-safety-guardian.sh"
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