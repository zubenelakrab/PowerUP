#!/bin/bash
# Professional Development Safety Guardian
# Provides intelligent command safety analysis and risk assessment
# Part of the Mario PowerUps professional development safety framework

# Parse JSON input from Claude Code hook system (proper format)
# Read JSON from stdin and parse using Python
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; data = json.loads(sys.stdin.read()); print(data.get('tool_name', ''))")
TOOL_INPUT=$(echo "$INPUT" | python3 -c "import sys, json; data = json.loads(sys.stdin.read()); print(data.get('tool_input', {}).get('command', ''))" 2>/dev/null || echo "")

# Function to log safety analysis for audit trail and learning
log_safety_analysis() {
    local analysis_type="$1"
    local risk_level="$2" 
    local command_preview="$3"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Create safety analysis log directory with proper permissions
    SAFETY_LOG_DIR="$HOME/.claude/safety-analysis"
    mkdir -p "$SAFETY_LOG_DIR"
    
    # Log safety analysis with structured format for monitoring
    echo "[$timestamp] $analysis_type | Risk: $risk_level | Tool: $TOOL_NAME | Command: $command_preview" >> "$SAFETY_LOG_DIR/safety-analysis.log"
}

# Professional command safety analysis for Bash operations
if [ "$TOOL_NAME" = "Bash" ]; then
    # Create command preview for logging (first 50 characters for privacy)
    COMMAND_PREVIEW=$(echo "$TOOL_INPUT" | cut -c1-50)
    
    # Critical Risk Analysis: Commands that could cause irreversible system damage
    if echo "$TOOL_INPUT" | grep -q -E "(rm -rf /|sudo.*rm.*-rf|format|mkfs|dd if=/dev/|>.*passwd|chmod 777 /|chown.*root|shutdown|reboot|init 0|halt)"; then
        log_safety_analysis "CRITICAL_RISK_DETECTED" "CRITICAL" "$COMMAND_PREVIEW"
        echo "🚨 CRITICAL SAFETY ALERT: High-risk system command detected"
        echo "⚠️  Risk Assessment: Command could cause irreversible system damage"
        echo "🛡️  Safety Recommendation: Review command carefully and ensure proper backups"
        echo "💡 Best Practice: Test dangerous operations in isolated environments first"
        echo "🔒 Mario's Safety Tip: 'Even heroes need to be careful with great power!'"
        return 1  # Warning but allow - user should be informed
    fi
    
    # High Risk Analysis: Network and deployment operations
    if echo "$TOOL_INPUT" | grep -q -E "(git push.*--force|git reset.*--hard|npm publish|curl.*\|.*sh|wget.*\|.*bash)"; then
        log_safety_analysis "HIGH_RISK_OPERATION" "HIGH" "$COMMAND_PREVIEW"
        echo "⚠️  HIGH RISK OPERATION: Potentially destructive or public-facing command"
        echo "🔍 Impact Analysis: This operation could affect other developers or production systems"
        echo "👥 Team Consideration: Verify this won't impact other team members' work"
        echo "🧪 Luigi's Caution: 'Let's think about all the things that could go wrong first!'"
        return 0  # Allow but with strong warning
    fi
    
    # Medium Risk Analysis: File operations with data modification potential
    if echo "$TOOL_INPUT" | grep -q -E "(rm.*-r|mv.*\/|find.*-delete|truncate.*|shred)"; then
        log_safety_analysis "MEDIUM_RISK_CAUTION" "MEDIUM" "$COMMAND_PREVIEW"
        echo "⚠️  File Operation Warning: Command will modify or remove files"
        echo "📋 Safety Checklist: Ensure you have backups of important data"
        echo "🔄 Recovery Plan: Verify you can restore files if something goes wrong"
        echo "👸 Peach's Wisdom: 'Elegant solutions include graceful recovery options!'"
        return 0  # Allow with caution
    fi
    
    # Low Risk: Standard development operations - provide encouragement
    log_safety_analysis "STANDARD_OPERATION" "LOW" "$COMMAND_PREVIEW"
    echo "✅ Standard Development Operation: Command appears safe for execution"
    echo "🎯 Good Practice: Using professional development tools appropriately"
fi

# Encourage best practices for different tool types
if [ "$TOOL_NAME" = "Write" ] || [ "$TOOL_NAME" = "Edit" ]; then
    echo "📝 Code Quality Tip: Remember to test your changes before committing"
    echo "🧪 Testing Reminder: Consider adding unit tests for new functionality"
    echo "👸 Peach's Excellence: 'Beautiful code is well-tested code!'"
elif [ "$TOOL_NAME" = "Bash" ] && echo "$TOOL_INPUT" | grep -q -E "(npm install|pip install|composer install|cargo install)"; then
    echo "📦 Dependency Management: Adding new tools to your development environment"
    echo "🔒 Security Tip: Verify package sources and check for known vulnerabilities"
    echo "🍄 Captain Toad's Adventure: 'Great tools make for great discoveries!'"
elif [ "$TOOL_NAME" = "Read" ]; then
    echo "📖 Learning Mode: Exploring and understanding code - excellent practice!"
    echo "🎓 Professional Growth: Code reading is essential for developer expertise"
fi

# Log successful safety check completion
log_safety_analysis "SAFETY_CHECK_COMPLETE" "INFO" "Safety analysis completed successfully"

# Return success - allow operation to proceed
exit 0