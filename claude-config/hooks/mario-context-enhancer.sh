#!/bin/bash
# 🧠🍄 Mario Context Enhancement System - Smart Prompt Intelligence 🍄🧠
# Advanced context analysis using proper Claude Code UserPromptSubmit hook protocol
# Intelligently enhances user prompts with project context and Mario wisdom

# Security and error handling
set -euo pipefail

# Constants
readonly CONTEXT_DIR="$HOME/.claude/context-analysis"
readonly PROJECT_PATTERNS_FILE="$CONTEXT_DIR/project-patterns.json"
readonly PROMPT_HISTORY_FILE="$CONTEXT_DIR/prompt-history.jsonl"
readonly ENHANCEMENT_LOG_FILE="$CONTEXT_DIR/enhancement-log.jsonl"

# Mario knowledge base for different development scenarios
declare -A MARIO_WISDOM=(
    ["debug"]="🔍 Luigi says: 'Let's-a look at the logs and traces! Every ghost bug leaves clues!'"
    ["performance"]="⚡ Bowser roars: 'MAKE IT FASTER! Optimization is about finding bottlenecks!'"
    ["architecture"]="👸 Princess Peach suggests: 'Elegant design considers scalability and maintainability.'"
    ["testing"]="🧪 Mario advises: 'Mamma mia! Testing gives you extra lives when bugs attack!'"
    ["security"]="🛡️ Captain Toad warns: 'Adventure safely! Always validate inputs and protect data!'"
    ["refactor"]="🔄 Yoshi encourages: 'Transform code like eating fruit - make it better bit by bit!'"
    ["deployment"]="🚀 Rosalina guides: 'From cosmic perspective, deployment orchestrates all systems!'"
)

# Development patterns that trigger smart enhancements
declare -A ENHANCEMENT_PATTERNS=(
    ["error.*fix|bug.*fix|broken"]="debug"
    ["slow.*performance|optimize|speed"]="performance"
    ["design.*system|architect|structure"]="architecture"
    ["test.*write|testing|spec"]="testing"
    ["secure|security|auth|permission"]="security"
    ["refactor|cleanup|improve.*code"]="refactor"
    ["deploy|release|production"]="deployment"
)

# Project context detectors
declare -A PROJECT_TECHNOLOGIES=(
    ["package.json"]="Node.js/JavaScript"
    ["requirements.txt|setup.py|pyproject.toml"]="Python"
    ["Cargo.toml"]="Rust"
    ["go.mod|go.sum"]="Go"
    ["pom.xml|build.gradle"]="Java"
    ["composer.json"]="PHP"
    ["Gemfile"]="Ruby"
)

# Utility functions
create_context_dirs() {
    if [[ ! -d "$CONTEXT_DIR" ]]; then
        mkdir -p "$CONTEXT_DIR"
        chmod 700 "$CONTEXT_DIR"
        
        # Initialize project patterns file
        cat > "$PROJECT_PATTERNS_FILE" << 'EOF'
{
  "version": "1.0",
  "technologies": {},
  "common_patterns": [],
  "project_structure": {},
  "last_analysis": ""
}
EOF
        
        touch "$PROMPT_HISTORY_FILE" "$ENHANCEMENT_LOG_FILE"
    fi
}

log_enhancement_event() {
    local prompt_type="$1"
    local original_length="$2"
    local enhanced_length="$3"
    local enhancements_applied="$4"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    local log_entry
    log_entry=$(python3 << EOF
import json

log_entry = {
    "timestamp": "$timestamp",
    "prompt_type": "$prompt_type",
    "original_length": $original_length,
    "enhanced_length": $enhanced_length,
    "enhancements_applied": "$enhancements_applied",
    "improvement_ratio": round($enhanced_length / max($original_length, 1), 2)
}

print(json.dumps(log_entry))
EOF
)
    
    echo "$log_entry" >> "$ENHANCEMENT_LOG_FILE"
}

detect_project_context() {
    local working_dir="$1"
    local detected_tech=""
    local project_info=""
    
    # Change to working directory safely
    if [[ -d "$working_dir" ]]; then
        cd "$working_dir" 2>/dev/null || return 0
        
        # Detect technologies based on files
        for pattern in "${!PROJECT_TECHNOLOGIES[@]}"; do
            if find . -maxdepth 3 -name "$(echo "$pattern" | cut -d'|' -f1)" -o -name "$(echo "$pattern" | cut -d'|' -f2 2>/dev/null || echo '')" 2>/dev/null | grep -q .; then
                detected_tech="${PROJECT_TECHNOLOGIES[$pattern]}"
                break
            fi
        done
        
        # Gather additional context
        if [[ -f "README.md" ]]; then
            project_info=$(head -10 README.md 2>/dev/null | grep -E "^#|description|purpose" | head -3)
        fi
        
        if [[ -f "package.json" ]]; then
            project_info="$project_info"$'\n'$(grep -E "\"(name|description|version)\":" package.json 2>/dev/null | head -3)
        fi
    fi
    
    echo "$detected_tech"
    echo "$project_info"
}

analyze_prompt_intent() {
    local user_prompt="$1"
    local detected_pattern=""
    local confidence=0
    
    # Convert to lowercase for pattern matching
    local prompt_lower=$(echo "$user_prompt" | tr '[:upper:]' '[:lower:]')
    
    # Match against enhancement patterns
    for pattern in "${!ENHANCEMENT_PATTERNS[@]}"; do
        if [[ "$prompt_lower" =~ $pattern ]]; then
            detected_pattern="${ENHANCEMENT_PATTERNS[$pattern]}"
            confidence=85
            break
        fi
    done
    
    # Fallback pattern detection with lower confidence
    if [[ -z "$detected_pattern" ]]; then
        if [[ "$prompt_lower" =~ (help|how|what|explain) ]]; then
            detected_pattern="general_help"
            confidence=60
        elif [[ "$prompt_lower" =~ (create|make|build|implement) ]]; then
            detected_pattern="implementation"
            confidence=70
        fi
    fi
    
    echo "$detected_pattern"
    echo "$confidence"
}

enhance_prompt_with_context() {
    local original_prompt="$1"
    local project_tech="$2"
    local detected_pattern="$3"
    local working_dir="$4"
    
    local enhanced_prompt="$original_prompt"
    local enhancements_applied=()
    
    # Add project technology context
    if [[ -n "$project_tech" ]] && [[ "$project_tech" != "unknown" ]]; then
        enhanced_prompt="$enhanced_prompt"$'\n\n'"🎯 **Project Context**: This appears to be a $project_tech project."
        enhancements_applied+=("project_context")
    fi
    
    # Add Mario wisdom based on detected pattern
    if [[ -n "$detected_pattern" ]] && [[ -n "${MARIO_WISDOM[$detected_pattern]:-}" ]]; then
        enhanced_prompt="$enhanced_prompt"$'\n\n'"💡 **Mario's Wisdom**: ${MARIO_WISDOM[$detected_pattern]}"
        enhancements_applied+=("mario_wisdom")
    fi
    
    # Add directory context if helpful
    if [[ -d "$working_dir" ]]; then
        local dir_name=$(basename "$working_dir")
        if [[ "$dir_name" =~ (src|lib|components|pages|routes) ]]; then
            enhanced_prompt="$enhanced_prompt"$'\n\n'"📁 **Context**: Working in $dir_name directory - appears to be code organization."
            enhancements_applied+=("directory_context")
        fi
    fi
    
    # Add development best practices reminder for complex requests
    if [[ ${#original_prompt} -gt 100 ]] && [[ "$detected_pattern" =~ (architecture|refactor|security) ]]; then
        enhanced_prompt="$enhanced_prompt"$'\n\n'"🏆 **Best Practices Reminder**: Consider testing, documentation, and maintainability in your solution."
        enhancements_applied+=("best_practices")
    fi
    
    echo "$enhanced_prompt"
    printf '%s\n' "${enhancements_applied[@]}"
}

create_json_response() {
    local enhanced_prompt="$1"
    local should_enhance="$2"
    
    if [[ "$should_enhance" == "true" ]]; then
        python3 << EOF
import json

response = {
    "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "modifiedPrompt": '''$enhanced_prompt'''
    },
    "suppressOutput": False
}

print(json.dumps(response, indent=2))
EOF
    else
        # No enhancement needed, return empty response
        echo "{}"
    fi
}

parse_json_input() {
    local json_input="$1"
    
    python3 << EOF
import json, sys, os
try:
    data = json.loads('''$json_input''')
    
    # Extract relevant data
    user_prompt = data.get('user_prompt', '')
    hook_event = data.get('hook_event_name', '')
    working_directory = data.get('working_directory', os.getcwd())
    
    # Output parsed data as environment variables
    print(f"export PARSED_USER_PROMPT='''{user_prompt}'''")
    print(f"export PARSED_HOOK_EVENT='{hook_event}'") 
    print(f"export PARSED_WORKING_DIR='{working_directory}'")
    
except Exception as e:
    print(f"# JSON parsing error: {str(e)}", file=sys.stderr)
    print("export PARSED_USER_PROMPT=''")
    print("export PARSED_HOOK_EVENT='unknown'")
    print("export PARSED_WORKING_DIR='.'")
    sys.exit(1)
EOF
}

# Main context enhancement function
main() {
    local input_data
    input_data=$(cat)
    
    # Initialize context system
    create_context_dirs
    
    # Parse JSON input using official Claude Code format
    if ! eval "$(parse_json_input "$input_data")"; then
        echo "❌ Error parsing context hook input" >&2
        exit 1
    fi
    
    # Only process UserPromptSubmit events
    if [[ "$PARSED_HOOK_EVENT" != "UserPromptSubmit" ]]; then
        exit 0  # Silently ignore non-UserPromptSubmit events
    fi
    
    # Skip enhancement for very short prompts or system messages
    if [[ ${#PARSED_USER_PROMPT} -lt 10 ]] || [[ "$PARSED_USER_PROMPT" =~ ^/(help|status) ]]; then
        create_json_response "$PARSED_USER_PROMPT" "false"
        exit 0
    fi
    
    # Analyze prompt and project context
    readarray -t intent_analysis < <(analyze_prompt_intent "$PARSED_USER_PROMPT")
    local detected_pattern="${intent_analysis[0]:-}"
    local confidence="${intent_analysis[1]:-0}"
    
    readarray -t project_context < <(detect_project_context "$PARSED_WORKING_DIR")
    local project_tech="${project_context[0]:-unknown}"
    local project_info="${project_context[1]:-}"
    
    # Enhance prompt with context (only if confidence is sufficient)
    local should_enhance="false"
    local enhanced_prompt="$PARSED_USER_PROMPT"
    local enhancements_applied=()
    
    if [[ $confidence -ge 60 ]] || [[ "$project_tech" != "unknown" ]]; then
        should_enhance="true"
        readarray -t enhancement_result < <(enhance_prompt_with_context "$PARSED_USER_PROMPT" "$project_tech" "$detected_pattern" "$PARSED_WORKING_DIR")
        enhanced_prompt="${enhancement_result[0]}"
        enhancements_applied=(${enhancement_result[@]:1})
    fi
    
    # Log the enhancement event
    if [[ "$should_enhance" == "true" ]]; then
        log_enhancement_event "$detected_pattern" "${#PARSED_USER_PROMPT}" "${#enhanced_prompt}" "$(IFS=','; echo "${enhancements_applied[*]}")"
        
        echo "🧠 Mario Context Enhancer activated! Added helpful context to your prompt."
        echo "🍄 Enhancements: $(IFS=', '; echo "${enhancements_applied[*]}")"
        if [[ -n "$project_tech" ]] && [[ "$project_tech" != "unknown" ]]; then
            echo "🎯 Project: $project_tech"
        fi
    fi
    
    # Generate JSON response
    create_json_response "$enhanced_prompt" "$should_enhance"
}

# Execute main function with error handling
main "$@"