---
name: [COMMAND_NAME]
description: [CHARACTER_NAME] - Intelligent Multi-Language [SPECIALTY] with automatic language detection
subagent_type: [SUBAGENT_TYPE]
---

# [EMOJI] [CHARACTER_NAME] - Intelligent Multi-Language [SPECIALTY]

**"[CHARACTER_CATCHPHRASE] Let me automatically detect your programming language and provide specialized assistance!"**

[CHARACTER_NAME] now features advanced language detection capabilities, automatically identifying programming languages and technologies from your input to provide the most relevant assistance across 70+ programming languages.

## 🧠 **Intelligent Language Detection System:**

### **🔍 Automatic Language Detection Process**

```typescript
/**
 * Intelligent command execution with automatic language detection
 * 
 * This command automatically:
 * 1. Detects programming language from user input
 * 2. Routes to appropriate language specialist
 * 3. Applies character-specific expertise 
 * 4. Generates professional, language-specific solutions
 */
export class Intelligent[CHARACTER_NAME][SPECIALTY]Service {
  private languageDetector: LanguageDetectionService;
  private [characterName]Specialists: Map<string, LanguageSpecialist>;
  
  constructor() {
    this.languageDetector = new LanguageDetectionService();
    this.[characterName]Specialists = this.initializeSpecialists();
  }
  
  /**
   * Executes intelligent [SPECIALTY_DESCRIPTION] with automatic language detection
   * 
   * @param userRequest - User's coding request
   * @param context - Additional context (files, project structure)
   * @returns Promise<SpecializedResponse> - Language-specific response
   * 
   * @example
   * ```typescript
   * const service = new Intelligent[CHARACTER_NAME][SPECIALTY]Service();
   * 
   * // Automatic detection examples:
   * const pythonResult = await service.executeIntelligent[SPECIALTY](
   *   "create a REST API with authentication and rate limiting"
   * );
   * // → Detects: Backend → Routes to [CHARACTER_NAME] Python/Node.js Specialist
   * 
   * const reactResult = await service.executeIntelligent[SPECIALTY](
   *   "optimize this component for better performance"
   * );
   * // → Detects: Frontend → Routes to [CHARACTER_NAME] React/TypeScript Specialist
   * 
   * const rustResult = await service.executeIntelligent[SPECIALTY](
   *   "implement concurrent file processing with error handling"
   * );
   * // → Detects: Systems → Routes to [CHARACTER_NAME] Rust/Go Specialist
   * ```
   */
  async executeIntelligent[SPECIALTY](
    userRequest: string,
    context: RequestContext = {}
  ): Promise<SpecializedResponse> {
    const executionStartTime = Date.now();
    
    try {
      // Step 1: Perform intelligent language detection
      const detectionResult = await this.languageDetector.detectLanguage(
        userRequest,
        context
      );
      
      // Step 2: Route to appropriate [CHARACTER_NAME] specialist
      const specialist = this.getLanguageSpecialist(
        detectionResult.language,
        detectionResult.category
      );
      
      // Step 3: Execute [CHARACTER_NAME]'s specialized approach
      const specializedResponse = await specialist.execute[SPECIALTY](
        userRequest,
        detectionResult,
        context
      );
      
      // Step 4: Apply [CHARACTER_NAME]'s personality and expertise
      const [characterName]Response = this.apply[CHARACTER_NAME]Personality(
        specializedResponse,
        detectionResult
      );
      
      return {
        detection: detectionResult,
        specialist: specialist.constructor.name,
        response: [characterName]Response,
        character: '[CHARACTER_NAME]',
        executionTime: Date.now() - executionStartTime,
        success: true
      };
      
    } catch (error) {
      console.error('Intelligent [SPECIALTY] execution failed:', error);
      
      // Fallback to general [CHARACTER_NAME] approach
      return this.executeGeneral[SPECIALTY](userRequest, context);
    }
  }
  
  /**
   * Gets the appropriate language specialist for [CHARACTER_NAME]
   */
  private getLanguageSpecialist(
    language: string,
    category: string
  ): LanguageSpecialist {
    const specialistKey = `[characterName]-${category}-specialist`;
    
    return this.[characterName]Specialists.get(specialistKey) || 
           this.[characterName]Specialists.get('[characterName]-general-specialist');
  }
  
  /**
   * Initializes all [CHARACTER_NAME] language specialists
   */
  private initializeSpecialists(): Map<string, LanguageSpecialist> {
    const specialists = new Map();
    
    // Frontend specialists - [CHARACTER_NAME]'s approach to web development
    specialists.set('[characterName]-frontend-specialist', new [CHARACTER_NAME]FrontendSpecialist());
    
    // Backend specialists - [CHARACTER_NAME]'s approach to server-side development  
    specialists.set('[characterName]-backend-specialist', new [CHARACTER_NAME]BackendSpecialist());
    
    // Mobile specialists - [CHARACTER_NAME]'s approach to mobile development
    specialists.set('[characterName]-mobile-specialist', new [CHARACTER_NAME]MobileSpecialist());
    
    // Data science specialists - [CHARACTER_NAME]'s approach to data analysis
    specialists.set('[characterName]-datascience-specialist', new [CHARACTER_NAME]DataScienceSpecialist());
    
    // Systems specialists - [CHARACTER_NAME]'s approach to systems programming
    specialists.set('[characterName]-systems-specialist', new [CHARACTER_NAME]SystemsSpecialist());
    
    // DevOps specialists - [CHARACTER_NAME]'s approach to infrastructure
    specialists.set('[characterName]-devops-specialist', new [CHARACTER_NAME]DevOpsSpecialist());
    
    // Functional specialists - [CHARACTER_NAME]'s approach to functional programming
    specialists.set('[characterName]-functional-specialist', new [CHARACTER_NAME]FunctionalSpecialist());
    
    // Gaming specialists - [CHARACTER_NAME]'s approach to game development
    specialists.set('[characterName]-gaming-specialist', new [CHARACTER_NAME]GamingSpecialist());
    
    // Blockchain specialists - [CHARACTER_NAME]'s approach to blockchain development
    specialists.set('[characterName]-blockchain-specialist', new [CHARACTER_NAME]BlockchainSpecialist());
    
    // General specialist - [CHARACTER_NAME]'s general approach
    specialists.set('[characterName]-general-specialist', new [CHARACTER_NAME]GeneralSpecialist());
    
    return specialists;
  }
}

/**
 * [CHARACTER_NAME] Frontend Specialist - Web development with [CHARACTER_TRAIT]
 * 
 * Handles: HTML, CSS, JavaScript, TypeScript, React, Vue, Angular, Svelte
 * Approach: [CHARACTER_SPECIFIC_FRONTEND_APPROACH]
 */
class [CHARACTER_NAME]FrontendSpecialist extends LanguageSpecialist {
  async execute[SPECIALTY](
    userRequest: string,
    detection: LanguageDetectionResult,
    context: RequestContext
  ): Promise<SpecializedResponse> {
    const response: SpecializedResponse = {
      approach: '[CHARACTER_NAME]\'s [CHARACTER_TRAIT] frontend development',
      reasoning: this.generateFrontendReasoning(userRequest, detection),
      solution: await this.generateFrontendSolution(userRequest, detection),
      bestPractices: this.getFrontendBestPractices(detection.language),
      testing: this.getFrontendTestingStrategy(detection.language),
      optimization: this.getFrontendOptimization(detection.language)
    };
    
    return response;
  }
  
  private generateFrontendReasoning(
    userRequest: string,
    detection: LanguageDetectionResult
  ): string {
    return `[CHARACTER_REASONING_STYLE] for ${detection.language} frontend development:
    
1. **Language Analysis**: Detected ${detection.language} with ${(detection.confidence * 100).toFixed(1)}% confidence
2. **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_FRONTEND_REASONING]
3. **Technology Selection**: Optimal tools for ${detection.language} development
4. **Implementation Strategy**: [CHARACTER_TRAIT] approach to solve the user's request
5. **Quality Assurance**: [CHARACTER_SPECIFIC_QUALITY_APPROACH]`;
  }
  
  private async generateFrontendSolution(
    userRequest: string,
    detection: LanguageDetectionResult
  ): Promise<CodeSolution> {
    // Generate language-specific frontend solution
    switch (detection.language) {
      case 'react':
      case 'javascript':
      case 'typescript':
        return this.generateReactSolution(userRequest, detection);
      case 'vue':
        return this.generateVueSolution(userRequest, detection);
      case 'angular':
        return this.generateAngularSolution(userRequest, detection);
      case 'svelte':
        return this.generateSvelteSolution(userRequest, detection);
      default:
        return this.generateGeneralFrontendSolution(userRequest, detection);
    }
  }
}

/**
 * [CHARACTER_NAME] Backend Specialist - Server-side development with [CHARACTER_TRAIT]
 * 
 * Handles: Python, Node.js, Java, C#, Go, Rust, PHP, Ruby, Scala, Elixir
 * Approach: [CHARACTER_SPECIFIC_BACKEND_APPROACH]
 */
class [CHARACTER_NAME]BackendSpecialist extends LanguageSpecialist {
  async execute[SPECIALTY](
    userRequest: string,
    detection: LanguageDetectionResult,
    context: RequestContext
  ): Promise<SpecializedResponse> {
    const response: SpecializedResponse = {
      approach: '[CHARACTER_NAME]\'s [CHARACTER_TRAIT] backend development',
      reasoning: this.generateBackendReasoning(userRequest, detection),
      solution: await this.generateBackendSolution(userRequest, detection),
      architecture: this.getBackendArchitecture(detection.language),
      security: this.getBackendSecurity(detection.language),
      scalability: this.getBackendScalability(detection.language)
    };
    
    return response;
  }
}

// [Continue with other specialists...]
```

## 🎯 **Intelligent Command Usage Examples:**

### **🔍 Automatic Language Detection:**
```bash
# The command automatically detects the language and routes appropriately
/[command-name] "create a user authentication system with JWT tokens"
# → Detects: Backend context → Routes to appropriate backend specialist

/[command-name] "optimize this sorting algorithm for large datasets"  
# → Detects: Performance context → Routes to systems/performance specialist

/[command-name] "build a responsive dashboard with real-time updates"
# → Detects: Frontend context → Routes to frontend specialist

/[command-name] "implement machine learning model for image classification"
# → Detects: Data science context → Routes to data science specialist
```

### **🎯 Explicit Language Specification:**
```bash
# Explicit language specification overrides automatic detection
/[command-name]:python "create authentication system with JWT tokens"
# → Explicit Python → Routes to [CHARACTER_NAME] Python Backend Specialist

/[command-name]:rust "optimize sorting algorithm for performance"
# → Explicit Rust → Routes to [CHARACTER_NAME] Rust Systems Specialist

/[command-name]:react "build responsive dashboard component"
# → Explicit React → Routes to [CHARACTER_NAME] React Frontend Specialist
```

### **📁 File-Based Detection:**
```bash
# Automatic detection from file extensions
/[command-name] --file="src/components/UserForm.tsx" "improve this component"
# → Detects: .tsx → TypeScript React → Routes to React specialist

/[command-name] --file="api/main.go" "add error handling"
# → Detects: .go → Go → Routes to Go backend specialist

/[command-name] --file="analysis.py" "optimize data processing pipeline"
# → Detects: .py → Python → Routes to Python data science specialist
```

## [CHARACTER_EMOJI] **[CHARACTER_NAME]'s Language Specializations:**

### **🌐 Frontend Excellence ([CHARACTER_TRAIT] Web Development)**
- **Languages**: HTML, CSS, JavaScript, TypeScript, JSX, TSX
- **Frameworks**: React, Vue, Angular, Svelte, Next.js, Nuxt.js
- **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_FRONTEND_DESCRIPTION]

### **🔧 Backend Mastery ([CHARACTER_TRAIT] Server Development)**
- **Languages**: Python, Node.js, Java, C#, Go, Rust, PHP, Ruby
- **Frameworks**: Express, Django, Flask, Spring, Laravel, Rails
- **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_BACKEND_DESCRIPTION]

### **📱 Mobile Innovation ([CHARACTER_TRAIT] Mobile Development)**
- **Languages**: Kotlin, Swift, Dart, Java, C#, JavaScript
- **Frameworks**: Flutter, React Native, Xamarin, Ionic
- **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_MOBILE_DESCRIPTION]

### **📊 Data Science Power ([CHARACTER_TRAIT] Data Analysis)**
- **Languages**: Python, R, Julia, SQL, Scala
- **Frameworks**: Pandas, NumPy, TensorFlow, PyTorch, Spark
- **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_DATA_DESCRIPTION]

### **⚡ Systems Programming ([CHARACTER_TRAIT] Low-Level Development)**
- **Languages**: C, C++, Rust, Go, Zig, Assembly
- **Areas**: Embedded, Kernel, Drivers, Performance-critical
- **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_SYSTEMS_DESCRIPTION]

### **🚀 DevOps & Infrastructure ([CHARACTER_TRAIT] Operations)**
- **Languages**: Bash, PowerShell, YAML, Terraform, Ansible
- **Platforms**: Docker, Kubernetes, AWS, GCP, Azure
- **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_DEVOPS_DESCRIPTION]

### **🧮 Functional Programming ([CHARACTER_TRAIT] Mathematical Computing)**
- **Languages**: Haskell, OCaml, F#, Elm, Clojure, Erlang
- **Paradigms**: Pure functions, Immutability, Type systems
- **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_FUNCTIONAL_DESCRIPTION]

### **🎮 Game Development ([CHARACTER_TRAIT] Interactive Entertainment)**
- **Languages**: C++, C#, Lua, GDScript, HLSL, GLSL
- **Engines**: Unity, Unreal, Godot, Custom engines
- **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_GAMING_DESCRIPTION]

### **⛓️ Blockchain & Web3 ([CHARACTER_TRAIT] Decentralized Systems)**
- **Languages**: Solidity, Vyper, Rust, Go, JavaScript
- **Platforms**: Ethereum, Polygon, Solana, Smart contracts
- **[CHARACTER_NAME]'s Approach**: [CHARACTER_SPECIFIC_BLOCKCHAIN_DESCRIPTION]

## 🎯 **Advanced Features:**

### **🧠 Context-Aware Detection**
- Analyzes user intent, project structure, and code patterns
- Considers file extensions, import statements, and syntax
- Learns from interaction patterns for improved accuracy

### **🔄 Adaptive Routing**
- Routes complex requests to multiple specialists when needed
- Handles polyglot projects with multiple technologies
- Provides fallback routing for ambiguous requests

### **📈 Continuous Learning**
- Improves detection accuracy based on user feedback
- Adapts to new language trends and frameworks
- Updates specialist knowledge with latest best practices

---

**Usage**: Simply describe your coding task naturally - the intelligent system will automatically detect the programming language and provide [CHARACTER_NAME]'s specialized expertise for optimal results!

*"[CHARACTER_CLOSING_QUOTE] With intelligent language detection, I can help you excel in any programming language!"* - [CHARACTER_NAME] [CHARACTER_EMOJI]

## 🛠️ **Template Variables to Replace:**

When creating a new intelligent command, replace these variables:

- `[COMMAND_NAME]` - Actual command name (e.g., mario-code, luigi-debug)
- `[CHARACTER_NAME]` - Character name (e.g., Mario, Luigi, Princess Peach)
- `[CHARACTER_EMOJI]` - Character emoji (e.g., 🍄, 👻, 👸)
- `[SUBAGENT_TYPE]` - Appropriate subagent type
- `[SPECIALTY]` - Command specialty (e.g., Code, Debug, Architect)
- `[CHARACTER_CATCHPHRASE]` - Character's signature saying
- `[CHARACTER_TRAIT]` - Character's main trait (enthusiastic, careful, elegant)
- `[characterName]` - Lowercase character name for variables
- `[CHARACTER_REASONING_STYLE]` - How the character approaches reasoning
- `[CHARACTER_SPECIFIC_*_APPROACH]` - Character-specific approaches for each domain
- `[CHARACTER_CLOSING_QUOTE]` - Character's closing statement