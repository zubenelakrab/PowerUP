# 🧠⭐ Mario PowerUps - Intelligent Language Detection System ⭐🧠

## 🎯 **Multi-Language Support Architecture**

### **🔍 Automatic Language Detection System:**

```typescript
/**
 * Intelligent Language Detection and Routing Service
 * 
 * Automatically detects programming languages and technologies from user input
 * and routes requests to specialized language experts within each character.
 * 
 * Detection methods:
 * - Natural language processing of user requests
 * - Code pattern recognition and syntax analysis
 * - File extension and project structure analysis
 * - Explicit language specification parsing
 * - Context-aware technology stack inference
 */
export class LanguageDetectionService {
  private readonly languageDatabase = new LanguageDatabase();
  private readonly patternMatcher = new CodePatternMatcher();
  
  /**
   * Language categories for specialized routing
   */
  private readonly languageCategories = {
    frontend: {
      languages: ['html', 'css', 'javascript', 'typescript', 'jsx', 'vue', 'angular', 'react', 'sass', 'scss', 'tailwind'],
      specialist: 'frontend-specialist',
      frameworks: ['react', 'vue', 'angular', 'svelte', 'next', 'nuxt', 'gatsby']
    },
    backend: {
      languages: ['node', 'python', 'java', 'csharp', 'go', 'rust', 'php', 'ruby', 'scala', 'elixir'],
      specialist: 'backend-specialist', 
      frameworks: ['express', 'django', 'flask', 'spring', 'laravel', 'rails', 'gin', 'actix']
    },
    mobile: {
      languages: ['kotlin', 'java', 'swift', 'objectivec', 'dart', 'javascript'],
      specialist: 'mobile-specialist',
      frameworks: ['flutter', 'react-native', 'xamarin', 'ionic']
    },
    datascience: {
      languages: ['python', 'r', 'julia', 'matlab', 'scala', 'sql'],
      specialist: 'data-specialist',
      frameworks: ['pandas', 'numpy', 'tensorflow', 'pytorch', 'spark']
    },
    systems: {
      languages: ['c', 'cpp', 'rust', 'zig', 'assembly', 'go'],
      specialist: 'systems-specialist',
      frameworks: ['embedded', 'kernel', 'drivers']
    },
    devops: {
      languages: ['bash', 'powershell', 'yaml', 'dockerfile', 'terraform', 'ansible'],
      specialist: 'devops-specialist',
      frameworks: ['kubernetes', 'docker', 'aws', 'gcp', 'azure']
    },
    functional: {
      languages: ['haskell', 'ocaml', 'fsharp', 'elm', 'clojure', 'erlang'],
      specialist: 'functional-specialist',
      frameworks: ['reactive', 'pure-functional']
    }
  } as const;

  /**
   * Detects programming language from user input using multiple strategies
   * 
   * @param userInput - User's request text
   * @param context - Additional context (file paths, project info, etc.)
   * @returns Promise<LanguageDetectionResult> - Detected language with confidence
   * 
   * @example
   * ```typescript
   * const detector = new LanguageDetectionService();
   * 
   * // Automatic detection from natural language
   * const result1 = await detector.detectLanguage("create a REST API in Python with FastAPI");
   * // Result: { language: 'python', framework: 'fastapi', confidence: 0.95, category: 'backend' }
   * 
   * // Detection from code patterns
   * const result2 = await detector.detectLanguage("fix this React component", {
   *   code: "const MyComponent = () => { return <div>Hello</div>; }"
   * });
   * // Result: { language: 'javascript', framework: 'react', confidence: 0.98, category: 'frontend' }
   * ```
   */
  async detectLanguage(
    userInput: string,
    context: DetectionContext = {}
  ): Promise<LanguageDetectionResult> {
    const detectionMethods = [
      this.detectFromExplicitMention(userInput),
      this.detectFromCodePatterns(context.code || ''),
      this.detectFromFileExtensions(context.filePaths || []),
      this.detectFromKeywords(userInput),
      this.detectFromProjectStructure(context.projectStructure || {}),
      this.detectFromTechnicalTerms(userInput)
    ];
    
    const results = await Promise.all(detectionMethods);
    
    // Combine results with weighted confidence scoring
    const combinedResult = this.combineDetectionResults(results);
    
    // Determine the appropriate specialist category
    combinedResult.category = this.determineCategory(combinedResult.language);
    combinedResult.specialist = this.selectSpecialist(combinedResult);
    
    return combinedResult;
  }
  
  /**
   * Detects explicit language mentions in user input
   * 
   * Recognizes patterns like:
   * - "in Python"
   * - "using React"
   * - "with Go"
   * - "JavaScript code"
   */
  private async detectFromExplicitMention(input: string): Promise<DetectionResult> {
    const explicitPatterns = {
      // Frontend technologies
      'javascript|js\\b': { language: 'javascript', confidence: 0.9 },
      'typescript|ts\\b': { language: 'typescript', confidence: 0.9 },
      'react|jsx': { language: 'javascript', framework: 'react', confidence: 0.95 },
      'vue\\.?js|vue': { language: 'javascript', framework: 'vue', confidence: 0.95 },
      'angular': { language: 'typescript', framework: 'angular', confidence: 0.95 },
      'html5?': { language: 'html', confidence: 0.9 },
      'css3?|sass|scss': { language: 'css', confidence: 0.9 },
      'tailwind': { language: 'css', framework: 'tailwind', confidence: 0.9 },
      
      // Backend technologies  
      'python': { language: 'python', confidence: 0.95 },
      'node\\.?js|nodejs': { language: 'javascript', runtime: 'node', confidence: 0.95 },
      'java\\b(?!script)': { language: 'java', confidence: 0.9 },
      'golang|\\bgo\\b': { language: 'go', confidence: 0.9 },
      'rust': { language: 'rust', confidence: 0.95 },
      'php': { language: 'php', confidence: 0.95 },
      'ruby': { language: 'ruby', confidence: 0.95 },
      'c#|csharp': { language: 'csharp', confidence: 0.95 },
      
      // Mobile technologies
      'kotlin': { language: 'kotlin', confidence: 0.95 },
      'swift': { language: 'swift', confidence: 0.95 },
      'dart|flutter': { language: 'dart', framework: 'flutter', confidence: 0.95 },
      'react.native': { language: 'javascript', framework: 'react-native', confidence: 0.95 },
      
      // Data science
      '\\br\\b(?!ust)': { language: 'r', confidence: 0.8 },
      'julia': { language: 'julia', confidence: 0.95 },
      'matlab': { language: 'matlab', confidence: 0.95 },
      
      // Systems languages
      '\\bc\\b(?!#|ss)': { language: 'c', confidence: 0.7 },
      'c\\+\\+|cpp': { language: 'cpp', confidence: 0.9 },
      'assembly|asm': { language: 'assembly', confidence: 0.9 },
      
      // DevOps and scripting
      'bash|shell': { language: 'bash', confidence: 0.9 },
      'powershell': { language: 'powershell', confidence: 0.95 },
      'dockerfile|docker': { language: 'dockerfile', confidence: 0.9 },
      'terraform': { language: 'terraform', confidence: 0.95 },
      'yaml|yml': { language: 'yaml', confidence: 0.8 }
    };
    
    const normalizedInput = input.toLowerCase();
    
    for (const [pattern, result] of Object.entries(explicitPatterns)) {
      const regex = new RegExp(pattern, 'i');
      if (regex.test(normalizedInput)) {
        return {
          method: 'explicit-mention',
          ...result,
          evidence: `Detected explicit mention: "${pattern}"`
        };
      }
    }
    
    return { method: 'explicit-mention', confidence: 0 };
  }
  
  /**
   * Detects language from code syntax patterns
   */
  private async detectFromCodePatterns(code: string): Promise<DetectionResult> {
    if (!code.trim()) {
      return { method: 'code-patterns', confidence: 0 };
    }
    
    const syntaxPatterns = {
      // JavaScript/TypeScript patterns
      'const\\s+\\w+\\s*=|let\\s+\\w+\\s*=|var\\s+\\w+\\s*=': { 
        language: 'javascript', confidence: 0.7 
      },
      'interface\\s+\\w+|type\\s+\\w+\\s*=': { 
        language: 'typescript', confidence: 0.8 
      },
      '<\\w+[^>]*>.*</\\w+>': { 
        language: 'jsx', confidence: 0.8 
      },
      
      // Python patterns
      'def\\s+\\w+\\(|class\\s+\\w+\\(|import\\s+\\w+': { 
        language: 'python', confidence: 0.8 
      },
      'if\\s+__name__\\s*==\\s*["\']__main__["\']': { 
        language: 'python', confidence: 0.9 
      },
      
      // Go patterns
      'func\\s+\\w+\\(|package\\s+\\w+|import\\s*\\(': { 
        language: 'go', confidence: 0.8 
      },
      'fmt\\.\\w+|goroutine': { 
        language: 'go', confidence: 0.9 
      },
      
      // Rust patterns
      'fn\\s+\\w+\\(|struct\\s+\\w+|impl\\s+\\w+': { 
        language: 'rust', confidence: 0.8 
      },
      'let\\s+mut\\s+|match\\s+\\w+': { 
        language: 'rust', confidence: 0.9 
      },
      
      // Java patterns
      'public\\s+class\\s+\\w+|public\\s+static\\s+void\\s+main': { 
        language: 'java', confidence: 0.8 
      },
      '@\\w+|System\\.out\\.println': { 
        language: 'java', confidence: 0.7 
      },
      
      // C/C++ patterns
      '#include\\s*<|int\\s+main\\s*\\(': { 
        language: 'c', confidence: 0.7 
      },
      'std::|iostream|vector<': { 
        language: 'cpp', confidence: 0.8 
      },
      
      // PHP patterns
      '<\\?php|\\$\\w+\\s*=': { 
        language: 'php', confidence: 0.8 
      },
      
      // Ruby patterns
      'class\\s+\\w+\\s*<|def\\s+\\w+|puts\\s+': { 
        language: 'ruby', confidence: 0.7 
      }
    };
    
    for (const [pattern, result] of Object.entries(syntaxPatterns)) {
      const regex = new RegExp(pattern, 'i');
      if (regex.test(code)) {
        return {
          method: 'code-patterns',
          ...result,
          evidence: `Detected syntax pattern: "${pattern}"`
        };
      }
    }
    
    return { method: 'code-patterns', confidence: 0 };
  }
}

/**
 * Mario Character Language Specialist Router
 * 
 * Routes detected languages to appropriate specialist implementations
 * within each Mario character, maintaining personality while providing
 * language-specific expertise.
 */
export class MarioLanguageRouter {
  private detectionService = new LanguageDetectionService();
  
  /**
   * Routes user request to appropriate character specialist
   * 
   * @param character - Mario character (mario, luigi, peach, bowser, etc.)
   * @param userRequest - User's coding request
   * @param context - Additional context for detection
   * @returns Promise<SpecialistResponse> - Response from language specialist
   */
  async routeToSpecialist(
    character: MarioCharacter,
    userRequest: string,
    context: RequestContext = {}
  ): Promise<SpecialistResponse> {
    try {
      // Step 1: Detect language and technology
      const detection = await this.detectionService.detectLanguage(
        userRequest,
        context
      );
      
      // Step 2: Route to appropriate specialist within character
      const specialist = this.getCharacterSpecialist(character, detection);
      
      // Step 3: Execute request with specialist
      const response = await specialist.handleRequest(userRequest, detection, context);
      
      return {
        character,
        detection,
        specialist: specialist.constructor.name,
        response,
        processingTime: response.processingTime,
        success: true
      };
      
    } catch (error) {
      console.error('Language routing failed:', error);
      throw new LanguageRoutingError('Failed to route to language specialist', error);
    }
  }
  
  /**
   * Gets the appropriate language specialist for a character
   */
  private getCharacterSpecialist(
    character: MarioCharacter,
    detection: LanguageDetectionResult
  ): LanguageSpecialist {
    const specialistKey = `${character}-${detection.category}-specialist`;
    
    // Character-specific language specialists
    const specialists = {
      // Mario specialists (enthusiastic implementation)
      'mario-frontend-specialist': new MarioFrontendSpecialist(),
      'mario-backend-specialist': new MarioBackendSpecialist(),
      'mario-mobile-specialist': new MarioMobileSpecialist(),
      'mario-datascience-specialist': new MarioDataScienceSpecialist(),
      'mario-systems-specialist': new MarioSystemsSpecialist(),
      'mario-devops-specialist': new MarioDevOpsSpecialist(),
      
      // Luigi specialists (careful debugging and testing)
      'luigi-frontend-specialist': new LuigiFrontendSpecialist(),
      'luigi-backend-specialist': new LuigiBackendSpecialist(),
      'luigi-mobile-specialist': new LuigiMobileSpecialist(),
      'luigi-datascience-specialist': new LuigiDataScienceSpecialist(),
      'luigi-systems-specialist': new LuigiSystemsSpecialist(),
      'luigi-devops-specialist': new LuigiDevOpsSpecialist(),
      
      // Princess Peach specialists (elegant architecture)
      'peach-frontend-specialist': new PeachFrontendSpecialist(),
      'peach-backend-specialist': new PeachBackendSpecialist(),
      'peach-mobile-specialist': new PeachMobileSpecialist(),
      'peach-datascience-specialist': new PeachDataScienceSpecialist(),
      'peach-systems-specialist': new PeachSystemsSpecialist(),
      'peach-devops-specialist': new PeachDevOpsSpecialist(),
      
      // Bowser specialists (performance optimization)
      'bowser-frontend-specialist': new BowserFrontendSpecialist(),
      'bowser-backend-specialist': new BowserBackendSpecialist(),
      'bowser-mobile-specialist': new BowserMobileSpecialist(),
      'bowser-datascience-specialist': new BowserDataScienceSpecialist(),
      'bowser-systems-specialist': new BowserSystemsSpecialist(),
      'bowser-devops-specialist': new BowserDevOpsSpecialist()
    };
    
    const specialist = specialists[specialistKey];
    
    if (!specialist) {
      // Fallback to general specialist for the character
      return new GeneralSpecialist(character, detection);
    }
    
    return specialist;
  }
}
```

## 🎮 **Implementación de Comandos Inteligentes:**

### **Sintaxis de Comandos Propuesta:**

```bash
# AUTOMÁTICO - El sistema detecta el lenguaje automáticamente
/mario-code "create a REST API with authentication"
# → Detecta: probablemente Python/Node.js → Pregunta o usa contexto

/luigi-debug "fix this React component bug: useState not updating"  
# → Detecta: React/JavaScript → Routes to Luigi React Specialist

/peach-architect "design microservices for payment processing"
# → Detecta: backend architecture → Routes to Peach Backend Specialist

# EXPLÍCITO - Usuario especifica el lenguaje
/mario-code:python "create authentication API with FastAPI"
# → Explicit Python routing → Mario Python Specialist

/bowser-optimize:rust "optimize this sorting algorithm for performance"
# → Explicit Rust routing → Bowser Rust Specialist  

/luigi-test:javascript "add comprehensive unit tests for this module"
# → Explicit JavaScript routing → Luigi JavaScript Specialist

# DETECCIÓN POR ARCHIVO
/mario-code --file="src/main.go" "add error handling to this function"
# → Detecta: .go extension → Routes to Mario Go Specialist

/peach-refactor --file="components/UserForm.tsx" "improve this component"
# → Detecta: .tsx extension → Routes to Peach TypeScript/React Specialist
```

## 🏗️ **Estructura de Implementación:**

### **Opción 1: Modificar Comandos Existentes (Recomendado)**
```bash
# Actualizar install.sh para que cada comando sea inteligente
create_intelligent_command "mario-code" "🍄 Mario - Intelligent Code Generator" "mario-intelligent.md"
create_intelligent_command "luigi-debug" "👻 Luigi - Intelligent Debugger" "luigi-intelligent.md"  
create_intelligent_command "peach-architect" "👸 Peach - Intelligent Architect" "peach-intelligent.md"
```

### **Opción 2: Comandos Especializados Adicionales**
```bash
# Comandos especializados por categoría
create_command "mario-frontend" "🍄 Mario - Frontend Specialist" "mario-frontend.md"
create_command "mario-backend" "🍄 Mario - Backend Specialist" "mario-backend.md"
create_command "mario-mobile" "🍄 Mario - Mobile Specialist" "mario-mobile.md"
```

### **Opción 3: Sistema Híbrido (ÓPTIMO)**
```bash
# Comandos principales inteligentes + especialistas específicos
create_intelligent_command "mario-code" "🍄 Mario - Intelligent Multi-Language Coder"
create_intelligent_command "luigi-debug" "👻 Luigi - Intelligent Multi-Language Debugger"

# Especialistas específicos para casos complejos
create_specialist_command "mario-react" "🍄 Mario - React Specialist" 
create_specialist_command "bowser-rust" "🐢 Bowser - Rust Performance Specialist"
create_specialist_command "peach-python" "👸 Peach - Python Architecture Specialist"
```

## 🤔 **¿Cuál prefieres?**

**Mi recomendación es la Opción 3 (Sistema Híbrido):**

1. **Comandos principales inteligentes** (6 comandos base)
2. **Especialistas específicos** para los 20-30 lenguajes más populares
3. **Sistema de detección automática** como backbone
4. **Sintaxis flexible** (automática, explícita, por archivo)

**Total de comandos:** ~26-36 en lugar de 70+

¿Te parece bien esta arquitectura? ¿Quieres que proceda con la implementación del sistema híbrido? 🎮🚀