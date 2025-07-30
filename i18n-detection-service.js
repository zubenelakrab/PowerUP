#!/usr/bin/env node
/**
 * Mario PowerUps - Internationalization Detection and Analysis Service
 * 
 * Professional i18n analysis system that:
 * - Detects existing i18n implementations across all major frameworks
 * - Analyzes translation coverage and quality
 * - Identifies missing translations and issues
 * - Generates implementation recommendations
 * - Provides enhancement suggestions
 * 
 * @author Mario PowerUps Professional System - Toadette i18n Specialist
 * @version 1.0.0
 */

const fs = require('fs');
const path = require('path');

/**
 * Comprehensive internationalization detection and analysis service
 */
class I18nDetectionService {
  constructor() {
    /**
     * Supported frameworks and their i18n libraries
     */
    this.frameworkLibraries = {
      react: {
        libraries: ['react-i18next', 'react-intl', 'lingui', 'polyglot'],
        configFiles: ['i18n.js', 'i18n.ts', 'i18next.config.js', 'lingui.config.js'],
        patterns: ['useTranslation', 'FormattedMessage', 'Trans', 't(', 'i18n.t(']
      },
      vue: {
        libraries: ['vue-i18n', 'vue-intl', 'nuxt-i18n'],
        configFiles: ['i18n.js', 'i18n.ts', 'nuxt.config.js'],
        patterns: ['$t(', 'v-t=', '<i18n>', 'useI18n', '$i18n']
      },
      angular: {
        libraries: ['@angular/localize', 'transloco', 'ngx-translate'],
        configFiles: ['angular.json', 'transloco.config.ts', 'app.module.ts'],
        patterns: ['i18n-', '$localize', 'translate.get', 'TranslocoModule']
      },
      nextjs: {
        libraries: ['next-i18next', 'next-intl', 'react-i18next'],
        configFiles: ['next-i18next.config.js', 'next.config.js', 'middleware.ts'],
        patterns: ['serverSideTranslations', 'useTranslation', 'getStaticProps']
      },
      nuxt: {
        libraries: ['nuxt-i18n', '@nuxtjs/i18n'],
        configFiles: ['nuxt.config.js', 'nuxt.config.ts'],
        patterns: ['$t(', '$i18n', 'localePath', 'switchLocalePath']
      },
      svelte: {
        libraries: ['svelte-i18n', 'sveltekit-i18n'],
        configFiles: ['i18n.js', 'app.html'],
        patterns: ['$_', '$t', 'locale', 'dictionary']
      },
      node: {
        libraries: ['i18next', 'node-polyglot', 'i18n'],
        configFiles: ['i18n.js', 'config/i18n.js'],
        patterns: ['i18n.t(', 'polyglot.t(', 'req.__(', 'res.__(']
      },
      django: {
        libraries: ['django.utils.translation', 'django-modeltranslation'],
        configFiles: ['settings.py', 'locale/', 'urls.py'],
        patterns: ['gettext', 'ugettext', '_("', "_(\'", 'trans ']
      },
      rails: {
        libraries: ['i18n', 'rails-i18n'],
        configFiles: ['config/locales/', 'config/application.rb'],
        patterns: ['I18n.t(', 't(', 'translate(', 'localize(']
      }
    };

    /**
     * Common translation file patterns
     */
    this.translationPatterns = [
      '**/locales/**/*.json',
      '**/translations/**/*.json',
      '**/i18n/**/*.json',
      '**/lang/**/*.json',
      '**/assets/i18n/**/*.json',
      '**/public/locales/**/*.json',
      '**/src/locales/**/*.json',
      '**/locale/**/*.po',
      '**/locale/**/*.mo',
      '**/*.properties',
      '**/strings.xml',
      '**/Localizable.strings'
    ];
  }

  /**
   * Comprehensive i18n analysis of a project
   * 
   * @param {string} projectPath - Path to the project
   * @param {Object} options - Analysis options
   * @returns {Promise<Object>} Complete i18n analysis
   */
  async analyzeProject(projectPath, options = {}) {
    const startTime = Date.now();
    
    try {
      const analysis = {
        projectPath,
        timestamp: new Date().toISOString(),
        framework: 'unknown',
        hasI18n: false,
        library: null,
        supportedLanguages: [],
        translationFiles: [],
        coverage: 0,
        issues: [],
        recommendations: [],
        implementationQuality: 'none',
        analysisTime: 0
      };

      // Step 1: Detect project framework
      analysis.framework = await this.detectFramework(projectPath);
      console.log(`🔍 Detected framework: ${analysis.framework}`);

      // Step 2: Check for existing i18n implementation
      const i18nDetection = await this.detectI18nImplementation(projectPath, analysis.framework);
      analysis.hasI18n = i18nDetection.hasI18n;
      analysis.library = i18nDetection.library;

      if (analysis.hasI18n) {
        console.log(`✅ Found i18n implementation: ${analysis.library}`);
        
        // Step 3: Find translation files
        analysis.translationFiles = await this.findTranslationFiles(projectPath);
        
        // Step 4: Extract supported languages
        analysis.supportedLanguages = await this.extractSupportedLanguages(analysis.translationFiles);
        
        // Step 5: Analyze translation coverage
        analysis.coverage = await this.calculateCoverage(projectPath, analysis.translationFiles);
        
        // Step 6: Find issues
        analysis.issues = await this.findI18nIssues(projectPath, analysis);
        
        // Step 7: Assess implementation quality
        analysis.implementationQuality = this.assessImplementationQuality(analysis);
        
        // Step 8: Generate enhancement recommendations
        analysis.recommendations = await this.generateEnhancements(analysis);
      } else {
        console.log(`❌ No i18n implementation found`);
        
        // Generate implementation recommendations
        analysis.recommendations = await this.generateImplementationPlan(projectPath, analysis.framework);
      }

      analysis.analysisTime = Date.now() - startTime;
      
      return analysis;
      
    } catch (error) {
      console.error('i18n analysis failed:', error);
      throw error;
    }
  }

  /**
   * Detects the project framework
   */
  async detectFramework(projectPath) {
    try {
      const packageJsonPath = path.join(projectPath, 'package.json');
      
      if (fs.existsSync(packageJsonPath)) {
        const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
        const dependencies = { ...packageJson.dependencies, ...packageJson.devDependencies };
        
        // Check for framework-specific dependencies
        if (dependencies['react']) {
          if (dependencies['next']) return 'nextjs';
          return 'react';
        }
        if (dependencies['vue']) {
          if (dependencies['nuxt']) return 'nuxt';
          return 'vue';
        }
        if (dependencies['@angular/core']) return 'angular';
        if (dependencies['svelte']) return 'svelte';
        if (dependencies['express'] || dependencies['koa']) return 'node';
      }
      
      // Check for framework-specific files
      const files = fs.readdirSync(projectPath);
      
      if (files.includes('angular.json')) return 'angular';
      if (files.includes('next.config.js')) return 'nextjs';
      if (files.includes('nuxt.config.js')) return 'nuxt';
      if (files.includes('svelte.config.js')) return 'svelte';
      if (files.includes('manage.py')) return 'django';
      if (files.includes('Gemfile') && files.includes('config')) return 'rails';
      
      return 'unknown';
      
    } catch (error) {
      console.error('Framework detection failed:', error);
      return 'unknown';
    }
  }

  /**
   * Detects existing i18n implementation
   */
  async detectI18nImplementation(projectPath, framework) {
    const result = { hasI18n: false, library: null, confidence: 0 };
    
    if (!this.frameworkLibraries[framework]) {
      return result;
    }
    
    const config = this.frameworkLibraries[framework];
    
    try {
      // Check package.json for i18n libraries
      const packageJsonPath = path.join(projectPath, 'package.json');
      if (fs.existsSync(packageJsonPath)) {
        const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
        const dependencies = { ...packageJson.dependencies, ...packageJson.devDependencies };
        
        for (const library of config.libraries) {
          if (dependencies[library]) {
            result.hasI18n = true;
            result.library = library;
            result.confidence = 0.9;
            return result;
          }
        }
      }
      
      // Check for configuration files
      for (const configFile of config.configFiles) {
        const configPath = path.join(projectPath, configFile);
        if (fs.existsSync(configPath)) {
          result.hasI18n = true;
          result.confidence = Math.max(result.confidence, 0.7);
        }
      }
      
      // Check for usage patterns in source code
      const sourceFiles = await this.findSourceFiles(projectPath);
      let patternMatches = 0;
      
      for (const filePath of sourceFiles.slice(0, 50)) { // Limit search for performance
        try {
          const content = fs.readFileSync(filePath, 'utf8');
          for (const pattern of config.patterns) {
            if (content.includes(pattern)) {
              patternMatches++;
            }
          }
        } catch (error) {
          // Skip unreadable files
        }
      }
      
      if (patternMatches > 0) {
        result.hasI18n = true;
        result.confidence = Math.max(result.confidence, patternMatches / 10);
      }
      
      return result;
      
    } catch (error) {
      console.error('i18n detection failed:', error);
      return result;
    }
  }

  /**
   * Finds translation files in the project
   */
  async findTranslationFiles(projectPath) {
    const translationFiles = [];
    
    for (const pattern of this.translationPatterns) {
      try {
        const files = await this.globFiles(projectPath, pattern);
        translationFiles.push(...files);
      } catch (error) {
        // Skip patterns that don't match
      }
    }
    
    return [...new Set(translationFiles)]; // Remove duplicates
  }

  /**
   * Simple glob implementation for finding files
   */
  async globFiles(basePath, pattern) {
    const results = [];
    
    const searchRecursive = (dir, remainingPattern) => {
      try {
        const items = fs.readdirSync(dir);
        
        for (const item of items) {
          const fullPath = path.join(dir, item);
          const stat = fs.statSync(fullPath);
          
          if (stat.isDirectory() && !item.startsWith('.') && !item.includes('node_modules')) {
            searchRecursive(fullPath, remainingPattern);
          } else if (stat.isFile()) {
            // Simple pattern matching - check if file matches the pattern
            if (this.matchesPattern(fullPath, pattern)) {
              results.push(fullPath);
            }
          }
        }
      } catch (error) {
        // Skip directories we can't read
      }
    };
    
    searchRecursive(basePath, pattern);
    return results;
  }

  /**
   * Simple pattern matching
   */
  matchesPattern(filePath, pattern) {
    // Convert glob pattern to regex (simplified)
    const regexPattern = pattern
      .replace(/\*\*/g, '.*')
      .replace(/\*/g, '[^/]*')
      .replace(/\?/g, '.');
    
    const regex = new RegExp(regexPattern);
    return regex.test(filePath);
  }

  /**
   * Extracts supported languages from translation files
   */
  async extractSupportedLanguages(translationFiles) {
    const languages = new Set();
    
    for (const filePath of translationFiles) {
      // Extract language from file path
      const pathParts = filePath.split('/');
      
      // Common patterns: /locales/en.json, /i18n/en/translation.json, /lang/en_US.json
      for (const part of pathParts) {
        if (this.isLanguageCode(part)) {
          languages.add(part);
        }
        
        // Check for language codes in filenames
        const basename = path.basename(part, path.extname(part));
        if (this.isLanguageCode(basename)) {
          languages.add(basename);
        }
      }
    }
    
    return Array.from(languages);
  }

  /**
   * Checks if a string is a valid language code
   */
  isLanguageCode(str) {
    // Common language code patterns
    const patterns = [
      /^[a-z]{2}$/, // en, es, fr
      /^[a-z]{2}-[A-Z]{2}$/, // en-US, es-ES
      /^[a-z]{2}_[A-Z]{2}$/, // en_US, es_ES
      /^[a-z]{3}$/ // eng, spa (ISO 639-3)
    ];
    
    return patterns.some(pattern => pattern.test(str));
  }

  /**
   * Calculates translation coverage
   */
  async calculateCoverage(projectPath, translationFiles) {
    if (translationFiles.length === 0) return 0;
    
    try {
      // Find the reference language file (usually the largest)
      let referenceFile = null;
      let maxKeys = 0;
      
      for (const filePath of translationFiles) {
        try {
          const content = fs.readFileSync(filePath, 'utf8');
          
          if (filePath.endsWith('.json')) {
            const data = JSON.parse(content);
            const keyCount = this.countTranslationKeys(data);
            
            if (keyCount > maxKeys) {
              maxKeys = keyCount;
              referenceFile = filePath;
            }
          }
        } catch (error) {
          // Skip invalid files
        }
      }
      
      if (!referenceFile || maxKeys === 0) return 0;
      
      // Calculate coverage for each file
      let totalCoverage = 0;
      let validFiles = 0;
      
      for (const filePath of translationFiles) {
        try {
          const content = fs.readFileSync(filePath, 'utf8');
          
          if (filePath.endsWith('.json')) {
            const data = JSON.parse(content);
            const keyCount = this.countTranslationKeys(data);
            const coverage = (keyCount / maxKeys) * 100;
            
            totalCoverage += coverage;
            validFiles++;
          }
        } catch (error) {
          // Skip invalid files
        }
      }
      
      return validFiles > 0 ? Math.round(totalCoverage / validFiles) : 0;
      
    } catch (error) {
      console.error('Coverage calculation failed:', error);
      return 0;
    }
  }

  /**
   * Counts translation keys recursively
   */
  countTranslationKeys(obj) {
    let count = 0;
    
    for (const key in obj) {
      if (typeof obj[key] === 'object' && obj[key] !== null) {
        count += this.countTranslationKeys(obj[key]);
      } else {
        count++;
      }
    }
    
    return count;
  }

  /**
   * Finds source files for analysis
   */
  async findSourceFiles(projectPath) {
    const extensions = ['.js', '.jsx', '.ts', '.tsx', '.vue', '.svelte', '.py', '.rb'];
    const files = [];
    
    const searchRecursive = (dir) => {
      try {
        const items = fs.readdirSync(dir);
        
        for (const item of items) {
          if (item.startsWith('.') || item === 'node_modules') continue;
          
          const fullPath = path.join(dir, item);
          const stat = fs.statSync(fullPath);
          
          if (stat.isDirectory()) {
            searchRecursive(fullPath);
          } else if (stat.isFile() && extensions.includes(path.extname(item))) {
            files.push(fullPath);
          }
        }
      } catch (error) {
        // Skip unreadable directories
      }
    };
    
    searchRecursive(projectPath);
    return files;
  }

  /**
   * Finds i18n issues in the implementation
   */
  async findI18nIssues(projectPath, analysis) {
    const issues = [];
    
    // Check for common issues
    if (analysis.supportedLanguages.length < 2) {
      issues.push({
        type: 'warning',
        category: 'languages',
        message: 'Only one language detected. Consider adding more languages for true internationalization.',
        severity: 'medium'
      });
    }
    
    if (analysis.coverage < 80) {
      issues.push({
        type: 'error',
        category: 'coverage',
        message: `Translation coverage is ${analysis.coverage}%. Aim for at least 80% coverage.`,
        severity: 'high'
      });
    }
    
    // Check for hardcoded strings (simplified check)
    const sourceFiles = await this.findSourceFiles(projectPath);
    let hardcodedStrings = 0;
    
    for (const filePath of sourceFiles.slice(0, 20)) { // Limit for performance
      try {
        const content = fs.readFileSync(filePath, 'utf8');
        
        // Look for hardcoded strings (simplified pattern)
        const stringMatches = content.match(/["'][\w\s]{10,}["']/g);
        if (stringMatches) {
          hardcodedStrings += stringMatches.length;
        }
      } catch (error) {
        // Skip unreadable files
      }
    }
    
    if (hardcodedStrings > 5) {
      issues.push({
        type: 'warning',
        category: 'hardcoded-strings',
        message: `Found ${hardcodedStrings} potential hardcoded strings. Consider extracting them to translation files.`,
        severity: 'medium'
      });
    }
    
    return issues;
  }

  /**
   * Assesses implementation quality
   */
  assessImplementationQuality(analysis) {
    let score = 0;
    
    // Has i18n implementation
    if (analysis.hasI18n) score += 20;
    
    // Multiple languages
    if (analysis.supportedLanguages.length >= 2) score += 20;
    if (analysis.supportedLanguages.length >= 5) score += 10;
    
    // Good coverage
    if (analysis.coverage >= 80) score += 20;
    if (analysis.coverage >= 95) score += 10;
    
    // Low issues
    const criticalIssues = analysis.issues.filter(i => i.severity === 'high').length;
    if (criticalIssues === 0) score += 20;
    
    // Quality assessment
    if (score >= 80) return 'excellent';
    if (score >= 60) return 'good';
    if (score >= 40) return 'fair';
    if (score >= 20) return 'poor';
    return 'none';
  }

  /**
   * Generates enhancement recommendations
   */
  async generateEnhancements(analysis) {
    const recommendations = [];
    
    if (analysis.coverage < 90) {
      recommendations.push({
        type: 'improvement',
        priority: 'high',
        title: 'Improve Translation Coverage',
        description: `Current coverage is ${analysis.coverage}%. Add missing translations to reach 90%+.`,
        effort: 'medium'
      });
    }
    
    if (analysis.supportedLanguages.length < 3) {
      recommendations.push({
        type: 'feature',
        priority: 'medium',
        title: 'Add More Languages',
        description: 'Consider adding more language support to expand your global reach.',
        effort: 'high'
      });
    }
    
    const criticalIssues = analysis.issues.filter(i => i.severity === 'high');
    if (criticalIssues.length > 0) {
      recommendations.push({
        type: 'fix',
        priority: 'high',
        title: 'Fix Critical Issues',
        description: `Address ${criticalIssues.length} critical i18n issues found.`,
        effort: 'medium'
      });
    }
    
    // Framework-specific recommendations
    if (analysis.framework === 'react' && !analysis.library?.includes('typescript')) {
      recommendations.push({
        type: 'enhancement',
        priority: 'medium',
        title: 'Add TypeScript Support',
        description: 'Add type-safe translations with TypeScript integration.',
        effort: 'medium'
      });
    }
    
    return recommendations;
  }

  /**
   * Generates implementation plan for projects without i18n
   */
  async generateImplementationPlan(projectPath, framework) {
    const plan = [];
    
    plan.push({
      type: 'setup',
      priority: 'high',
      title: 'Install i18n Library',
      description: `Install and configure the recommended i18n library for ${framework}.`,
      effort: 'low'
    });
    
    plan.push({
      type: 'setup',
      priority: 'high',
      title: 'Create Translation Structure',
      description: 'Set up organized translation file structure with proper naming conventions.',
      effort: 'low'
    });
    
    plan.push({
      type: 'implementation',
      priority: 'high',
      title: 'Extract Translatable Strings',
      description: 'Identify and extract hardcoded strings into translation files.',
      effort: 'high'
    });
    
    plan.push({
      type: 'implementation',
      priority: 'medium',
      title: 'Integrate Components',
      description: 'Update components to use translation functions instead of hardcoded strings.',
      effort: 'high'
    });
    
    plan.push({
      type: 'feature',
      priority: 'medium',
      title: 'Add Language Switcher',
      description: 'Implement language selection UI for users.',
      effort: 'medium'
    });
    
    return plan;
  }
}

// CLI interface for testing
if (require.main === module) {
  const service = new I18nDetectionService();
  
  async function runAnalysis() {
    const projectPath = process.argv[2] || './';
    
    console.log('🌍 Toadette\'s i18n Analysis Starting...\n');
    
    try {
      const result = await service.analyzeProject(projectPath, { deep: true });
      
      console.log('\n📊 Analysis Results:');
      console.log('==================');
      console.log(`Project: ${result.projectPath}`);
      console.log(`Framework: ${result.framework}`);
      console.log(`Has i18n: ${result.hasI18n ? '✅ Yes' : '❌ No'}`);
      
      if (result.hasI18n) {
        console.log(`Library: ${result.library}`);
        console.log(`Languages: ${result.supportedLanguages.join(', ') || 'None detected'}`);
        console.log(`Coverage: ${result.coverage}%`);
        console.log(`Quality: ${result.implementationQuality}`);
        console.log(`Issues: ${result.issues.length}`);
        
        if (result.issues.length > 0) {
          console.log('\n⚠️  Issues Found:');
          result.issues.forEach((issue, i) => {
            console.log(`${i + 1}. [${issue.severity.toUpperCase()}] ${issue.message}`);
          });
        }
      }
      
      console.log('\n💡 Recommendations:');
      result.recommendations.forEach((rec, i) => {
        console.log(`${i + 1}. [${rec.priority.toUpperCase()}] ${rec.title}`);
        console.log(`   ${rec.description}`);
      });
      
      console.log(`\n⏱️  Analysis completed in ${result.analysisTime}ms`);
      
    } catch (error) {
      console.error('❌ Analysis failed:', error.message);
    }
  }
  
  runAnalysis();
}

module.exports = I18nDetectionService;