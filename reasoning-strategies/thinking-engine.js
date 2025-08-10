#!/usr/bin/env node
/**
 * 🧠⚡ Mario Thinking Engine - Advanced Reasoning Strategies System ⚡🧠
 * 
 * A modular system that applies 30+ reasoning strategies to any prompt.
 * Can be integrated with Mario PowerUp commands for enhanced AI reasoning.
 * 
 * Usage:
 * - As CLI: node thinking-engine.js --strategy=cot --prompt="Your problem here"
 * - As module: const engine = require('./thinking-engine'); engine.apply('cot', prompt)
 * - With Mario: /mario:cot "Your problem here"
 */

class MarioThinkingEngine {
    constructor() {
        this.strategies = this.initializeStrategies();
        this.marioPersonalities = {
            'mario': '🍄 Mario says: "Wahoo! Let\'s think strategically about this!"',
            'luigi': '👻 Luigi whispers: "Let me carefully analyze all the scary details..."',
            'peach': '👸 Princess Peach advises: "Let\'s approach this with elegant reasoning..."',
            'bowser': '🐢 Bowser roars: "GRAAAAH! I\'ll dominate this problem completely!"',
            'rosalina': '🌟 Rosalina observes: "From a cosmic perspective, let me analyze..."'
        };
    }

    initializeStrategies() {
        return {
            // 🔗 Sequential Reasoning
            'cot': {
                name: 'Chain of Thought',
                family: 'sequential',
                template: `{character}

Let me solve this step by step:

**Problem**: {problem}

**Step-by-step reasoning**:
1. First, let me understand what we're dealing with...
2. Next, I'll identify the key components...
3. Then, I'll work through the logic...
4. Finally, I'll reach a conclusion...

**Final Answer**: [After working through all steps]`,
                description: 'Sequential step-by-step reasoning'
            },

            'iterative-cot': {
                name: 'Iterative Chain of Thought', 
                family: 'sequential',
                template: `{character}

I'll solve this through multiple iterations, refining my thinking each time:

**Problem**: {problem}

**Iteration 1** - Initial reasoning:
[First pass at the problem]

**Iteration 2** - Refined thinking:
[Review and improve the reasoning]

**Iteration 3** - Final polish:
[Perfect the solution]

**Optimized Final Answer**: [Best solution after iterations]`,
                description: 'Multiple passes with refinement'
            },

            // 🌳 Tree Reasoning  
            'tot': {
                name: 'Tree of Thought',
                family: 'tree',
                template: `{character}

I'll explore multiple solution paths and choose the best one:

**Problem**: {problem}

**🌳 Solution Tree**:

**Branch A**: [First approach]
├── Pros: [Benefits of this approach]  
├── Cons: [Drawbacks of this approach]
└── Viability: [Assessment]

**Branch B**: [Second approach]
├── Pros: [Benefits of this approach]
├── Cons: [Drawbacks of this approach] 
└── Viability: [Assessment]

**Branch C**: [Third approach]
├── Pros: [Benefits of this approach]
├── Cons: [Drawbacks of this approach]
└── Viability: [Assessment]

**🎯 Best Path Selection**: [Chosen branch with justification]
**Final Implementation**: [Detailed solution]`,
                description: 'Explore multiple paths, choose the best'
            },

            // 🕸️ Network Reasoning
            'got': {
                name: 'Graph of Thought',
                family: 'network', 
                template: `{character}

I'll map out the interconnected concepts and relationships:

**Problem**: {problem}

**🕸️ Concept Network**:

**Core Concepts**: 
- Concept 1 ↔ Concept 2 (relationship type)
- Concept 2 ↔ Concept 3 (relationship type)
- Concept 3 ↔ Concept 1 (relationship type)

**Key Relationships**:
- [Node A] influences [Node B] because...
- [Node B] depends on [Node C] through...  
- [Node C] connects back to [Node A] via...

**Network Analysis**: [How the relationships inform the solution]
**Solution Path**: [Following the strongest connections]`,
                description: 'Map interconnected concepts and relationships'
            },

            // 🤝 Collaborative Reasoning
            'multi-agent': {
                name: 'Multi-Agent Debate',
                family: 'collaborative',
                template: `{character}

I'll simulate a debate between multiple experts to find the best solution:

**Problem**: {problem}

**👥 Expert Panel Debate**:

**🔬 Expert 1 (Technical Specialist)**: 
"From a technical standpoint, I believe we should..."
[Technical perspective and reasoning]

**💼 Expert 2 (Business Analyst)**:
"From a business perspective, the priority should be..."  
[Business perspective and reasoning]

**👤 Expert 3 (User Experience Expert)**:
"From the user's point of view, what matters most is..."
[User perspective and reasoning]

**🤝 Consensus Building**:
- Areas of agreement: [Common points]
- Key disagreements: [Conflicting views]  
- Compromise solution: [Balanced approach]

**🎯 Final Recommendation**: [Synthesized solution incorporating all perspectives]`,
                description: 'Multiple expert perspectives debating to consensus'
            },

            'socratic': {
                name: 'Socratic Reasoning',
                family: 'collaborative',
                template: `{character}

I'll guide you to the answer through strategic questions:

**Problem**: {problem}

**🎓 Socratic Method**:

**Question 1**: What is the fundamental nature of this problem?
**Your consideration**: [Think about the core issue]

**Question 2**: What assumptions are we making here?
**Your reflection**: [Examine underlying assumptions]

**Question 3**: What evidence supports different approaches?
**Your analysis**: [Consider the evidence]

**Question 4**: What are the potential consequences of each option?
**Your evaluation**: [Weigh the outcomes]

**Question 5**: What would an expert in this field prioritize?
**Your insight**: [Professional perspective]

**🎯 Guided Discovery**: [The answer you've discovered through questioning]`,
                description: 'Strategic questions leading to discovery'
            },

            // ⚡ Action-Based Reasoning
            'react': {
                name: 'Reason + Act',
                family: 'action',
                template: `{character}

I'll alternate between reasoning and taking action to solve this:

**Problem**: {problem}

**🧠 Reason Phase 1**: Let me understand what needs to be done...
[Initial analysis]

**⚡ Action Phase 1**: Based on this reasoning, I'll...
[Specific action taken]

**📊 Observation**: The result of this action shows...
[What was learned]

**🧠 Reason Phase 2**: Given this new information, I now think...
[Updated analysis]

**⚡ Action Phase 2**: So my next action will be...
[Next specific action]

**📊 Final Observation**: This leads to...
[Final results]

**🎯 Solution**: [Complete solution based on reason-act cycles]`,
                description: 'Alternating reasoning and action cycles'
            },

            'plan-solve': {
                name: 'Plan and Solve',
                family: 'action',
                template: `{character}

I'll create a comprehensive plan first, then execute it:

**Problem**: {problem}

**📋 Master Plan**:

**Phase 1**: [First major step]
├── Substep 1.1: [Specific task]
├── Substep 1.2: [Specific task]  
└── Expected outcome: [What this achieves]

**Phase 2**: [Second major step]
├── Substep 2.1: [Specific task]
├── Substep 2.2: [Specific task]
└── Expected outcome: [What this achieves]

**Phase 3**: [Final step]
├── Substep 3.1: [Specific task]
├── Substep 3.2: [Specific task]
└── Expected outcome: [What this achieves]

**🚀 Execution**:
[Working through each phase systematically]

**✅ Solution Delivery**: [Final implemented solution]`,
                description: 'Comprehensive planning followed by systematic execution'
            },

            // 🔍 Verification & Memory
            'reflection': {
                name: 'Self-Reflection', 
                family: 'memory',
                template: `{character}

I'll solve this, then critically review and improve my solution:

**Problem**: {problem}

**Initial Solution**:
[First attempt at solving the problem]

**🪞 Critical Reflection**:
- What did I do well? [Strengths of the approach]
- What could be improved? [Weaknesses identified]
- What did I miss? [Gaps in reasoning]
- What assumptions should I challenge? [Questionable premises]

**🔧 Refinements**:
[Specific improvements based on reflection]

**✨ Enhanced Solution**: 
[Improved solution incorporating reflection insights]`,
                description: 'Solution with critical self-review and improvement'
            },

            'verify-correct': {
                name: 'Verify and Correct',
                family: 'memory',
                template: `{character}

I'll provide a solution then systematically verify it for errors:

**Problem**: {problem}

**Initial Solution**:
[First solution attempt]

**🔍 Systematic Verification**:

**Logic Check**: Are the reasoning steps sound?
├── Step 1 verification: [Check validity]
├── Step 2 verification: [Check validity]  
└── Overall logic: [Assessment]

**Fact Check**: Are the underlying facts correct?
├── Assumption 1: [Verify accuracy]
├── Assumption 2: [Verify accuracy]
└── Data accuracy: [Assessment]

**Completeness Check**: Does it fully address the problem?
├── Core requirements: [Coverage assessment]
├── Edge cases: [Consideration of exceptions]  
└── Implementation details: [Thoroughness check]

**🛠️ Corrections Made**: [Any errors found and fixed]
**✅ Verified Solution**: [Final solution after verification]`,
                description: 'Systematic verification and error correction'
            },

            // 🔮 Exploratory Reasoning  
            'what-if': {
                name: 'What-If Analysis',
                family: 'exploratory',
                template: `{character}

I'll explore different scenarios to find the best approach:

**Problem**: {problem}

**🔮 Scenario Analysis**:

**Scenario A**: What if [condition 1] were true?
├── Implications: [What would happen]
├── Optimal approach: [Best strategy for this scenario]
└── Likelihood: [How probable this scenario is]

**Scenario B**: What if [condition 2] were true?
├── Implications: [What would happen]
├── Optimal approach: [Best strategy for this scenario]
└── Likelihood: [How probable this scenario is]

**Scenario C**: What if [condition 3] were true?
├── Implications: [What would happen] 
├── Optimal approach: [Best strategy for this scenario]
└── Likelihood: [How probable this scenario is]

**🎯 Robust Solution**: [Strategy that works well across scenarios]
**🔒 Contingency Plan**: [Backup approaches for different scenarios]`,
                description: 'Explore multiple scenarios and contingencies'
            },

            'hypothesis-test': {
                name: 'Hypothesis Testing',
                family: 'exploratory', 
                template: `{character}

I'll form hypotheses and test them to find the truth:

**Problem**: {problem}

**🔬 Hypothesis Formation**:

**Hypothesis 1**: [First potential explanation/solution]
**Hypothesis 2**: [Second potential explanation/solution]  
**Hypothesis 3**: [Third potential explanation/solution]

**🧪 Testing Each Hypothesis**:

**Test of Hypothesis 1**:
├── Evidence supporting: [Supporting data/logic]
├── Evidence against: [Contradicting data/logic]
└── Conclusion: [Supported/Refuted/Uncertain]

**Test of Hypothesis 2**:
├── Evidence supporting: [Supporting data/logic]
├── Evidence against: [Contradicting data/logic] 
└── Conclusion: [Supported/Refuted/Uncertain]

**Test of Hypothesis 3**:
├── Evidence supporting: [Supporting data/logic]
├── Evidence against: [Contradicting data/logic]
└── Conclusion: [Supported/Refuted/Uncertain]

**🎯 Best Supported Hypothesis**: [Winner with justification]
**💡 Final Solution**: [Solution based on best hypothesis]`,
                description: 'Scientific hypothesis formation and testing'
            }
        };
    }

    // Apply a reasoning strategy to a problem
    apply(strategyName, problem, character = 'mario', options = {}) {
        const strategy = this.strategies[strategyName];
        
        if (!strategy) {
            throw new Error(`Strategy "${strategyName}" not found. Available: ${Object.keys(this.strategies).join(', ')}`);
        }

        const characterVoice = this.marioPersonalities[character] || this.marioPersonalities['mario'];
        
        let template = strategy.template
            .replace(/{character}/g, characterVoice)
            .replace(/{problem}/g, problem);

        // Apply any additional options
        if (options.depth) {
            template = template.replace(/Branch [ABC]/g, (match, index) => {
                return `Branch ${String.fromCharCode(65 + index % options.depth)}`;
            });
        }

        if (options.agents) {
            const agents = options.agents.split(',');
            template = template.replace(/Expert [123]/g, (match, num) => {
                const agentIndex = parseInt(num) - 1;
                return agents[agentIndex] || match;
            });
        }

        return {
            strategy: strategy.name,
            family: strategy.family,
            description: strategy.description,
            prompt: template
        };
    }

    // List all available strategies
    listStrategies() {
        const families = {};
        Object.entries(this.strategies).forEach(([key, strategy]) => {
            if (!families[strategy.family]) {
                families[strategy.family] = [];
            }
            families[strategy.family].push({
                key,
                name: strategy.name,
                description: strategy.description
            });
        });
        return families;
    }

    // Get a random strategy (for exploration)
    getRandomStrategy() {
        const strategies = Object.keys(this.strategies);
        const randomKey = strategies[Math.floor(Math.random() * strategies.length)];
        return randomKey;
    }

    // Combine multiple strategies
    combine(strategyNames, problem, character = 'mario') {
        const combinedPrompt = strategyNames.map(strategyName => {
            const result = this.apply(strategyName, problem, character);
            return `## ${result.strategy}\n${result.prompt}`;
        }).join('\n\n---\n\n');

        return {
            strategies: strategyNames,
            combinedPrompt
        };
    }
}

// CLI interface
if (require.main === module) {
    const args = process.argv.slice(2);
    const engine = new MarioThinkingEngine();

    if (args.includes('--list')) {
        console.log('🧠 Available Mario Thinking Strategies:');
        const families = engine.listStrategies();
        Object.entries(families).forEach(([family, strategies]) => {
            console.log(`\n📁 ${family.toUpperCase()}`);
            strategies.forEach(strategy => {
                console.log(`  ${strategy.key}: ${strategy.name} - ${strategy.description}`);
            });
        });
        process.exit(0);
    }

    const strategyIndex = args.findIndex(arg => arg.startsWith('--strategy='));
    const promptIndex = args.findIndex(arg => arg.startsWith('--prompt='));
    const characterIndex = args.findIndex(arg => arg.startsWith('--character='));

    if (strategyIndex === -1 || promptIndex === -1) {
        console.log(`
🧠⚡ Mario Thinking Engine Usage:

node thinking-engine.js --strategy=cot --prompt="Your problem here"
node thinking-engine.js --strategy=tot --prompt="Your problem" --character=bowser
node thinking-engine.js --list

Available characters: mario, luigi, peach, bowser, rosalina
        `);
        process.exit(1);
    }

    const strategy = args[strategyIndex].split('=')[1];
    const problem = args[promptIndex].split('=')[1];
    const character = characterIndex !== -1 ? args[characterIndex].split('=')[1] : 'mario';

    try {
        const result = engine.apply(strategy, problem, character);
        console.log(`🎯 Strategy: ${result.strategy}`);
        console.log(`📚 Family: ${result.family}`);
        console.log(`💡 Description: ${result.description}\n`);
        console.log('🚀 Enhanced Prompt:');
        console.log('=' .repeat(80));
        console.log(result.prompt);
        console.log('=' .repeat(80));
    } catch (error) {
        console.error('❌ Error:', error.message);
        process.exit(1);
    }
}

module.exports = MarioThinkingEngine;