#!/usr/bin/env node
/**
 * Mario PowerUps - Comprehensive Intelligent Language System Test
 * 
 * Tests the complete intelligent multi-language support system including:
 * - Language detection accuracy across all supported languages
 * - Character specialist routing and integration
 * - Professional code generation with character personalities
 * - End-to-end workflow from input to specialized output
 * 
 * @author Mario PowerUps Professional System
 * @version 1.0.0
 */

const LanguageDetectionService = require('./language-detection-service.js');
const { MarioFrontendSpecialist, LuigiDebugSpecialist } = require('./character-specialists.js');

/**
 * Comprehensive test suite for the intelligent language system
 */
class IntelligentSystemTestSuite {
  constructor() {
    this.languageDetector = new LanguageDetectionService();
    this.testResults = {
      languageDetection: [],
      characterSpecialists: [],
      endToEndWorkflows: [],
      performanceMetrics: []
    };
  }

  /**
   * Runs the complete test suite
   */
  async runComprehensiveTests() {
    console.log('🧠⭐ Mario PowerUps - Intelligent Language System Testing ⭐🧠\n');
    
    try {
      // Test 1: Language Detection Accuracy
      await this.testLanguageDetectionAccuracy();
      
      // Test 2: Character Specialist Functionality
      await this.testCharacterSpecialists();
      
      // Test 3: End-to-End Workflows
      await this.testEndToEndWorkflows();
      
      // Test 4: Performance Benchmarks
      await this.testPerformanceBenchmarks();
      
      // Test 5: Edge Cases and Error Handling
      await this.testEdgeCases();
      
      // Generate comprehensive report
      this.generateTestReport();
      
    } catch (error) {
      console.error('❌ Test suite execution failed:', error);
    }
  }

  /**
   * Tests language detection accuracy across all supported languages
   */
  async testLanguageDetectionAccuracy() {
    console.log('🔍 Testing Language Detection Accuracy...\n');
    
    const testCases = [
      // Frontend technologies
      {
        input: "create a React component with TypeScript and styled-components",
        expected: { language: 'react', category: 'frontend' },
        description: "React + TypeScript frontend"
      },
      {
        input: "build a Vue.js dashboard with Vuex state management",
        expected: { language: 'vue', category: 'frontend' },
        description: "Vue.js application"
      },
      {
        input: "implement Angular service with RxJS observables",
        expected: { language: 'angular', category: 'frontend' },
        description: "Angular service"
      },
      
      // Backend technologies
      {
        input: "create a Python REST API using FastAPI with async/await",
        expected: { language: 'python', category: 'backend' },
        description: "Python FastAPI backend"
      },
      {
        input: "implement Node.js microservice with Express and MongoDB",
        expected: { language: 'javascript', category: 'backend' },
        description: "Node.js microservice"
      },
      {
        input: "build Go HTTP server with goroutines for concurrency",
        expected: { language: 'go', category: 'backend' },
        description: "Go HTTP server"
      },
      {
        input: "develop Rust web service with Actix-web framework",
        expected: { language: 'rust', category: 'backend' },
        description: "Rust web service"
      },
      
      // Mobile technologies
      {
        input: "create Flutter app with Dart for cross-platform mobile",
        expected: { language: 'dart', category: 'mobile' },
        description: "Flutter mobile app"
      },
      {
        input: "build iOS app with Swift and SwiftUI",
        expected: { language: 'swift', category: 'mobile' },
        description: "iOS Swift app"
      },
      {
        input: "develop Android app using Kotlin with Jetpack Compose",
        expected: { language: 'kotlin', category: 'mobile' },
        description: "Android Kotlin app"
      },
      
      // Data science
      {
        input: "analyze dataset using pandas and create visualizations with matplotlib",
        expected: { language: 'python', category: 'datascience' },
        description: "Python data analysis"
      },
      {
        input: "perform statistical analysis in R with ggplot2",
        expected: { language: 'r', category: 'datascience' },
        description: "R statistical analysis"
      },
      {
        input: "implement machine learning model with Julia and MLJ.jl",
        expected: { language: 'julia', category: 'datascience' },
        description: "Julia ML model"
      },
      
      // Systems programming
      {
        input: "optimize C++ algorithm for real-time performance",
        expected: { language: 'cpp', category: 'systems' },
        description: "C++ optimization"
      },
      {
        input: "write embedded C code for microcontroller",
        expected: { language: 'c', category: 'systems' },
        description: "Embedded C code"
      },
      {
        input: "implement memory-safe systems programming in Zig",
        expected: { language: 'zig', category: 'systems' },
        description: "Zig systems programming"
      },
      
      // DevOps and infrastructure
      {
        input: "create Terraform configuration for AWS infrastructure",
        expected: { language: 'terraform', category: 'devops' },
        description: "Terraform AWS config"
      },
      {
        input: "write Ansible playbook for server deployment",
        expected: { language: 'ansible', category: 'devops' },
        description: "Ansible deployment"
      },
      {
        input: "build Docker containers with multi-stage builds",
        expected: { language: 'dockerfile', category: 'devops' },
        description: "Docker containerization"
      },
      
      // Functional programming
      {
        input: "implement pure functional algorithm in Haskell",
        expected: { language: 'haskell', category: 'functional' },
        description: "Haskell functional programming"
      },
      {
        input: "create F# application with functional composition",
        expected: { language: 'fsharp', category: 'functional' },
        description: "F# functional app"
      },
      {
        input: "write Clojure code with immutable data structures",
        expected: { language: 'clojure', category: 'functional' },
        description: "Clojure functional code"
      },
      
      // Blockchain
      {
        input: "develop Ethereum smart contract in Solidity",
        expected: { language: 'solidity', category: 'blockchain' },
        description: "Ethereum smart contract"
      },
      {
        input: "create Web3 dApp with JavaScript and Ethers.js",
        expected: { language: 'javascript', category: 'frontend' },
        description: "Web3 dApp frontend"
      },
      
      // Gaming
      {
        input: "create Unity game script in C#",
        expected: { language: 'csharp', category: 'gaming' },
        description: "Unity C# game script"
      },
      {
        input: "write Godot game logic in GDScript",
        expected: { language: 'gdscript', category: 'gaming' },
        description: "Godot GDScript"
      }
    ];

    let correctDetections = 0;
    let totalTests = testCases.length;
    
    for (const testCase of testCases) {
      const result = await this.languageDetector.detectLanguage(testCase.input);
      
      const isCorrectLanguage = result.language === testCase.expected.language;
      const isCorrectCategory = result.category === testCase.expected.category;
      const isAccurate = isCorrectLanguage && isCorrectCategory;
      
      if (isAccurate) {
        correctDetections++;
        console.log(`✅ ${testCase.description}: ${result.language} (${(result.confidence * 100).toFixed(1)}%)`);
      } else {
        console.log(`❌ ${testCase.description}: Expected ${testCase.expected.language}/${testCase.expected.category}, got ${result.language}/${result.category} (${(result.confidence * 100).toFixed(1)}%)`);
      }
      
      this.testResults.languageDetection.push({
        testCase,
        result,
        isAccurate,
        confidence: result.confidence
      });
    }
    
    const accuracy = (correctDetections / totalTests) * 100;
    console.log(`\n📊 Language Detection Accuracy: ${accuracy.toFixed(1)}% (${correctDetections}/${totalTests})\n`);
  }

  /**
   * Tests character specialist functionality
   */
  async testCharacterSpecialists() {
    console.log('🎭 Testing Character Specialists...\n');
    
    const marioFrontend = new MarioFrontendSpecialist();
    const luigiDebug = new LuigiDebugSpecialist();
    
    const specialistTests = [
      {
        specialist: marioFrontend,
        character: 'Mario',
        category: 'Frontend',
        request: "create a responsive dashboard component with real-time data",
        detection: { language: 'react', confidence: 0.95, category: 'frontend' }
      },
      {
        specialist: luigiDebug,
        character: 'Luigi',
        category: 'Debug',
        request: "find and fix memory leaks in this Node.js application",
        detection: { language: 'javascript', confidence: 0.9, category: 'debug' }
      }
    ];
    
    for (const test of specialistTests) {
      try {
        const startTime = Date.now();
        const result = await test.specialist.executeSpecializedAssistance(
          test.request,
          test.detection
        );
        const executionTime = Date.now() - startTime;
        
        console.log(`✅ ${test.character} ${test.category} Specialist: Success`);
        console.log(`   Request: "${test.request}"`);
        console.log(`   Language: ${result.language} (${(result.confidence * 100).toFixed(1)}% confidence)`);
        console.log(`   Execution Time: ${executionTime}ms`);
        console.log(`   Response Quality: ${result.success ? 'Professional' : 'Error'}\n`);
        
        this.testResults.characterSpecialists.push({
          ...test,
          result,
          executionTime,
          success: true
        });
        
      } catch (error) {
        console.log(`❌ ${test.character} ${test.category} Specialist: Failed`);
        console.log(`   Error: ${error.message}\n`);
        
        this.testResults.characterSpecialists.push({
          ...test,
          error: error.message,
          success: false
        });
      }
    }
  }

  /**
   * Tests end-to-end workflows from user input to specialized output
   */
  async testEndToEndWorkflows() {
    console.log('🔄 Testing End-to-End Workflows...\n');
    
    const workflowTests = [
      {
        userInput: "I need to create a secure authentication system for my web application",
        expectedFlow: "Input → Language Detection → Backend Specialist → Professional Implementation"
      },
      {
        userInput: "Help me debug this React component that's not re-rendering properly",
        expectedFlow: "Input → Language Detection → Frontend Debug Specialist → Debugging Solution"
      },
      {
        userInput: "Optimize this Python data processing pipeline for better performance",
        expectedFlow: "Input → Language Detection → Performance Specialist → Optimization Strategy"
      }
    ];
    
    for (const workflow of workflowTests) {
      try {
        const startTime = Date.now();
        
        // Step 1: Language Detection
        const detection = await this.languageDetector.detectLanguage(workflow.userInput);
        
        // Step 2: Specialist Routing (simulated)
        const routingResult = await this.languageDetector.routeToSpecialist(
          'mario', // Default character for testing
          workflow.userInput,
          { code: '', filePaths: [] }
        );
        
        const endTime = Date.now();
        const totalTime = endTime - startTime;
        
        console.log(`✅ End-to-End Workflow Test:`);
        console.log(`   Input: "${workflow.userInput}"`);
        console.log(`   Detected: ${detection.language} (${(detection.confidence * 100).toFixed(1)}% confidence)`);
        console.log(`   Category: ${detection.category}`);
        console.log(`   Specialist: ${routingResult.specialistKey}`);
        console.log(`   Total Time: ${totalTime}ms\n`);
        
        this.testResults.endToEndWorkflows.push({
          workflow,
          detection,
          routingResult,
          totalTime,
          success: true
        });
        
      } catch (error) {
        console.log(`❌ End-to-End Workflow Failed: ${error.message}\n`);
        
        this.testResults.endToEndWorkflows.push({
          workflow,
          error: error.message,
          success: false
        });
      }
    }
  }

  /**
   * Tests performance benchmarks for the intelligent system
   */
  async testPerformanceBenchmarks() {
    console.log('⚡ Testing Performance Benchmarks...\n');
    
    const performanceTests = [
      {
        name: "Language Detection Speed",
        iterations: 100,
        test: async () => {
          return await this.languageDetector.detectLanguage(
            "create a React component with TypeScript and styled-components"
          );
        }
      },
      {
        name: "Character Specialist Response Time",
        iterations: 50,
        test: async () => {
          const mario = new MarioFrontendSpecialist();
          return await mario.executeSpecializedAssistance(
            "create a button component",
            { language: 'react', confidence: 0.95, category: 'frontend' }
          );
        }
      }
    ];
    
    for (const perfTest of performanceTests) {
      const times = [];
      
      for (let i = 0; i < perfTest.iterations; i++) {
        const startTime = performance.now();
        await perfTest.test();
        const endTime = performance.now();
        times.push(endTime - startTime);
      }
      
      const avgTime = times.reduce((a, b) => a + b, 0) / times.length;
      const minTime = Math.min(...times);
      const maxTime = Math.max(...times);
      
      console.log(`📊 ${perfTest.name}:`);
      console.log(`   Average: ${avgTime.toFixed(2)}ms`);
      console.log(`   Min: ${minTime.toFixed(2)}ms`);
      console.log(`   Max: ${maxTime.toFixed(2)}ms`);
      console.log(`   Iterations: ${perfTest.iterations}\n`);
      
      this.testResults.performanceMetrics.push({
        name: perfTest.name,
        avgTime,
        minTime,
        maxTime,
        iterations: perfTest.iterations
      });
    }
  }

  /**
   * Tests edge cases and error handling
   */
  async testEdgeCases() {
    console.log('🚨 Testing Edge Cases and Error Handling...\n');
    
    const edgeCases = [
      {
        name: "Empty Input",
        input: "",
        expectError: false
      },
      {
        name: "Very Long Input",
        input: "create a React component ".repeat(1000),
        expectError: false
      },
      {
        name: "Mixed Languages",
        input: "create a Python backend API that serves a React frontend with TypeScript",
        expectError: false
      },
      {
        name: "Ambiguous Request",
        input: "help me code something",
        expectError: false
      },
      {
        name: "Special Characters",
        input: "create a função with ñáméš and émojis 🚀",
        expectError: false
      }
    ];
    
    for (const edgeCase of edgeCases) {
      try {
        const result = await this.languageDetector.detectLanguage(edgeCase.input);
        
        if (edgeCase.expectError) {
          console.log(`❌ ${edgeCase.name}: Expected error but got result`);
        } else {
          console.log(`✅ ${edgeCase.name}: Handled gracefully`);
          console.log(`   Result: ${result.language} (${(result.confidence * 100).toFixed(1)}% confidence)`);
        }
      } catch (error) {
        if (edgeCase.expectError) {
          console.log(`✅ ${edgeCase.name}: Expected error caught`);
        } else {
          console.log(`❌ ${edgeCase.name}: Unexpected error - ${error.message}`);
        }
      }
    }
    console.log();
  }

  /**
   * Generates comprehensive test report
   */
  generateTestReport() {
    console.log('📋 Comprehensive Test Report\n');
    console.log('=' * 60);
    
    // Language Detection Summary
    const totalDetectionTests = this.testResults.languageDetection.length;
    const accurateDetections = this.testResults.languageDetection.filter(t => t.isAccurate).length;
    const detectionAccuracy = (accurateDetections / totalDetectionTests) * 100;
    
    console.log(`🔍 Language Detection:`);
    console.log(`   Tests: ${totalDetectionTests}`);
    console.log(`   Accuracy: ${detectionAccuracy.toFixed(1)}%`);
    console.log(`   Average Confidence: ${(this.testResults.languageDetection.reduce((sum, t) => sum + t.confidence, 0) / totalDetectionTests * 100).toFixed(1)}%\n`);
    
    // Character Specialists Summary
    const totalSpecialistTests = this.testResults.characterSpecialists.length;
    const successfulSpecialistTests = this.testResults.characterSpecialists.filter(t => t.success).length;
    
    console.log(`🎭 Character Specialists:`);
    console.log(`   Tests: ${totalSpecialistTests}`);
    console.log(`   Success Rate: ${(successfulSpecialistTests / totalSpecialistTests * 100).toFixed(1)}%\n`);
    
    // Performance Summary
    console.log(`⚡ Performance Metrics:`);
    this.testResults.performanceMetrics.forEach(metric => {
      console.log(`   ${metric.name}: ${metric.avgTime.toFixed(2)}ms avg`);
    });
    console.log();
    
    // Overall System Health
    const overallHealth = (detectionAccuracy + (successfulSpecialistTests / totalSpecialistTests * 100)) / 2;
    
    console.log(`🏆 Overall System Health: ${overallHealth.toFixed(1)}%`);
    
    if (overallHealth >= 90) {
      console.log(`🌟 EXCELLENT: The intelligent language system is performing at legendary levels!`);
    } else if (overallHealth >= 80) {
      console.log(`✅ GOOD: The system is working well with room for optimization.`);
    } else if (overallHealth >= 70) {
      console.log(`⚠️  FAIR: The system needs some improvements.`);
    } else {
      console.log(`❌ POOR: The system requires significant improvements.`);
    }
    
    console.log('\n🍄⭐ Mario PowerUps Intelligent Language System Testing Complete! ⭐🍄');
  }
}

// Run the comprehensive test suite
if (require.main === module) {
  const testSuite = new IntelligentSystemTestSuite();
  testSuite.runComprehensiveTests().catch(console.error);
}