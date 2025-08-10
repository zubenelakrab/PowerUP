#!/bin/bash
# Script to add thinking modifier support to all Mario commands

echo "🧠⚡ Adding Thinking Modifiers to All Commands ⚡🧠"

# Function to add modifier section to a command file
add_modifier_section() {
    local file="$1"
    local character="$2"
    local best_modifiers="$3"
    
    # Check if modifiers already added
    if grep -q "THINKING MODIFIERS SYSTEM" "$file"; then
        echo "✅ Already has modifiers: $file"
        return
    fi
    
    echo "Adding modifiers to: $file"
    
    # Find the line number after the character description (first major paragraph)
    local insert_line=$(grep -n "^##" "$file" | head -1 | cut -d: -f1)
    
    if [ -z "$insert_line" ]; then
        echo "⚠️  Could not find insertion point in $file"
        return
    fi
    
    # Create the modifier section
    cat > /tmp/modifier_section.txt << EOF

## 🧠⚡ THINKING MODIFIERS SYSTEM ⚡🧠

$character supports **advanced reasoning strategies** through modifiers:

**Best for $character**: $best_modifiers
**Usage**: \`/$character:\[modifier\]\` or combine with \`+\`
**All modifiers**: :cot, :tot, :got, :multi-agent, :react, :reflection, :verify, :hypothesis, :what-if, :socratic

EOF
    
    # Insert the section
    head -n $((insert_line - 1)) "$file" > /tmp/modified_file.md
    cat /tmp/modifier_section.txt >> /tmp/modified_file.md
    tail -n +$insert_line "$file" >> /tmp/modified_file.md
    
    mv /tmp/modified_file.md "$file"
    echo "✅ Added modifiers to $file"
}

# Apply to each command with character-specific best modifiers
cd /home/zubenelakrab/repos/hobbies/lab/powerup/commands

# Peach - Elegant architecture
add_modifier_section "peach.md" "peach" ":mind-map (structure), :got (systems), :multi-agent (perspectives), :socratic (discovery)"

# Bowser - Aggressive optimization  
add_modifier_section "bowser.md" "bowser" ":react (action), :what-if (scenarios), :monte-carlo (exploration), :hypothesis (testing)"

# Dr. Mario - Diagnostics
add_modifier_section "dr-mario.md" "dr-mario" ":hypothesis (diagnosis), :tot (symptoms), :verify (validation), :reflection (review)"

# Rosalina - Systems thinking
add_modifier_section "rosalina.md" "rosalina" ":got (systems), :what-if (scenarios), :multi-agent (perspectives), :counterfactual (alternatives)"

# Toadette - Internationalization
add_modifier_section "toadette.md" "toadette" ":multi-agent (cultures), :socratic (discovery), :plan-solve (implementation), :verify (validation)"

# Toad - Documentation
add_modifier_section "toad.md" "toad" ":cot (structure), :mind-map (organization), :reflection (completeness), :verify (accuracy)"

# Fire Trio - Combined review
add_modifier_section "fire-trio.md" "fire-trio" ":multi-agent (3 perspectives), :debate (consensus), :verify (validation), :reflection (synthesis)"

# Mario Orchestra - Full collaboration  
add_modifier_section "mario-orchestra.md" "mario-orchestra" ":multi-agent (full team), :got (complex systems), :debate (consensus), :plan-solve (execution)"

echo ""
echo "🎊 Thinking Modifiers System Applied to All Commands!"
echo ""
echo "Usage examples:"
echo "  /mario:cot 'solve problem step by step'"
echo "  /luigi:hypothesis+verify 'debug memory leak'"
echo "  /peach:mind-map+got 'design architecture'"
echo "  /bowser:react+what-if 'optimize for scale'"
echo ""
echo "Combined modifiers: Use + to chain strategies"
echo "  /mario:cot+reflection"
echo "  /luigi:tot+verify+reflection"