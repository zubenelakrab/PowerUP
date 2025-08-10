# 🪝🍄 Mario PowerUp Hook Setup Guide 🍄🪝

After installing Mario PowerUps, you need to configure Claude Code to use the advanced hook system. This guide shows you exactly how to enable all Mario features.

## 🎯 Required Claude Code Settings Configuration

### 📁 Location
Add this configuration to your Claude Code settings file:
- **Linux/macOS**: `~/.config/claude/settings.json`
- **Windows**: `%APPDATA%\claude\settings.json`

### ⚙️ Complete Hook Configuration

Add the following `hooks` section to your `settings.json`:

```json
{
  "hooks": {
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
    ],
    "PostToolUse": [
      {
        "matcher": ".*",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/coin-collector.sh"
          },
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/mario-token-counter.sh"
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/mario-context-enhancer.sh"
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/session-welcome.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/progress-saver.sh"
          }
        ]
      }
    ],
    "PreCompact": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/progress-saver.sh"
          }
        ]
      }
    ]
  }
}
```

## 🎮 What Each Hook Does

### 🛡️ **PreToolUse Hooks** (Before tool execution)
- **mario-safety-guardian.sh** (on Bash commands)
  - Blocks dangerous operations with Mario personality
  - Provides security guidance and best practices
  - Uses risk level analysis (CRITICAL, HIGH, MEDIUM, LOW)

### 🪙 **PostToolUse Hooks** (After tool completion)
- **coin-collector.sh** (on all tools)
  - Awards coins and tracks achievements
  - Celebrates milestones and progress through Mario worlds
  - Maintains coding streaks and power levels

- **mario-token-counter.sh** (on all tools)  
  - Tracks Claude token usage in real-time
  - Provides 5-hour session window analytics
  - Shows usage efficiency and optimization tips

### 🧠 **UserPromptSubmit Hooks** (When you submit prompts)
- **mario-context-enhancer.sh**
  - Intelligently enhances prompts with project context
  - Adds Mario character wisdom based on detected patterns
  - Improves response quality with relevant information

### 🌟 **SessionStart Hooks** (When Claude Code starts)
- **session-welcome.sh**
  - Personalized welcome based on your progress
  - Shows current achievement status and world level
  - Provides project-specific quick start suggestions

### 💾 **Session End Hooks** (Stop/PreCompact events)
- **progress-saver.sh**
  - Automatically saves all progress and achievements
  - Creates recovery checkpoints for interrupted sessions
  - Preserves context across Claude Code restarts

## 🚀 Testing Your Hook Setup

After adding the configuration, test each hook:

### 1. **Test Safety Guardian** (PreToolUse)
```bash
# This should trigger a warning
echo "This is a test command"
```

### 2. **Test Coin Collection** (PostToolUse)
```bash
# This should award coins after completion
/mario-status
```

### 3. **Test Context Enhancement** (UserPromptSubmit)
```bash
# This should add helpful context to your prompt
"Help me debug this React component"
```

### 4. **Test Session Welcome** (SessionStart)
```bash
# You should see a Mario welcome message when Claude Code starts
# (Restart Claude Code to test)
```

### 5. **Test Token Counter** (PostToolUse)
```bash
# After a few operations, you should see:
🪙 +347 tokens | 📊 Total: 1,234 | 🕐 0.2h
⚡ Good progress! You're using Claude Code like a pro!
```

## 🔧 Troubleshooting

### ❌ **Hooks Not Running**
1. **Check file permissions**: Run `chmod +x ~/.claude/hooks/*.sh`
2. **Verify paths**: Ensure all hook files exist in `~/.claude/hooks/`
3. **Restart Claude Code**: Hook configuration requires a restart

### ❌ **Permission Errors**  
```bash
# Fix hook permissions
chmod +x ~/.claude/hooks/*.sh
```

### ❌ **Path Issues on Windows**
Replace `$HOME` with the full path to your user directory:
```json
"command": "C:\\Users\\YourUsername\\.claude\\hooks\\mario-safety-guardian.sh"
```

## 🌟 Advanced Configuration Options

### 🎯 **Selective Hook Activation**
You can enable only specific hooks by removing others from the configuration:

```json
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
      }
    ]
  }
}
```

### 🔧 **Tool-Specific Hooks**
Target specific tools with matcher patterns:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/code-quality-checker.sh"
          }
        ]
      },
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "$HOME/.claude/hooks/command-auditor.sh"
          }
        ]
      }
    ]
  }
}
```

## 🎊 Success! You're Ready to Go!

Once configured, you'll experience:
- 🛡️ **Smart Security**: Mario protects you from dangerous operations
- 🪙 **Achievement Tracking**: Earn coins and progress through coding worlds
- 📊 **Usage Analytics**: Real-time token consumption insights
- 🧠 **Context Intelligence**: Smarter prompts with project awareness
- 🌟 **Session Continuity**: Progress persists across sessions
- 🎮 **Gaming Experience**: Full Mario personality and celebrations

Welcome to the legendary Mario PowerUp experience! 🍄⭐

**Let's-a-go!** Time to create some legendary code! 🎮