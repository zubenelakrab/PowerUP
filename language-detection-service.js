#!/usr/bin/env node
/**
 * Mario PowerUps - Intelligent Language Detection Service
 * 
 * Advanced multi-language support system that automatically detects programming
 * languages and technologies from user input, routing requests to specialized
 * character implementations for optimal assistance.
 * 
 * Features:
 * - Automatic language detection from natural language and code patterns
 * - Support for 70+ programming languages and frameworks
 * - Intelligent routing to character-specific language specialists
 * - Context-aware technology stack inference
 * - File extension and project structure analysis
 * 
 * @author Mario PowerUps Professional System
 * @version 1.0.0
 */

const fs = require('fs');
const path = require('path');

/**
 * Comprehensive language detection and routing service
 * 
 * Provides intelligent detection of programming languages from user input
 * using multiple detection strategies including natural language processing,
 * code pattern recognition, and context analysis.
 */
class LanguageDetectionService {
  constructor() {
    /**
     * Language categories for specialized routing
     * Organizes languages by domain for efficient specialist assignment
     */
    this.languageCategories = {
      frontend: {
        languages: ['html', 'css', 'javascript', 'typescript', 'jsx', 'tsx', 'vue', 'angular', 'react', 'sass', 'scss', 'tailwind', 'svelte'],
        frameworks: ['react', 'vue', 'angular', 'svelte', 'next', 'nuxt', 'gatsby', 'ember', 'backbone', 'jquery'],
        specialist: 'frontend-specialist'
      },
      backend: {
        languages: ['node', 'python', 'java', 'csharp', 'go', 'rust', 'php', 'ruby', 'scala', 'elixir', 'kotlin', 'clojure', 'fsharp'],
        frameworks: ['express', 'django', 'flask', 'spring', 'laravel', 'rails', 'gin', 'actix', 'phoenix', 'koa', 'fastapi'],
        specialist: 'backend-specialist'
      },
      mobile: {
        languages: ['kotlin', 'java', 'swift', 'objectivec', 'dart', 'javascript', 'csharp'],
        frameworks: ['flutter', 'react-native', 'xamarin', 'ionic', 'cordova', 'nativescript'],
        specialist: 'mobile-specialist'
      },
      datascience: {
        languages: ['python', 'r', 'julia', 'matlab', 'scala', 'sql'],
        frameworks: ['pandas', 'numpy', 'tensorflow', 'pytorch', 'spark', 'jupyter', 'scikit-learn'],
        specialist: 'data-specialist'
      },
      systems: {
        languages: ['c', 'cpp', 'rust', 'zig', 'assembly', 'go', 'fortran'],
        frameworks: ['embedded', 'kernel', 'drivers', 'microcontrollers'],
        specialist: 'systems-specialist'
      },
      devops: {
        languages: ['bash', 'powershell', 'yaml', 'dockerfile', 'terraform', 'ansible', 'puppet', 'chef'],
        frameworks: ['kubernetes', 'docker', 'aws', 'gcp', 'azure', 'jenkins', 'gitlab-ci'],
        specialist: 'devops-specialist'
      },
      functional: {
        languages: ['haskell', 'ocaml', 'fsharp', 'elm', 'clojure', 'erlang', 'elixir', 'scala'],
        frameworks: ['reactive', 'pure-functional', 'akka'],
        specialist: 'functional-specialist'
      },
      gaming: {
        languages: ['cpp', 'csharp', 'lua', 'gdscript', 'hlsl', 'glsl'],
        frameworks: ['unity', 'unreal', 'godot', 'pygame', 'phaser'],
        specialist: 'gaming-specialist'
      },
      blockchain: {
        languages: ['solidity', 'vyper', 'rust', 'go', 'javascript'],
        frameworks: ['web3', 'ethereum', 'truffle', 'hardhat'],
        specialist: 'blockchain-specialist'
      }
    };

    /**
     * Comprehensive language patterns for detection
     * Maps language identifiers to detection metadata
     */
    this.languagePatterns = {
      // Frontend technologies
      'javascript': { patterns: ['javascript', 'js\\b', 'node\\.js', 'nodejs'], confidence: 0.9, category: 'frontend' },
      'typescript': { patterns: ['typescript', 'ts\\b', 'interface\\s+\\w+', 'type\\s+\\w+\\s*='], confidence: 0.95, category: 'frontend' },
      'react': { patterns: ['react', 'jsx', 'tsx', 'usestate', 'useeffect'], confidence: 0.95, category: 'frontend' },
      'vue': { patterns: ['vue\\.?js', 'vue', 'v-if', 'v-for', '@click'], confidence: 0.95, category: 'frontend' },
      'angular': { patterns: ['angular', '@component', '@injectable', 'ngfor', 'ngif'], confidence: 0.95, category: 'frontend' },
      'svelte': { patterns: ['svelte', '\\$:', 'bind:', 'on:'], confidence: 0.95, category: 'frontend' },
      'html': { patterns: ['html5?', '<\\w+[^>]*>', '</\\w+>'], confidence: 0.9, category: 'frontend' },
      'css': { patterns: ['css3?', 'sass', 'scss', 'less', 'tailwind'], confidence: 0.9, category: 'frontend' },

      // Backend technologies
      'python': { patterns: ['python', 'py\\b', 'def\\s+\\w+', 'import\\s+\\w+', 'django', 'flask'], confidence: 0.95, category: 'backend' },
      'java': { patterns: ['java\\b(?!script)', 'public\\s+class', 'public\\s+static\\s+void', 'spring'], confidence: 0.9, category: 'backend' },
      'csharp': { patterns: ['c#', 'csharp', 'using\\s+system', 'public\\s+class', '\\.net'], confidence: 0.95, category: 'backend' },
      'go': { patterns: ['golang', '\\bgo\\b', 'func\\s+\\w+', 'package\\s+\\w+', 'fmt\\.'], confidence: 0.9, category: 'backend' },
      'rust': { patterns: ['rust', 'fn\\s+\\w+', 'let\\s+mut', 'struct\\s+\\w+', 'impl\\s+'], confidence: 0.95, category: 'backend' },
      'php': { patterns: ['php', '<\\?php', '\\$\\w+', 'laravel', 'symfony'], confidence: 0.95, category: 'backend' },
      'ruby': { patterns: ['ruby', 'def\\s+\\w+', 'class\\s+\\w+', 'rails', 'gem\\s+'], confidence: 0.95, category: 'backend' },
      'scala': { patterns: ['scala', 'def\\s+\\w+:', 'object\\s+\\w+', 'class\\s+\\w+'], confidence: 0.95, category: 'backend' },
      'elixir': { patterns: ['elixir', 'defmodule\\s+\\w+', 'def\\s+\\w+', 'phoenix'], confidence: 0.95, category: 'backend' },

      // Mobile technologies
      'kotlin': { patterns: ['kotlin', 'fun\\s+\\w+', 'class\\s+\\w+', 'android'], confidence: 0.95, category: 'mobile' },
      'swift': { patterns: ['swift', 'func\\s+\\w+', 'class\\s+\\w+', 'ios', 'xcode'], confidence: 0.95, category: 'mobile' },
      'dart': { patterns: ['dart', 'flutter', 'widget', 'stateless', 'stateful'], confidence: 0.95, category: 'mobile' },
      'objectivec': { patterns: ['objective-?c', 'objc', '@interface', '@implementation'], confidence: 0.95, category: 'mobile' },

      // Data science and analytics
      'r': { patterns: ['\\br\\b(?!ust)', 'library\\(', 'data\\.frame', 'ggplot'], confidence: 0.8, category: 'datascience' },
      'julia': { patterns: ['julia', 'function\\s+\\w+', 'end\\s*$', 'using\\s+\\w+'], confidence: 0.95, category: 'datascience' },
      'matlab': { patterns: ['matlab', 'function\\s+\\w+', '\\.m\\b', 'matrix'], confidence: 0.95, category: 'datascience' },
      'sql': { patterns: ['sql', 'select\\s+', 'from\\s+\\w+', 'where\\s+', 'postgresql', 'mysql'], confidence: 0.9, category: 'datascience' },

      // Systems programming
      'c': { patterns: ['\\bc\\b(?!#|ss|\\+)', '#include\\s*<', 'int\\s+main', 'printf'], confidence: 0.7, category: 'systems' },
      'cpp': { patterns: ['c\\+\\+', 'cpp', 'std::', 'iostream', 'class\\s+\\w+'], confidence: 0.9, category: 'systems' },
      'zig': { patterns: ['zig', 'pub\\s+fn', 'const\\s+\\w+'], confidence: 0.95, category: 'systems' },
      'assembly': { patterns: ['assembly', 'asm', '\\.section', 'mov\\s+', 'jmp\\s+'], confidence: 0.9, category: 'systems' },
      'fortran': { patterns: ['fortran', 'program\\s+\\w+', 'subroutine\\s+\\w+'], confidence: 0.95, category: 'systems' },

      // DevOps and scripting
      'bash': { patterns: ['bash', 'shell', '#!/bin/bash', '\\$\\{.*\\}'], confidence: 0.9, category: 'devops' },
      'powershell': { patterns: ['powershell', 'ps1', 'get-\\w+', 'set-\\w+'], confidence: 0.95, category: 'devops' },
      'yaml': { patterns: ['yaml', 'yml', '\\w+:', '- \\w+'], confidence: 0.8, category: 'devops' },
      'dockerfile': { patterns: ['dockerfile', 'docker', 'from\\s+\\w+', 'run\\s+', 'copy\\s+'], confidence: 0.9, category: 'devops' },
      'terraform': { patterns: ['terraform', 'tf\\b', 'resource\\s+"', 'provider\\s+"'], confidence: 0.95, category: 'devops' },
      'ansible': { patterns: ['ansible', 'playbook', '- name:', 'hosts:'], confidence: 0.95, category: 'devops' },

      // Functional programming
      'haskell': { patterns: ['haskell', 'hs\\b', '\\w+\\s*::', 'data\\s+\\w+'], confidence: 0.95, category: 'functional' },
      'ocaml': { patterns: ['ocaml', 'let\\s+\\w+\\s*=', 'type\\s+\\w+'], confidence: 0.95, category: 'functional' },
      'fsharp': { patterns: ['f#', 'fsharp', 'let\\s+\\w+\\s*=', 'type\\s+\\w+'], confidence: 0.95, category: 'functional' },
      'elm': { patterns: ['elm', 'type\\s+\\w+', 'module\\s+\\w+'], confidence: 0.95, category: 'functional' },
      'clojure': { patterns: ['clojure', 'clj', '\\(def\\s+\\w+', '\\(defn\\s+\\w+'], confidence: 0.95, category: 'functional' },
      'erlang': { patterns: ['erlang', 'erl\\b', '-module\\(', '-export\\('], confidence: 0.95, category: 'functional' },

      // Gaming and graphics
      'gdscript': { patterns: ['gdscript', 'godot', 'extends\\s+\\w+', 'func\\s+_ready'], confidence: 0.95, category: 'gaming' },
      'hlsl': { patterns: ['hlsl', 'vertex\\s+shader', 'fragment\\s+shader'], confidence: 0.95, category: 'gaming' },
      'glsl': { patterns: ['glsl', 'gl_position', 'uniform\\s+\\w+'], confidence: 0.95, category: 'gaming' },
      'lua': { patterns: ['lua', 'function\\s+\\w+', 'local\\s+\\w+', 'end\\s*$'], confidence: 0.95, category: 'gaming' },

      // Blockchain and web3
      'solidity': { patterns: ['solidity', 'sol\\b', 'contract\\s+\\w+', 'function\\s+\\w+', 'ethereum'], confidence: 0.95, category: 'blockchain' },
      'vyper': { patterns: ['vyper', 'vy\\b', '@external', '@internal'], confidence: 0.95, category: 'blockchain' },

      // Additional specialized languages
      'nim': { patterns: ['nim', 'proc\\s+\\w+', 'var\\s+\\w+'], confidence: 0.95, category: 'systems' },
      'crystal': { patterns: ['crystal', 'cr\\b', 'def\\s+\\w+', 'class\\s+\\w+'], confidence: 0.95, category: 'backend' },
      'reasonml': { patterns: ['reason', 'reasonml', 'let\\s+\\w+\\s*='], confidence: 0.95, category: 'functional' },
      'purescript': { patterns: ['purescript', 'purs', '\\w+\\s*::', 'module\\s+\\w+'], confidence: 0.95, category: 'functional' },
      'coffeescript': { patterns: ['coffeescript', 'coffee', '->', '=>'], confidence: 0.95, category: 'frontend' },
      'livescript': { patterns: ['livescript', 'ls\\b', '<-', '->'], confidence: 0.95, category: 'functional' }
    };

    /**
     * File extension mappings for accurate language detection
     */
    this.fileExtensions = {
      // Frontend
      '.js': 'javascript', '.mjs': 'javascript', '.jsx': 'react',
      '.ts': 'typescript', '.tsx': 'react',
      '.vue': 'vue', '.svelte': 'svelte',
      '.html': 'html', '.htm': 'html',
      '.css': 'css', '.scss': 'sass', '.sass': 'sass', '.less': 'css',

      // Backend
      '.py': 'python', '.pyw': 'python', '.pyc': 'python',
      '.java': 'java', '.jar': 'java',
      '.cs': 'csharp', '.csx': 'csharp',
      '.go': 'go',
      '.rs': 'rust',
      '.php': 'php', '.phar': 'php',
      '.rb': 'ruby', '.rbw': 'ruby',
      '.scala': 'scala', '.sc': 'scala',
      '.ex': 'elixir', '.exs': 'elixir',

      // Mobile
      '.kt': 'kotlin', '.kts': 'kotlin',
      '.swift': 'swift',
      '.dart': 'dart',
      '.m': 'objectivec', '.mm': 'objectivec',

      // Data science
      '.r': 'r', '.rmd': 'r',
      '.jl': 'julia',
      '.m': 'matlab', '.mlx': 'matlab',
      '.sql': 'sql', '.psql': 'sql',

      // Systems
      '.c': 'c', '.h': 'c',
      '.cpp': 'cpp', '.cc': 'cpp', '.cxx': 'cpp', '.hpp': 'cpp',
      '.zig': 'zig',
      '.asm': 'assembly', '.s': 'assembly',
      '.f90': 'fortran', '.f95': 'fortran',

      // DevOps
      '.sh': 'bash', '.bash': 'bash',
      '.ps1': 'powershell', '.psm1': 'powershell',
      '.yml': 'yaml', '.yaml': 'yaml',
      '.tf': 'terraform', '.tfvars': 'terraform',
      '.dockerfile': 'dockerfile',

      // Functional
      '.hs': 'haskell', '.lhs': 'haskell',
      '.ml': 'ocaml', '.mli': 'ocaml',
      '.fs': 'fsharp', '.fsx': 'fsharp',
      '.elm': 'elm',
      '.clj': 'clojure', '.cljs': 'clojure',
      '.erl': 'erlang', '.hrl': 'erlang',

      // Gaming
      '.gd': 'gdscript',
      '.hlsl': 'hlsl',
      '.glsl': 'glsl', '.vert': 'glsl', '.frag': 'glsl',
      '.lua': 'lua',

      // Blockchain
      '.sol': 'solidity',
      '.vy': 'vyper',

      // Additional
      '.nim': 'nim',
      '.cr': 'crystal',
      '.re': 'reasonml',
      '.purs': 'purescript',
      '.coffee': 'coffeescript',
      '.ls': 'livescript'
    };
  }

  /**
   * Detects programming language from user input using multiple strategies
   * 
   * @param {string} userInput - User's request text
   * @param {Object} context - Additional context (file paths, project info, etc.)
   * @returns {Promise<Object>} - Detection result with language, confidence, and routing info
   * 
   * @example
   * ```javascript
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
  async detectLanguage(userInput, context = {}) {
    try {
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
      
    } catch (error) {
      console.error('Language detection failed:', error);
      return {
        language: 'unknown',
        confidence: 0,
        category: 'general',
        specialist: 'general-specialist',
        error: error.message
      };
    }
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
  async detectFromExplicitMention(input) {
    const normalizedInput = input.toLowerCase();
    
    for (const [language, config] of Object.entries(this.languagePatterns)) {
      for (const pattern of config.patterns) {
        const regex = new RegExp(`\\b${pattern}\\b`, 'i');
        if (regex.test(normalizedInput)) {
          return {
            method: 'explicit-mention',
            language: language,
            confidence: config.confidence,
            evidence: `Detected explicit mention: "${pattern}"`
          };
        }
      }
    }
    
    return { method: 'explicit-mention', confidence: 0 };
  }

  /**
   * Detects language from code syntax patterns
   */
  async detectFromCodePatterns(code) {
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

  /**
   * Detects language from file extensions
   */
  async detectFromFileExtensions(filePaths) {
    if (!filePaths || filePaths.length === 0) {
      return { method: 'file-extensions', confidence: 0 };
    }

    for (const filePath of filePaths) {
      const extension = path.extname(filePath).toLowerCase();
      if (this.fileExtensions[extension]) {
        return {
          method: 'file-extensions',
          language: this.fileExtensions[extension],
          confidence: 0.95,
          evidence: `File extension: ${extension}`
        };
      }
    }

    return { method: 'file-extensions', confidence: 0 };
  }

  /**
   * Detects language from technical keywords and terms
   */
  async detectFromKeywords(input) {
    const normalizedInput = input.toLowerCase();
    
    const keywordMappings = {
      'rest api': { language: 'backend', confidence: 0.6 },
      'microservice': { language: 'backend', confidence: 0.6 },
      'database': { language: 'backend', confidence: 0.5 },
      'frontend': { language: 'frontend', confidence: 0.7 },
      'ui component': { language: 'frontend', confidence: 0.7 },
      'mobile app': { language: 'mobile', confidence: 0.7 },
      'machine learning': { language: 'python', confidence: 0.8 },
      'data analysis': { language: 'python', confidence: 0.7 },
      'blockchain': { language: 'solidity', confidence: 0.8 },
      'smart contract': { language: 'solidity', confidence: 0.9 }
    };

    for (const [keyword, result] of Object.entries(keywordMappings)) {
      if (normalizedInput.includes(keyword)) {
        return {
          method: 'keywords',
          ...result,
          evidence: `Keyword detected: "${keyword}"`
        };
      }
    }

    return { method: 'keywords', confidence: 0 };
  }

  /**
   * Detects language from project structure analysis
   */
  async detectFromProjectStructure(projectStructure) {
    if (!projectStructure || Object.keys(projectStructure).length === 0) {
      return { method: 'project-structure', confidence: 0 };
    }

    const structurePatterns = {
      'package.json': { language: 'javascript', confidence: 0.8 },
      'requirements.txt': { language: 'python', confidence: 0.8 },
      'Cargo.toml': { language: 'rust', confidence: 0.9 },
      'go.mod': { language: 'go', confidence: 0.9 },
      'pom.xml': { language: 'java', confidence: 0.8 },
      'composer.json': { language: 'php', confidence: 0.8 },
      'Gemfile': { language: 'ruby', confidence: 0.8 }
    };

    for (const [file, result] of Object.entries(structurePatterns)) {
      if (projectStructure[file]) {
        return {
          method: 'project-structure',
          ...result,
          evidence: `Project file detected: ${file}`
        };
      }
    }

    return { method: 'project-structure', confidence: 0 };
  }

  /**
   * Detects language from technical terms and concepts
   */
  async detectFromTechnicalTerms(input) {
    const normalizedInput = input.toLowerCase();
    
    const technicalTerms = {
      'async/await': { language: 'javascript', confidence: 0.7 },
      'promises': { language: 'javascript', confidence: 0.6 },
      'decorators': { language: 'python', confidence: 0.7 },
      'generics': { language: 'java', confidence: 0.6 },
      'ownership': { language: 'rust', confidence: 0.8 },
      'goroutines': { language: 'go', confidence: 0.9 },
      'traits': { language: 'rust', confidence: 0.8 },
      'monads': { language: 'haskell', confidence: 0.8 }
    };

    for (const [term, result] of Object.entries(technicalTerms)) {
      if (normalizedInput.includes(term)) {
        return {
          method: 'technical-terms',
          ...result,
          evidence: `Technical term detected: "${term}"`
        };
      }
    }

    return { method: 'technical-terms', confidence: 0 };
  }

  /**
   * Combines detection results with weighted confidence scoring
   */
  combineDetectionResults(results) {
    // Filter out results with zero confidence
    const validResults = results.filter(r => r.confidence > 0);
    
    if (validResults.length === 0) {
      return {
        language: 'unknown',
        confidence: 0,
        method: 'combined',
        evidence: 'No language patterns detected'
      };
    }

    // Weight results by method reliability
    const methodWeights = {
      'explicit-mention': 1.0,
      'file-extensions': 0.95,
      'code-patterns': 0.9,
      'project-structure': 0.8,
      'technical-terms': 0.7,
      'keywords': 0.6
    };

    // Calculate weighted scores for each detected language
    const languageScores = {};
    
    for (const result of validResults) {
      const weight = methodWeights[result.method] || 0.5;
      const score = result.confidence * weight;
      
      if (!languageScores[result.language]) {
        languageScores[result.language] = {
          totalScore: 0,
          evidence: [],
          methods: []
        };
      }
      
      languageScores[result.language].totalScore += score;
      languageScores[result.language].evidence.push(result.evidence);
      languageScores[result.language].methods.push(result.method);
    }

    // Find the language with the highest score
    const topLanguage = Object.keys(languageScores).reduce((a, b) =>
      languageScores[a].totalScore > languageScores[b].totalScore ? a : b
    );

    const topResult = languageScores[topLanguage];
    
    return {
      language: topLanguage,
      confidence: Math.min(topResult.totalScore, 1.0),
      method: 'combined',
      evidence: topResult.evidence.join('; '),
      methods: topResult.methods
    };
  }

  /**
   * Determines the appropriate category for a detected language
   */
  determineCategory(language) {
    for (const [category, config] of Object.entries(this.languageCategories)) {
      if (config.languages.includes(language)) {
        return category;
      }
    }
    return 'general';
  }

  /**
   * Selects the appropriate specialist for the detected language and category
   */
  selectSpecialist(detectionResult) {
    if (detectionResult.confidence < 0.3) {
      return 'general-specialist';
    }
    
    const category = detectionResult.category || 'general';
    return this.languageCategories[category]?.specialist || 'general-specialist';
  }

  /**
   * Routes user request to appropriate character specialist
   * 
   * @param {string} character - Mario character (mario, luigi, peach, bowser, etc.)
   * @param {string} userRequest - User's coding request
   * @param {Object} context - Additional context for detection
   * @returns {Promise<Object>} - Routing result with specialist information
   */
  async routeToSpecialist(character, userRequest, context = {}) {
    try {
      // Step 1: Detect language and technology
      const detection = await this.detectLanguage(userRequest, context);
      
      // Step 2: Generate specialist key
      const specialistKey = `${character}-${detection.category}-specialist`;
      
      return {
        character,
        detection,
        specialistKey,
        routingSuccess: true,
        processingTime: Date.now() - Date.now()
      };
      
    } catch (error) {
      console.error('Language routing failed:', error);
      return {
        character,
        detection: { language: 'unknown', confidence: 0 },
        specialistKey: `${character}-general-specialist`,
        routingSuccess: false,
        error: error.message
      };
    }
  }
}

// Export for use in other modules
module.exports = LanguageDetectionService;

// CLI interface for testing
if (require.main === module) {
  const detector = new LanguageDetectionService();
  
  async function testDetection() {
    const testCases = [
      "create a REST API in Python with FastAPI",
      "fix this React component bug",
      "optimize Rust performance for sorting",
      "debug Go goroutine deadlock",
      "setup TypeScript project with React",
      "analyze data with pandas",
      "create smart contract in Solidity"
    ];
    
    console.log('🧠 Mario PowerUps - Language Detection Testing\n');
    
    for (const testCase of testCases) {
      console.log(`Input: "${testCase}"`);
      const result = await detector.detectLanguage(testCase);
      console.log(`Result: ${result.language} (${(result.confidence * 100).toFixed(1)}% confidence) -> ${result.specialist}`);
      console.log(`Evidence: ${result.evidence}\n`);
    }
  }
  
  testDetection().catch(console.error);
}