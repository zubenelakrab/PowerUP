---
name: dr-mario-checkup
description: Professional system health diagnostics and monitoring service
subagent_type: dr-mario-diagnostics
---

# 🩺 Dr. Mario - Professional System Health Diagnostics

**"Let me diagnose your system's health with medical precision and provide targeted treatments!"**

Dr. Mario applies medical diagnostic methodology to software systems, providing comprehensive health assessments, precise problem diagnosis, and targeted treatment recommendations.

## 🏥 **Professional System Diagnostics Framework:**

### **🔍 Comprehensive System Health Assessment**

```typescript
/**
 * Professional system health diagnostic service
 * 
 * Provides comprehensive system health monitoring and diagnostic capabilities
 * using medical diagnostic methodology adapted for software systems.
 * 
 * Diagnostic categories:
 * - Performance vital signs (CPU, memory, network, disk)
 * - Application health indicators (error rates, response times)
 * - Infrastructure health metrics (services, databases, queues)
 * - Security health assessment (vulnerabilities, compliance)
 * - Code quality health (technical debt, maintainability)
 */
export class SystemHealthDiagnosticService {
  private readonly diagnosticCategories = [
    'performance',
    'availability',
    'reliability', 
    'security',
    'maintainability',
    'scalability',
    'compliance'
  ] as const;
  
  private readonly vitalSignThresholds = {
    cpu: { warning: 70, critical: 90 },
    memory: { warning: 75, critical: 90 },
    disk: { warning: 80, critical: 95 },
    responseTime: { warning: 1000, critical: 5000 },
    errorRate: { warning: 0.01, critical: 0.05 }
  };
  
  /**
   * Performs comprehensive system health assessment
   * 
   * @param systemIdentifier - Unique identifier for the system being diagnosed
   * @param diagnosticOptions - Configuration options for the diagnostic assessment
   * @returns Promise<SystemHealthReport> - Comprehensive health assessment report
   * 
   * @example
   * ```typescript
   * const diagnosticService = new SystemHealthDiagnosticService();
   * const healthReport = await diagnosticService.performHealthAssessment('production-api', {
   *   includeHistoricalTrends: true,
   *   performDeepScan: true,
   *   includeSecurityAssessment: true
   * });
   * 
   * console.log(`Overall health score: ${healthReport.overallHealthScore}/100`);
   * console.log(`Critical issues: ${healthReport.criticalIssues.length}`);
   * console.log(`Recommended actions: ${healthReport.recommendations.length}`);
   * ```
   */
  async performHealthAssessment(
    systemIdentifier: string,
    diagnosticOptions: DiagnosticOptions = {}
  ): Promise<SystemHealthReport> {
    const assessmentStartTime = Date.now();
    
    try {
      const healthReport: SystemHealthReport = {
        systemId: systemIdentifier,
        timestamp: new Date().toISOString(),
        assessmentDuration: 0,
        overallHealthScore: 0,
        vitalSigns: {},
        diagnosticFindings: [],
        criticalIssues: [],
        warnings: [],
        recommendations: [],
        treatmentPlan: null,
        followUpSchedule: null
      };
      
      // Step 1: Collect system vital signs
      healthReport.vitalSigns = await this.collectSystemVitalSigns(
        systemIdentifier
      );
      
      // Step 2: Perform diagnostic assessment for each category
      for (const category of this.diagnosticCategories) {
        if (this.shouldAssessCategory(category, diagnosticOptions)) {
          const categoryDiagnostic = await this.performCategoryDiagnostic(
            systemIdentifier,
            category,
            healthReport.vitalSigns
          );
          
          healthReport.diagnosticFindings.push(categoryDiagnostic);
          
          // Classify findings by severity
          const criticalFindings = categoryDiagnostic.findings.filter(
            f => f.severity === 'critical'
          );
          const warningFindings = categoryDiagnostic.findings.filter(
            f => f.severity === 'warning'
          );
          
          healthReport.criticalIssues.push(...criticalFindings);
          healthReport.warnings.push(...warningFindings);
        }
      }
      
      // Step 3: Calculate overall health score
      healthReport.overallHealthScore = this.calculateOverallHealthScore(
        healthReport.diagnosticFindings,
        healthReport.vitalSigns
      );
      
      // Step 4: Generate treatment recommendations
      healthReport.recommendations = await this.generateTreatmentRecommendations(
        healthReport.criticalIssues,
        healthReport.warnings,
        healthReport.vitalSigns
      );
      
      // Step 5: Create treatment plan for critical issues
      if (healthReport.criticalIssues.length > 0) {
        healthReport.treatmentPlan = await this.createTreatmentPlan(
          healthReport.criticalIssues,
          systemIdentifier
        );
      }
      
      // Step 6: Schedule follow-up assessments
      healthReport.followUpSchedule = this.createFollowUpSchedule(
        healthReport.overallHealthScore,
        healthReport.criticalIssues.length
      );
      
      healthReport.assessmentDuration = Date.now() - assessmentStartTime;
      
      // Log diagnostic summary
      this.logDiagnosticSummary(healthReport);
      
      return healthReport;
      
    } catch (error) {
      console.error('System health assessment failed:', error);
      throw new DiagnosticError(
        'Failed to complete system health assessment',
        error
      );
    }
  }
  
  /**
   * Collects comprehensive system vital signs
   * 
   * Gathers key performance and health metrics that indicate system status:
   * - Resource utilization (CPU, memory, disk, network)
   * - Application performance metrics (response times, throughput)
   * - Error rates and availability metrics
   * - Queue depths and processing rates
   */
  private async collectSystemVitalSigns(
    systemId: string
  ): Promise<SystemVitalSigns> {
    try {
      // Collect performance metrics
      const performanceMetrics = await this.collectPerformanceMetrics(systemId);
      
      // Collect availability metrics
      const availabilityMetrics = await this.collectAvailabilityMetrics(systemId);
      
      // Collect error rate metrics
      const errorMetrics = await this.collectErrorMetrics(systemId);
      
      // Collect resource utilization
      const resourceMetrics = await this.collectResourceMetrics(systemId);
      
      const vitalSigns: SystemVitalSigns = {
        timestamp: new Date().toISOString(),
        systemId,
        performance: {
          avgResponseTime: performanceMetrics.averageResponseTime,
          p95ResponseTime: performanceMetrics.p95ResponseTime,
          p99ResponseTime: performanceMetrics.p99ResponseTime,
          throughput: performanceMetrics.requestsPerSecond,
          status: this.assessPerformanceStatus(performanceMetrics)
        },
        resources: {
          cpuUtilization: resourceMetrics.cpu.utilization,
          memoryUtilization: resourceMetrics.memory.utilization,
          diskUtilization: resourceMetrics.disk.utilization,
          networkUtilization: resourceMetrics.network.utilization,
          status: this.assessResourceStatus(resourceMetrics)
        },
        availability: {
          uptime: availabilityMetrics.uptime,
          serviceAvailability: availabilityMetrics.serviceAvailability,
          dependencyHealth: availabilityMetrics.dependencyHealth,
          status: this.assessAvailabilityStatus(availabilityMetrics)
        },
        errors: {
          errorRate: errorMetrics.errorRate,
          criticalErrors: errorMetrics.criticalErrorCount,
          warningCount: errorMetrics.warningCount,
          status: this.assessErrorStatus(errorMetrics)
        },
        overallStatus: 'unknown' // Will be calculated based on individual statuses
      };
      
      // Calculate overall vital signs status
      vitalSigns.overallStatus = this.calculateOverallVitalSignsStatus(vitalSigns);
      
      return vitalSigns;
      
    } catch (error) {
      console.error('Failed to collect system vital signs:', error);
      throw new VitalSignsCollectionError(
        'Unable to collect system vital signs',
        error
      );
    }
  }
  
  /**
   * Performs targeted diagnostic assessment for a specific category
   * 
   * @param systemId - System identifier
   * @param category - Diagnostic category to assess
   * @param vitalSigns - Current system vital signs
   * @returns Promise<CategoryDiagnostic> - Category-specific diagnostic results
   */
  private async performCategoryDiagnostic(
    systemId: string,
    category: DiagnosticCategory,
    vitalSigns: SystemVitalSigns
  ): Promise<CategoryDiagnostic> {
    const diagnosticStartTime = Date.now();
    
    try {
      const diagnostic: CategoryDiagnostic = {
        category,
        systemId,
        timestamp: new Date().toISOString(),
        assessmentDuration: 0,
        findings: [],
        score: 0,
        status: 'healthy',
        recommendations: []
      };
      
      switch (category) {
        case 'performance':
          diagnostic.findings = await this.diagnosePerfomanceIssues(
            systemId,
            vitalSigns.performance
          );
          break;
          
        case 'availability':
          diagnostic.findings = await this.diagnoseAvailabilityIssues(
            systemId,
            vitalSigns.availability
          );
          break;
          
        case 'reliability':
          diagnostic.findings = await this.diagnoseReliabilityIssues(
            systemId,
            vitalSigns
          );
          break;
          
        case 'security':
          diagnostic.findings = await this.diagnoseSecurityIssues(
            systemId
          );
          break;
          
        case 'maintainability':
          diagnostic.findings = await this.diagnoseMaintainabilityIssues(
            systemId
          );
          break;
          
        case 'scalability':
          diagnostic.findings = await this.diagnoseScalabilityIssues(
            systemId,
            vitalSigns
          );
          break;
          
        case 'compliance':
          diagnostic.findings = await this.diagnoseComplianceIssues(
            systemId
          );
          break;
          
        default:
          throw new Error(`Unknown diagnostic category: ${category}`);
      }
      
      // Calculate category score based on findings
      diagnostic.score = this.calculateCategoryScore(diagnostic.findings);
      
      // Determine category status
      diagnostic.status = this.determineCategoryStatus(
        diagnostic.score,
        diagnostic.findings
      );
      
      // Generate category-specific recommendations
      diagnostic.recommendations = this.generateCategoryRecommendations(
        category,
        diagnostic.findings
      );
      
      diagnostic.assessmentDuration = Date.now() - diagnosticStartTime;
      
      return diagnostic;
      
    } catch (error) {
      console.error(`Category diagnostic failed for ${category}:`, error);
      throw new CategoryDiagnosticError(
        `Failed to perform ${category} diagnostic`,
        error
      );
    }
  }
}

/**
 * System issue diagnostic and treatment service
 * 
 * Provides targeted diagnosis of specific system issues and generates
 * precise treatment plans with step-by-step remediation procedures.
 */
export class SystemIssueDiagnosticService {
  private diagnosticService: SystemHealthDiagnosticService;
  private treatmentDatabase: TreatmentDatabase;
  
  constructor(
    diagnosticService: SystemHealthDiagnosticService,
    treatmentDatabase: TreatmentDatabase
  ) {
    this.diagnosticService = diagnosticService;
    this.treatmentDatabase = treatmentDatabase;
  }
  
  /**
   * Diagnoses specific system issues with medical precision
   * 
   * @param issueDescription - Description of the observed system issue
   * @param systemContext - Context information about the system
   * @returns Promise<IssueDiagnosisResult> - Detailed diagnosis with treatment options
   * 
   * @example
   * ```typescript
   * const diagnosticService = new SystemIssueDiagnosticService(healthService, treatments);
   * const diagnosis = await diagnosticService.diagnoseSystemIssue(
   *   'API response times have increased 300% over the past hour',
   *   {
   *     systemId: 'payment-api',
   *     environment: 'production',
   *     recentChanges: ['database migration', 'new feature deployment']
   *   }
   * );
   * 
   * console.log(`Primary diagnosis: ${diagnosis.primaryDiagnosis.condition}`);
   * console.log(`Confidence: ${diagnosis.primaryDiagnosis.confidence}%`);
   * console.log(`Recommended treatment: ${diagnosis.recommendedTreatment.name}`);
   * ```
   */
  async diagnoseSystemIssue(
    issueDescription: string,
    systemContext: SystemContext
  ): Promise<IssueDiagnosisResult> {
    try {
      // Step 1: Parse and analyze issue symptoms
      const symptoms = await this.parseIssueSymptoms(issueDescription);
      
      // Step 2: Collect additional diagnostic data
      const diagnosticData = await this.collectDiagnosticData(
        systemContext.systemId,
        symptoms
      );
      
      // Step 3: Perform differential diagnosis
      const possibleDiagnoses = await this.performDifferentialDiagnosis(
        symptoms,
        diagnosticData,
        systemContext
      );
      
      // Step 4: Determine primary diagnosis
      const primaryDiagnosis = this.determinePrimaryDiagnosis(possibleDiagnoses);
      
      // Step 5: Generate treatment recommendations
      const treatmentOptions = await this.generateTreatmentOptions(
        primaryDiagnosis,
        systemContext
      );
      
      // Step 6: Create treatment plan
      const recommendedTreatment = this.selectOptimalTreatment(
        treatmentOptions,
        systemContext
      );
      
      return {
        issueDescription,
        systemContext,
        symptoms,
        possibleDiagnoses,
        primaryDiagnosis,
        treatmentOptions,
        recommendedTreatment,
        diagnosisTimestamp: new Date().toISOString(),
        followUpInstructions: this.generateFollowUpInstructions(
          primaryDiagnosis,
          recommendedTreatment
        )
      };
      
    } catch (error) {
      console.error('System issue diagnosis failed:', error);
      throw new IssueDiagnosisError('Failed to diagnose system issue', error);
    }
  }
  
  /**
   * Generates targeted treatment prescription for diagnosed issues
   * 
   * @param diagnosis - The confirmed system diagnosis
   * @param urgencyLevel - Treatment urgency (immediate, urgent, routine)
   * @returns Promise<TreatmentPrescription> - Detailed treatment prescription
   */
  async prescribeTreatment(
    diagnosis: SystemDiagnosis,
    urgencyLevel: TreatmentUrgency = 'routine'
  ): Promise<TreatmentPrescription> {
    try {
      // Look up evidence-based treatments for the diagnosis
      const availableTreatments = await this.treatmentDatabase.findTreatments(
        diagnosis.condition,
        diagnosis.severity
      );
      
      // Filter treatments based on system constraints and urgency
      const applicableTreatments = this.filterApplicableTreatments(
        availableTreatments,
        diagnosis.systemContext,
        urgencyLevel
      );
      
      if (applicableTreatments.length === 0) {
        throw new NoTreatmentAvailableError(
          `No applicable treatments found for ${diagnosis.condition}`
        );
      }
      
      // Select optimal treatment based on effectiveness and risk profile
      const selectedTreatment = this.selectOptimalTreatment(
        applicableTreatments,
        diagnosis.systemContext
      );
      
      // Create detailed treatment prescription
      const prescription: TreatmentPrescription = {
        treatmentId: selectedTreatment.id,
        treatmentName: selectedTreatment.name,
        diagnosis: diagnosis,
        urgencyLevel,
        prescribedAt: new Date().toISOString(),
        
        // Treatment instructions
        instructions: selectedTreatment.instructions,
        dosage: selectedTreatment.dosage, // e.g., configuration changes, deployment steps
        frequency: selectedTreatment.frequency, // e.g., monitor every 5 minutes
        duration: selectedTreatment.duration, // e.g., implement over 2 hours
        
        // Monitoring and safety
        monitoringPlan: this.createMonitoringPlan(selectedTreatment, diagnosis),
        safetyPrecautions: selectedTreatment.safetyPrecautions,
        rollbackPlan: this.createRollbackPlan(selectedTreatment, diagnosis),
        
        // Expected outcomes
        expectedResults: selectedTreatment.expectedResults,
        successCriteria: selectedTreatment.successCriteria,
        timeToImprovement: selectedTreatment.timeToImprovement,
        
        // Follow-up care
        followUpSchedule: this.createTreatmentFollowUpSchedule(
          selectedTreatment,
          urgencyLevel
        ),
        warningSignsToWatch: selectedTreatment.warningSignsToWatch
      };
      
      // Log treatment prescription for audit trail
      await this.logTreatmentPrescription(prescription);
      
      return prescription;
      
    } catch (error) {
      console.error('Treatment prescription failed:', error);
      throw new TreatmentPrescriptionError(
        'Failed to prescribe treatment',
        error
      );
    }
  }
}
```

## 🏥 **Dr. Mario's Advanced Diagnostic Features:**

### **📊 Comprehensive Vital Signs Monitoring**
- Continuous monitoring of system performance metrics
- Automated threshold-based alerting for critical conditions
- Historical trend analysis for pattern recognition
- Predictive health analytics for proactive intervention

### **🔬 Precise Diagnostic Methodology**
- Systematic symptom analysis and differential diagnosis
- Evidence-based diagnostic criteria and decision trees
- Multi-dimensional assessment across all system aspects
- Root cause analysis with treatment correlation

### **💊 Targeted Treatment Prescriptions**
- Customized treatment plans based on specific diagnoses
- Risk-benefit analysis for treatment selection
- Detailed implementation instructions with safety precautions
- Monitoring and follow-up care protocols

### **📈 Continuous Health Improvement**
- Long-term health trend monitoring and analysis
- Preventive care recommendations and health maintenance
- Treatment effectiveness tracking and optimization
- System resilience building and health promotion

---

**Usage**: Provide system symptoms, performance issues, or request a comprehensive health assessment, and Dr. Mario will diagnose the issues with medical precision and provide targeted treatment recommendations!

*"With professional diagnostic methodology and targeted treatments, we can restore your system to optimal health!"* - Dr. Mario 🩺⚕️