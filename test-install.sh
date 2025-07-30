#!/bin/bash
# Test installation script to verify everything works correctly

echo "🧪 Testing Mario PowerUps Installation Requirements"
echo ""

# Test 1: Check all required files exist
echo "1️⃣ Checking required files..."
MISSING_FILES=0

# Core directories
for dir in powerups orchestra commands hooks; do
    if [ ! -d "$dir" ]; then
        echo "❌ Missing directory: $dir"
        MISSING_FILES=$((MISSING_FILES + 1))
    else
        echo "✅ Directory exists: $dir"
    fi
done

# Core files
for file in install.sh README.md CLAUDE.md ULTIMATE_COMMAND_REFERENCE.md language-detection-service.js character-specialists.js; do
    if [ ! -f "$file" ]; then
        echo "❌ Missing file: $file"
        MISSING_FILES=$((MISSING_FILES + 1))
    else
        echo "✅ File exists: $file"
    fi
done

# Character files
for char in mario.md luigi.md princess-peach.md bowser.md dr-mario.md; do
    if [ ! -f "powerups/characters/$char" ]; then
        echo "❌ Missing character: $char"
        MISSING_FILES=$((MISSING_FILES + 1))
    else
        echo "✅ Character exists: $char"
    fi
done

# Hook files
for hook in coin-collector.sh mario-safety-guardian.sh; do
    if [ ! -f "hooks/$hook" ]; then
        echo "❌ Missing hook: $hook"
        MISSING_FILES=$((MISSING_FILES + 1))
    else
        echo "✅ Hook exists: $hook"
    fi
done

echo ""

# Test 2: Check syntax of key scripts
echo "2️⃣ Checking script syntax..."
SYNTAX_ERRORS=0

if bash -n install.sh 2>/dev/null; then
    echo "✅ install.sh syntax is valid"
else
    echo "❌ install.sh has syntax errors"
    SYNTAX_ERRORS=$((SYNTAX_ERRORS + 1))
fi

for hook in hooks/*.sh; do
    if [ -f "$hook" ]; then
        if bash -n "$hook" 2>/dev/null; then
            echo "✅ $(basename $hook) syntax is valid"
        else
            echo "❌ $(basename $hook) has syntax errors"
            SYNTAX_ERRORS=$((SYNTAX_ERRORS + 1))
        fi
    fi
done

echo ""

# Test 3: Check Node.js files
echo "3️⃣ Checking Node.js files..."
NODE_ERRORS=0

if node -c language-detection-service.js 2>/dev/null; then
    echo "✅ language-detection-service.js syntax is valid"
else
    echo "❌ language-detection-service.js has syntax errors"
    NODE_ERRORS=$((NODE_ERRORS + 1))
fi

if node -c character-specialists.js 2>/dev/null; then
    echo "✅ character-specialists.js syntax is valid"
else
    echo "❌ character-specialists.js has syntax errors"
    NODE_ERRORS=$((NODE_ERRORS + 1))
fi

echo ""

# Test 4: Check hook JSON parsing
echo "4️⃣ Testing hook JSON parsing..."
JSON_ERRORS=0

# Test coin-collector.sh with sample JSON
TEST_JSON='{"tool_name":"Write","tool_response":{"success":true}}'
if echo "$TEST_JSON" | hooks/coin-collector.sh >/dev/null 2>&1; then
    echo "✅ coin-collector.sh can parse JSON input"
else
    echo "❌ coin-collector.sh failed to parse JSON input"
    JSON_ERRORS=$((JSON_ERRORS + 1))
fi

# Test mario-safety-guardian.sh with sample JSON
TEST_JSON='{"tool_name":"Bash","tool_input":{"command":"ls -la"}}'
if echo "$TEST_JSON" | hooks/mario-safety-guardian.sh >/dev/null 2>&1; then
    echo "✅ mario-safety-guardian.sh can parse JSON input"
else
    echo "❌ mario-safety-guardian.sh failed to parse JSON input"
    JSON_ERRORS=$((JSON_ERRORS + 1))
fi

echo ""
echo "📊 Test Summary:"
echo "=================="
echo "Missing files: $MISSING_FILES"
echo "Syntax errors: $SYNTAX_ERRORS"
echo "Node.js errors: $NODE_ERRORS"
echo "JSON parsing errors: $JSON_ERRORS"
echo ""

TOTAL_ERRORS=$((MISSING_FILES + SYNTAX_ERRORS + NODE_ERRORS + JSON_ERRORS))

if [ $TOTAL_ERRORS -eq 0 ]; then
    echo "🎉 All tests passed! Installation should run perfectly!"
    echo "🍄⭐ Mario PowerUps is ready to install! ⭐🍄"
    exit 0
else
    echo "❌ Found $TOTAL_ERRORS errors that need to be fixed before installation"
    exit 1
fi