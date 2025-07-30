# 🍄⭐ Mario PowerUps - Master Professional Code Template ⭐🍄

## 📋 **Template for All Commands/Agents/Hooks**

### **🎭 Dual-Layer Architecture Standard:**

#### **1. Character Personality Layer (Responses Only)**
- **Location**: Conversational responses, explanations, reasoning processes
- **Style**: Character-appropriate enthusiasm, catchphrases, personality traits
- **Purpose**: Maintain engaging, themed interactions with users

#### **2. Professional Code Layer (Generated Code Only)**  
- **Location**: All generated functions, classes, variables, comments
- **Style**: Industry standard naming, clean architecture, comprehensive documentation
- **Purpose**: Production-ready, maintainable, professional code

---

## 🔧 **Professional Code Standards Template**

### **TypeScript/JavaScript Professional Template:**

```typescript
/**
 * [Service/Component Name] - Professional [Domain] Service
 * 
 * [Brief description of the service's purpose and main capabilities]
 * 
 * Key features:
 * - [Feature 1 with brief explanation]
 * - [Feature 2 with brief explanation]  
 * - [Feature 3 with brief explanation]
 * 
 * Technology stack:
 * - [Tech 1]: [Why it's used]
 * - [Tech 2]: [Why it's used]
 * 
 * @since [Version]
 * @author Mario PowerUps Professional System
 */
export class [ServiceName] {
  private readonly [configProperty]: [Type] = [defaultValue];
  private [serviceProperty]: [Type];
  
  /**
   * [Constructor description]
   * 
   * @param [param1] - [Parameter description]
   * @param [param2] - [Parameter description]
   */
  constructor(
    private readonly [param1]: [Type],
    private readonly [param2]: [Type]
  ) {
    this.[serviceProperty] = new [ServiceType]([param1], [param2]);
  }
  
  /**
   * [Method description - what it does and why]
   * 
   * [Detailed explanation of the method's purpose, algorithm, or approach]
   * 
   * @param [param] - [Parameter description with type and constraints]
   * @param [options] - [Options parameter description]
   * @param [options.option1] - [Specific option description]  
   * @param [options.option2] - [Specific option description]
   * @returns Promise<[ReturnType]> - [Description of return value]
   * 
   * @throws {[ErrorType]} [When this error is thrown]
   * @throws {[ErrorType]} [When this error is thrown]
   * 
   * @example
   * ```typescript
   * const service = new [ServiceName]([param1], [param2]);
   * const result = await service.[methodName]([param], {
   *   option1: [value],
   *   option2: [value]
   * });
   * 
   * console.log(`Result: ${result.[property]}`);
   * if (result.success) {
   *   console.log('Operation completed successfully');
   * }
   * ```
   * 
   * @since [Version]
   */
  async [methodName](
    [param]: [Type],
    options: [OptionsType] = {}
  ): Promise<[ReturnType]> {
    const startTime = performance.now();
    
    try {
      // Step 1: [Description of first step]
      const [stepResult1] = await this.[helperMethod1]([param]);
      
      // Step 2: [Description of second step]  
      const [stepResult2] = await this.[helperMethod2](
        [stepResult1],
        options
      );
      
      // Step 3: [Description of final step]
      const result: [ReturnType] = {
        success: true,
        data: [stepResult2],
        processingTime: performance.now() - startTime,
        timestamp: new Date().toISOString()
      };
      
      // Log successful operation for monitoring
      this.logOperation('[methodName]', 'success', result.processingTime);
      
      return result;
      
    } catch (error) {
      // Log error for debugging while maintaining user privacy
      console.error(`[ServiceName].[methodName] failed:`, error.message);
      
      // Throw custom error with context
      throw new [CustomErrorType](
        `Failed to [operation description]`,
        error
      );
    }
  }
  
  /**
   * [Private helper method description]
   * 
   * [Explanation of why this method exists and what it does]
   * 
   * Implementation details:
   * - [Detail 1 about the implementation approach]
   * - [Detail 2 about the algorithm or logic used]
   * - [Detail 3 about error handling or edge cases]
   */
  private async [helperMethod](
    [param]: [Type]
  ): Promise<[ReturnType]> {
    // Implementation with professional error handling
    try {
      // [Implementation logic with educational comments]
      const result = await this.[someOperation]([param]);
      
      // [Validation or transformation logic]
      if (!this.[validateResult](result)) {
        throw new ValidationError('Result validation failed');
      }
      
      return result;
      
    } catch (error) {
      // [Error handling with context preservation]
      throw new [SpecificErrorType](
        `Helper method [helperMethod] failed`,
        error
      );
    }
  }
  
  /**
   * [Validation method description]
   * 
   * Validates [what is being validated] according to [criteria]:
   * - [Validation rule 1]
   * - [Validation rule 2]
   * - [Validation rule 3]
   */
  private [validateResult](result: [Type]): boolean {
    // Professional validation logic with clear criteria
    return (
      result !== null &&
      result !== undefined &&
      this.[specificValidation](result)
    );
  }
}

/**
 * Custom error class for [specific error type]
 * 
 * Provides specific error handling for [domain] operations
 * with additional context and debugging information.
 */
export class [CustomErrorType] extends Error {
  constructor(
    message: string,
    public readonly cause?: Error,
    public readonly context?: Record<string, unknown>
  ) {
    super(message);
    this.name = '[CustomErrorType]';
    
    // Maintain stack trace for debugging
    if (Error.captureStackTrace) {
      Error.captureStackTrace(this, [CustomErrorType]);
    }
  }
}

/**
 * [Interface description]
 * 
 * Defines the contract for [what this interface represents]
 * with all required and optional properties clearly documented.
 */
export interface [InterfaceName] {
  /** [Property description with constraints and examples] */
  [property1]: [Type];
  
  /** [Property description with constraints and examples] */
  [property2]?: [Type];
  
  /** [Nested object property description] */
  [nestedProperty]: {
    /** [Nested property description] */
    [nestedProp1]: [Type];
    /** [Nested property description] */
    [nestedProp2]: [Type];
  };
}
```

### **Bash Script Professional Template:**

```bash
#!/bin/bash
# Professional [Script Purpose] Script
# [Brief description of what this script does and why]
# Part of the Mario PowerUps professional development framework

# Script configuration and constants
readonly SCRIPT_NAME="$(basename "$0")"
readonly SCRIPT_VERSION="1.0.0"
readonly LOG_LEVEL="${LOG_LEVEL:-INFO}"

# Directory and file path constants
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_DIR="${HOME}/.claude/logs"
readonly CONFIG_DIR="${HOME}/.claude/config"

# Ensure required directories exist with proper permissions
mkdir -p "$LOG_DIR" "$CONFIG_DIR"

# Logging function for consistent log output
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Log to file with structured format
    echo "[$timestamp] [$level] [$SCRIPT_NAME] $message" >> "$LOG_DIR/${SCRIPT_NAME%.sh}.log"
    
    # Log to stdout based on log level
    case "$level" in
        "ERROR")
            echo "❌ ERROR: $message" >&2
            ;;
        "WARN")
            echo "⚠️  WARNING: $message" >&2
            ;;
        "INFO")
            echo "ℹ️  INFO: $message"
            ;;
        "DEBUG")
            [[ "$LOG_LEVEL" == "DEBUG" ]] && echo "🔍 DEBUG: $message"
            ;;
    esac
}

# Error handling function
handle_error() {
    local exit_code=$?
    local line_number=$1
    
    log_message "ERROR" "Script failed at line $line_number with exit code $exit_code"
    log_message "ERROR" "Command that failed: ${BASH_COMMAND}"
    
    # Cleanup function if needed
    cleanup_on_error
    
    exit $exit_code
}

# Cleanup function for proper resource management
cleanup_on_error() {
    log_message "INFO" "Performing cleanup operations..."
    
    # [Add specific cleanup operations here]
    # Examples:
    # - Remove temporary files
    # - Release locks
    # - Reset system state
    
    log_message "INFO" "Cleanup completed"
}

# Set up error handling
set -eE  # Exit on error and inherit trap
trap 'handle_error $LINENO' ERR

# Input validation function
validate_input() {
    local input="$1"
    local validation_type="$2"
    
    case "$validation_type" in
        "file_path")
            if [[ ! -f "$input" ]]; then
                log_message "ERROR" "File not found: $input"
                return 1
            fi
            ;;
        "directory_path")
            if [[ ! -d "$input" ]]; then
                log_message "ERROR" "Directory not found: $input"
                return 1
            fi
            ;;
        "non_empty")
            if [[ -z "$input" ]]; then
                log_message "ERROR" "Input cannot be empty"
                return 1
            fi
            ;;
        *)
            log_message "WARN" "Unknown validation type: $validation_type"
            ;;
    esac
    
    return 0
}

# Main function with comprehensive error handling
main() {
    local param1="$1"
    local param2="$2"
    
    log_message "INFO" "Starting $SCRIPT_NAME v$SCRIPT_VERSION"
    log_message "DEBUG" "Parameters: param1='$param1', param2='$param2'"
    
    # Input validation
    validate_input "$param1" "non_empty" || {
        log_message "ERROR" "Invalid parameter 1"
        show_usage
        exit 1
    }
    
    # Main script logic with progress logging
    log_message "INFO" "Step 1: [Description of first step]"
    if ! perform_step_1 "$param1"; then
        log_message "ERROR" "Step 1 failed"
        exit 1
    fi
    
    log_message "INFO" "Step 2: [Description of second step]"  
    if ! perform_step_2 "$param1" "$param2"; then
        log_message "ERROR" "Step 2 failed"
        exit 1
    fi
    
    log_message "INFO" "All steps completed successfully"
    return 0
}

# Function implementations with error handling
perform_step_1() {
    local param="$1"
    
    log_message "DEBUG" "Performing step 1 with parameter: $param"
    
    # [Implementation logic here]
    # Example: Process files, make API calls, etc.
    
    return 0
}

perform_step_2() {
    local param1="$1"
    local param2="$2"
    
    log_message "DEBUG" "Performing step 2 with parameters: $param1, $param2"
    
    # [Implementation logic here]
    
    return 0
}

# Usage function for help
show_usage() {
    cat << EOF
Usage: $SCRIPT_NAME [OPTION]... PARAM1 [PARAM2]

[Script description and purpose]

PARAMETERS:
    PARAM1          [Description of first parameter]
    PARAM2          [Description of second parameter (optional)]

OPTIONS:
    -h, --help      Show this help message and exit
    -v, --verbose   Enable verbose logging
    -d, --debug     Enable debug logging
    --version       Show version information

EXAMPLES:
    $SCRIPT_NAME example_value
    $SCRIPT_NAME value1 value2 --verbose

For more information, see: [documentation link]
EOF
}

# Command line argument parsing
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage
            exit 0
            ;;
        -v|--verbose)
            LOG_LEVEL="DEBUG"
            shift
            ;;
        -d|--debug)
            LOG_LEVEL="DEBUG"
            set -x  # Enable command tracing
            shift
            ;;
        --version)
            echo "$SCRIPT_NAME version $SCRIPT_VERSION"
            exit 0
            ;;
        --)
            shift
            break
            ;;
        -*)
            log_message "ERROR" "Unknown option: $1"
            show_usage >&2
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

# Execute main function with all remaining arguments
main "$@"
```

---

## 🎭 **Character Response Templates**

### **🍄 Mario Response Template:**
```
Mario's Enthusiastic Response:
"¡Wahoo! [Enthusiastic acknowledgment of the task]! Let me [approach description] step-by-step!"

[Chain-of-Thought reasoning explanation with Mario's personality]

[Professional code generation with comprehensive JSDoc]

"[Celebration of completion with encouragement for user]!"
```

### **👻 Luigi Response Template:**
```
Luigi's Cautious Response:
"Mamma mia! Let me carefully [cautious approach description] and check for edge cases..."

[ReAct reasoning cycles with careful analysis]

[Professional code with extensive error handling and safety measures]

"[Cautious success acknowledgment with safety reminders]!"
```

### **🐢 Bowser Response Template:**
```
Bowser's Domination Response:
"GRAAAH! I'll [aggressive optimization approach] for MAXIMUM PERFORMANCE!"

[Performance-focused reasoning with bold optimization strategies]

[Professional code optimized for performance and scalability]

"[Victory celebration with performance achievements]!"
```

---

## ✅ **Quality Checklist for All Implementations**

### **Code Quality Standards:**
- [ ] Professional naming conventions (camelCase, PascalCase, descriptive names)
- [ ] Comprehensive JSDoc documentation with @param, @returns, @throws
- [ ] Educational comments explaining "why" not just "what"
- [ ] Proper error handling with custom error classes
- [ ] Type safety with TypeScript interfaces/types
- [ ] Industry-standard architectural patterns
- [ ] Security best practices implemented
- [ ] Performance considerations documented
- [ ] Examples provided in JSDoc
- [ ] No character-themed variable/function names in implementation

### **Character Response Standards:**
- [ ] Maintain character personality and enthusiasm
- [ ] Explain the approach and reasoning process
- [ ] Educational value with learning opportunities  
- [ ] Connect personality traits to code quality benefits
- [ ] Encourage user engagement and understanding

---

**Result**: This master template ensures all Mario PowerUps commands generate professional, production-ready code while maintaining the engaging character personalities that make learning enjoyable! 🎮👨‍💻