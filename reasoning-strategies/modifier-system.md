# 🧠⚡ Mario Thinking Modifiers System ⚡🧠

## How it Works

You can add **thinking modifiers** to ANY Mario command using the `:` syntax:

```bash
/mario:cot "solve this problem"           # Chain of Thought
/luigi:tot "debug this issue"             # Tree of Thought  
/peach:react "design architecture"        # Reason + Act
/bowser:multi-agent "optimize performance" # Multi-Agent Debate
```

## Available Modifiers

### 🔗 Sequential Reasoning
- `:cot` - Chain of Thought (step-by-step)
- `:iterative-cot` - Iterative refinement
- `:rot` - Rule of Thought (rule-based)

### 🌳 Tree Reasoning
- `:tot` - Tree of Thought (explore paths)
- `:monte-carlo` - Random exploration
- `:bfs` - Breadth-first search
- `:dfs` - Depth-first search

### 🕸️ Network Reasoning
- `:got` - Graph of Thought (concept mapping)
- `:mind-map` - Visual mind mapping

### 🤝 Collaborative
- `:self-ask` - Self-questioning
- `:multi-agent` - Multiple perspectives
- `:socratic` - Socratic method
- `:debate` - Expert debate

### ⚡ Action-Based
- `:react` - Reason + Act cycles
- `:pal` - Program-aided reasoning
- `:plan-solve` - Plan then execute
- `:self-consistency` - Multiple solutions

### 🔍 Verification
- `:reflection` - Self-review
- `:verify` - Verify and correct
- `:scratch` - Scratchpad thinking

### 🔮 Exploratory
- `:what-if` - Scenario analysis
- `:counterfactual` - Alternative outcomes
- `:hypothesis` - Hypothesis testing

## Combining Modifiers

You can combine multiple modifiers with `+`:

```bash
/mario:cot+reflection "refactor this code"
# Uses Chain of Thought THEN Self-Reflection

/luigi:tot+verify "find security issues"  
# Uses Tree of Thought THEN Verification

/peach:socratic+got "design system architecture"
# Uses Socratic Method WITH Graph of Thought

/bowser:react+what-if "optimize for scale"
# Uses Reason+Act WITH What-If Analysis
```

## Character-Specific Optimizations

Each character has default modifiers that work best with their personality:

- **Mario** → `:cot` (strategic thinking)
- **Luigi** → `:verify` (careful analysis)
- **Peach** → `:mind-map` (elegant structure)
- **Bowser** → `:react` (aggressive action)
- **Rosalina** → `:got` (systems thinking)
- **Dr. Mario** → `:hypothesis` (diagnostic)
- **Toadette** → `:multi-agent` (global perspectives)

## Examples

### Simple Modifier
```bash
/mario:cot "create user authentication"
```
Mario will use Chain of Thought to break down the authentication system step by step.

### Complex Problem with Tree Exploration
```bash
/luigi:tot "choose between MongoDB and PostgreSQL for our app"
```
Luigi will explore multiple decision branches with pros/cons.

### Multi-Agent Architecture Design
```bash
/peach:multi-agent "design microservices for e-commerce"
```
Peach will simulate a debate between different architectural experts.

### Combined Strategy for Complex Debugging
```bash
/luigi:hypothesis+verify+reflection "memory leak in production"
```
Luigi will:
1. Form hypotheses about the leak
2. Verify each hypothesis
3. Reflect on findings and provide solution

## Advanced Usage

### Custom Depth
```bash
/mario:tot[depth=5] "evaluate deployment strategies"
# Explores 5 branches instead of default 3
```

### Specific Agents
```bash
/peach:multi-agent[agents=security,ux,performance] "design dashboard"
# Simulates debate between security, UX, and performance experts
```

### Iteration Count
```bash
/mario:iterative-cot[iterations=5] "optimize algorithm"
# Performs 5 refinement iterations
```

## Quick Reference Card

| Modifier | What it Does | Best For |
|----------|-------------|----------|
| `:cot` | Step-by-step reasoning | Problem solving |
| `:tot` | Explore multiple paths | Decision making |
| `:got` | Map relationships | Complex systems |
| `:multi-agent` | Multiple perspectives | Balanced solutions |
| `:react` | Reason then act | Implementation tasks |
| `:reflection` | Self-critique | Quality improvement |
| `:what-if` | Scenario analysis | Risk assessment |
| `:hypothesis` | Test assumptions | Debugging |
| `:socratic` | Guided questions | Learning/discovery |
| `:verify` | Error checking | Critical tasks |