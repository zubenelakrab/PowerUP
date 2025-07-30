#!/bin/bash

# 🍄⭐ Mario Bros PowerUps Uninstaller ⭐🍄
# Simple uninstallation script for Claude Code

echo "🍄💔 Mario Bros PowerUps - Uninstallation ⭐🍄"
echo ""
echo "This will remove Mario PowerUps from ~/.claude directory"
echo ""

# Check if PowerUps are installed
if [ ! -d "$HOME/.claude/powerups" ] && [ ! -d "$HOME/.claude/orchestra" ]; then
    echo "ℹ️  Mario PowerUps are not currently installed."
    echo "   Nothing to uninstall."
    exit 0
fi

# Show what will be removed
echo "📋 The following will be removed:"
echo ""

if [ -d "$HOME/.claude/powerups" ]; then
    echo "🎭 Characters: $(ls -1 "$HOME/.claude/powerups/characters/" 2>/dev/null | wc -l) characters"
    echo "🌍 Worlds: $(ls -1 "$HOME/.claude/powerups/worlds/" 2>/dev/null | wc -l) worlds"
    echo "🎁 Items: $(ls -1 "$HOME/.claude/powerups/items/" 2>/dev/null | wc -l) items"
fi

if [ -d "$HOME/.claude/orchestra" ]; then
    echo "🎼 Orchestra: Multi-agent AI collaboration system"
fi

if [ -f "$HOME/.claude/ULTIMATE_COMMAND_REFERENCE.md" ]; then
    echo "📚 Command reference documentation"
fi

if [ -f "$HOME/.claude/MARIO_POWERUPS_CLAUDE.md" ]; then
    echo "📄 Main Mario PowerUps documentation"
fi

if [ -f "$HOME/.claude/MARIO_POWERUPS_README.md" ]; then
    echo "📄 Mario PowerUps README"
fi

if [ -f "$HOME/.claude/language-detection-service.js" ]; then
    echo "🧠 Language detection service"
fi

if [ -f "$HOME/.claude/i18n-detection-service.js" ]; then
    echo "🌍 i18n detection service"
fi

if [ -f "$HOME/.claude/reasoning-framework.md" ]; then
    echo "📚 Documentation files"
fi

if [ -f "$HOME/.claude/hooks/coin-collector.sh" ]; then
    echo "🪙 Interactive development hooks"
fi

echo ""
echo "⚠️  This action cannot be undone!"
echo ""

# Confirm uninstallation
read -p "Are you sure you want to uninstall Mario PowerUps? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "🚫 Uninstallation cancelled."
    echo "🍄 Mario PowerUps remain installed and ready for adventure!"
    exit 0
fi

echo ""
echo "🗑️  Removing Mario PowerUps..."

# Remove PowerUps files
removed_count=0

if [ -d "$HOME/.claude/powerups" ]; then
    rm -rf "$HOME/.claude/powerups"
    echo "✅ Powerups directory removed"
    ((removed_count++))
fi

if [ -d "$HOME/.claude/orchestra" ]; then
    rm -rf "$HOME/.claude/orchestra"
    echo "✅ Orchestra system removed"
    ((removed_count++))
fi

if [ -f "$HOME/.claude/ULTIMATE_COMMAND_REFERENCE.md" ]; then
    rm "$HOME/.claude/ULTIMATE_COMMAND_REFERENCE.md"
    echo "✅ Command reference removed"
    ((removed_count++))
fi

if [ -f "$HOME/.claude/MARIO_POWERUPS_CLAUDE.md" ]; then
    rm "$HOME/.claude/MARIO_POWERUPS_CLAUDE.md"
    echo "✅ Main documentation removed"
    ((removed_count++))
fi

if [ -f "$HOME/.claude/MARIO_POWERUPS_README.md" ]; then
    rm "$HOME/.claude/MARIO_POWERUPS_README.md"
    echo "✅ README removed"
    ((removed_count++))
fi

# Remove services
if [ -f "$HOME/.claude/language-detection-service.js" ]; then
    rm "$HOME/.claude/language-detection-service.js"
    echo "✅ Language detection service removed"
    ((removed_count++))
fi

if [ -f "$HOME/.claude/i18n-detection-service.js" ]; then
    rm "$HOME/.claude/i18n-detection-service.js"
    echo "✅ i18n detection service removed"
    ((removed_count++))
fi

# Remove documentation files
if [ -f "$HOME/.claude/reasoning-framework.md" ]; then
    rm "$HOME/.claude/reasoning-framework.md"
    echo "✅ Reasoning framework documentation removed"
    ((removed_count++))
fi

if [ -f "$HOME/.claude/professional-code-guidelines.md" ]; then
    rm "$HOME/.claude/professional-code-guidelines.md"
    echo "✅ Professional code guidelines removed"
    ((removed_count++))
fi

# Remove hooks
if [ -f "$HOME/.claude/hooks/coin-collector.sh" ]; then
    rm "$HOME/.claude/hooks/coin-collector.sh"
    echo "✅ Coin collector hook removed"
    ((removed_count++))
fi

if [ -f "$HOME/.claude/hooks/mario-safety-guardian.sh" ]; then
    rm "$HOME/.claude/hooks/mario-safety-guardian.sh"
    echo "✅ Mario safety guardian hook removed"
    ((removed_count++))
fi

echo ""

if [ $removed_count -eq 0 ]; then
    echo "ℹ️  No Mario PowerUps files found to remove."
else
    echo "💔 Mario Bros PowerUps Uninstallation Complete"
    echo ""
    echo "📊 Removed $removed_count component(s)"
    echo "📁 Cleaned up ~/.claude/ directory"
    echo ""
    echo "🎮 Mario and friends have returned to the Mushroom Kingdom..."
    echo "   But they'll be back whenever you need legendary coding help!"
    echo ""
    echo "🔄 To reinstall: Run ./install.sh anytime"
fi

echo ""
echo "👋 Thanks for using Mario Bros PowerUps!"
echo "   Mamma mia, it's been a great adventure! 🍄⭐"