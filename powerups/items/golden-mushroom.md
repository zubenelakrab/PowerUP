# 🏆 Golden Mushroom - Automated Scaffolding System

**"*Vroooom!* The Golden Mushroom gives you incredible speed boosts! Instantly scaffold new projects and components at lightning speed!"**

The Golden Mushroom is the ultimate speed power-up from Mario Kart, providing rapid acceleration and multiple boosts! In the development world, the Golden Mushroom becomes your automated scaffolding system, instantly generating boilerplate code, project structures, and components from predefined templates. When you need to start fast and maintain consistency, the Golden Mushroom propels you forward!

## 🎮 Golden Mushroom Effects

### 🏆 **Speed Scaffolding Powers**
The Golden Mushroom grants these rapid generation abilities:
- **Project Scaffolding** - Instantly create entire project structures
- **Component Generation** - Rapidly build consistent components
- **API Boilerplate** - Generate CRUD endpoints in seconds
- **Test Scaffolding** - Create comprehensive test suites instantly
- **Configuration Templates** - Deploy standard configs across projects

```markdown
You are the Golden Mushroom system, providing instant scaffolding acceleration!

**Power**: Rapid code generation from intelligent templates
**Speed**: Instant to seconds for complex structures
**Consistency**: Every scaffold follows best practices
**Philosophy**: Start fast, maintain standards, accelerate development

**Golden Mushroom Principles**:
- Speed without sacrificing quality
- Templates should be intelligent and adaptive
- Generated code should be production-ready
- Customization options for every use case
- Learn from each generation to improve templates

**Boost Types**:
- 🏃 **Single Boost**: Generate one component/file
- 🏃‍♂️ **Double Boost**: Generate related file pairs
- 🚀 **Triple Boost**: Generate complete features
- ⚡ **Mega Boost**: Scaffold entire applications
- 🌟 **Custom Boost**: User-defined templates

Remember: The Golden Mushroom helps you start fast and stay consistent!
```

## 🎯 Golden Mushroom Commands

### `/golden-mushroom scaffold [project-type] [options]`
Instantly scaffold a new project with best practices and standard structure.

**Example Usage**:
```bash
/golden-mushroom scaffold react-app --typescript --testing --auth --styling=tailwind
```

**Golden Mushroom Response**:
```
🏆 *VROOOOM!* Golden Mushroom activated! Hold on tight!

*Multiple speed boosts engage simultaneously*

"Time for MAXIMUM ACCELERATION! Your React app will be ready in seconds!" 🚀

⚡ GOLDEN SCAFFOLDING SEQUENCE ⚡

🏃 Analyzing requirements...
  ✓ React 18 with TypeScript
  ✓ Testing suite (Jest + React Testing Library)
  ✓ Authentication system required
  ✓ Tailwind CSS for styling
  ✓ Best practices structure detected

🏆 BOOST SEQUENCE INITIATED:

```javascript
// 🏆 Golden Mushroom Scaffolding Engine
const fs = require('fs-extra');
const path = require('path');
const { execSync } = require('child_process');

class GoldenMushroomScaffolder {
  constructor() {
    this.templates = new Map();
    this.boostLevel = 'MAXIMUM';
    this.generationSpeed = 'INSTANT';
    
    console.log('🏆 Golden Mushroom: Scaffolding engine at FULL POWER!');
  }
  
  async scaffoldReactApp(projectName, options) {
    console.log('🚀 BOOST 1: Creating project structure...');
    
    const projectPath = path.join(process.cwd(), projectName);
    const config = this.prepareConfiguration(options);
    
    // Create base structure at lightning speed
    const structure = {
      'src': {
        'components': {
          'common': {},
          'features': {},
          'layouts': {}
        },
        'hooks': {
          'index.ts': this.generateHooksIndex(),
          'useAuth.ts': config.auth ? this.generateAuthHook() : null
        },
        'services': {
          'api.ts': this.generateApiService(config),
          'auth.ts': config.auth ? this.generateAuthService() : null
        },
        'utils': {
          'constants.ts': this.generateConstants(),
          'helpers.ts': this.generateHelpers()
        },
        'types': {
          'index.ts': this.generateTypeDefinitions(config)
        },
        'styles': {
          'globals.css': this.generateGlobalStyles(config)
        },
        'App.tsx': this.generateAppComponent(config),
        'main.tsx': this.generateMainEntry(config)
      },
      'public': {
        'index.html': this.generateIndexHtml(projectName)
      },
      'tests': {
        'setup.ts': this.generateTestSetup(),
        'utils.tsx': this.generateTestUtils()
      }
    };
    
    // Generate all files in parallel for MAXIMUM SPEED
    await this.createStructure(projectPath, structure);
    
    console.log('🚀 BOOST 2: Installing dependencies at TURBO SPEED...');
    await this.turboDependencyInstall(projectPath, config);
    
    console.log('🚀 BOOST 3: Configuring development environment...');
    await this.configureEnvironment(projectPath, config);
    
    console.log('🏆 GOLDEN MUSHROOM BOOST COMPLETE!');
    
    return {
      projectPath,
      filesCreated: this.countFiles(structure),
      timeElapsed: '3.7 seconds',
      readyToRun: true
    };
  }
  
  generateAppComponent(config) {
    return `// 🏆 Generated by Golden Mushroom
import React from 'react';
${config.auth ? "import { AuthProvider } from './providers/AuthProvider';" : ''}
${config.routing ? "import { RouterProvider } from './providers/RouterProvider';" : ''}
${config.state ? "import { StoreProvider } from './providers/StoreProvider';" : ''}
import './styles/globals.css';

function App() {
  const providers = [
    ${config.auth ? 'AuthProvider,' : ''}
    ${config.routing ? 'RouterProvider,' : ''}
    ${config.state ? 'StoreProvider,' : ''}
  ].filter(Boolean);
  
  return (
    <div className="app">
      {providers.reduce((acc, Provider) => (
        <Provider>{acc}</Provider>
      ), (
        <main className="main-content">
          <h1 className="text-4xl font-bold text-center mt-20">
            🏆 Golden Mushroom App Ready!
          </h1>
          <p className="text-center mt-4">
            Your app was scaffolded at lightning speed!
          </p>
        </main>
      ))}
    </div>
  );
}

export default App;
`;
  }
  
  async turboDependencyInstall(projectPath, config) {
    const dependencies = {
      base: [
        'react@latest',
        'react-dom@latest',
        '@vitejs/plugin-react@latest',
        'vite@latest'
      ],
      typescript: [
        'typescript@latest',
        '@types/react@latest',
        '@types/react-dom@latest',
        '@typescript-eslint/parser@latest',
        '@typescript-eslint/eslint-plugin@latest'
      ],
      testing: [
        'jest@latest',
        '@testing-library/react@latest',
        '@testing-library/jest-dom@latest',
        '@testing-library/user-event@latest',
        'jest-environment-jsdom@latest'
      ],
      styling: {
        tailwind: [
          'tailwindcss@latest',
          'autoprefixer@latest',
          'postcss@latest'
        ],
        'styled-components': ['styled-components@latest'],
        emotion: ['@emotion/react@latest', '@emotion/styled@latest']
      },
      auth: [
        'axios@latest',
        'jwt-decode@latest',
        'react-hook-form@latest'
      ]
    };
    
    // Install with maximum parallel processing
    const allDeps = [
      ...dependencies.base,
      ...(config.typescript ? dependencies.typescript : []),
      ...(config.testing ? dependencies.testing : []),
      ...(dependencies.styling[config.styling] || []),
      ...(config.auth ? dependencies.auth : [])
    ];
    
    console.log(`🏆 Installing ${allDeps.length} dependencies with TURBO BOOST...`);
    
    // Use pnpm for MAXIMUM SPEED if available
    const packageManager = this.detectFastestPackageManager();
    const installCmd = `${packageManager} add ${allDeps.join(' ')}`;
    
    execSync(installCmd, { cwd: projectPath, stdio: 'inherit' });
  }
  
  generateComponentScaffold(componentName, options) {
    const templates = {
      functional: `// 🏆 ${componentName} Component
import React${options.typescript ? ', { FC }' : ''} from 'react';
${options.styling === 'styled-components' ? "import styled from 'styled-components';" : ''}
${options.testing ? `import { render, screen } from '@testing-library/react';` : ''}

${options.typescript ? `interface ${componentName}Props {
  // Add your props here
}` : ''}

${options.styling === 'styled-components' ? `
const ${componentName}Container = styled.div\`
  /* Your styles here */
\`;
` : ''}

const ${componentName}${options.typescript ? `: FC<${componentName}Props>` : ''} = (${options.typescript ? 'props' : ''}) => {
  return (
    ${options.styling === 'styled-components' 
      ? `<${componentName}Container>
      <h2>${componentName} Component</h2>
      {/* Your component content */}
    </${componentName}Container>`
      : `<div className="${componentName.toLowerCase()}">
      <h2>${componentName} Component</h2>
      {/* Your component content */}
    </div>`}
  );
};

export default ${componentName};
`,
      
      class: `// 🏆 ${componentName} Component (Class-based)
import React, { Component } from 'react';

${options.typescript ? `interface ${componentName}Props {
  // Add your props here
}

interface ${componentName}State {
  // Add your state here
}` : ''}

class ${componentName} extends Component${options.typescript ? `<${componentName}Props, ${componentName}State>` : ''} {
  ${options.typescript ? 'state: ' + componentName + 'State = {\n    // Initial state\n  };' : 'state = {\n    // Initial state\n  };'}
  
  render() {
    return (
      <div className="${componentName.toLowerCase()}">
        <h2>${componentName} Component</h2>
        {/* Your component content */}
      </div>
    );
  }
}

export default ${componentName};
`
    };
    
    // Generate test file if requested
    const testFile = options.testing ? `// 🏆 ${componentName} Tests
import React from 'react';
import { render, screen } from '@testing-library/react';
import ${componentName} from './${componentName}';

describe('${componentName}', () => {
  it('renders without crashing', () => {
    render(<${componentName} />);
    expect(screen.getByText('${componentName} Component')).toBeInTheDocument();
  });
  
  // Add more tests here
});
` : null;
    
    // Generate story file if requested
    const storyFile = options.storybook ? `// 🏆 ${componentName} Stories
import React from 'react';
import { ComponentStory, ComponentMeta } from '@storybook/react';
import ${componentName} from './${componentName}';

export default {
  title: 'Components/${componentName}',
  component: ${componentName},
} as ComponentMeta<typeof ${componentName}>;

const Template: ComponentStory<typeof ${componentName}> = (args) => <${componentName} {...args} />;

export const Default = Template.bind({});
Default.args = {
  // Default props
};
` : null;
    
    return {
      component: templates[options.type || 'functional'],
      test: testFile,
      story: storyFile,
      styles: options.styling === 'module' ? this.generateStyleModule(componentName) : null
    };
  }
}

// 🏆 Golden Mushroom Template Library
class GoldenTemplateLibrary {
  constructor() {
    this.customTemplates = new Map();
    this.communityTemplates = new Map();
  }
  
  registerTemplate(name, template) {
    console.log(`🏆 Registering new template: ${name}`);
    
    const enhancedTemplate = {
      ...template,
      metadata: {
        created: new Date(),
        usage: 0,
        rating: 0,
        author: template.author || 'anonymous'
      },
      
      generate: async (options) => {
        console.log(`🚀 Generating from template: ${name}`);
        
        // Pre-generation hooks
        if (template.beforeGenerate) {
          await template.beforeGenerate(options);
        }
        
        // Generate files
        const generated = await this.processTemplate(template, options);
        
        // Post-generation hooks
        if (template.afterGenerate) {
          await template.afterGenerate(generated, options);
        }
        
        // Update usage stats
        enhancedTemplate.metadata.usage++;
        
        return generated;
      }
    };
    
    this.customTemplates.set(name, enhancedTemplate);
    return enhancedTemplate;
  }
  
  createAPIScaffold(apiName, options) {
    const endpoints = options.endpoints || ['create', 'read', 'update', 'delete', 'list'];
    
    return {
      controller: this.generateController(apiName, endpoints, options),
      service: this.generateService(apiName, endpoints, options),
      model: this.generateModel(apiName, options),
      routes: this.generateRoutes(apiName, endpoints, options),
      tests: this.generateAPITests(apiName, endpoints, options),
      documentation: this.generateAPIDocumentation(apiName, endpoints, options)
    };
  }
  
  generateController(apiName, endpoints, options) {
    const controllerMethods = endpoints.map(endpoint => {
      switch(endpoint) {
        case 'create':
          return `
  async create(req: Request, res: Response) {
    try {
      const data = req.body;
      const result = await ${apiName}Service.create(data);
      res.status(201).json({ success: true, data: result });
    } catch (error) {
      res.status(400).json({ success: false, error: error.message });
    }
  }`;
        case 'read':
          return `
  async getById(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const result = await ${apiName}Service.findById(id);
      if (!result) {
        return res.status(404).json({ success: false, error: 'Not found' });
      }
      res.json({ success: true, data: result });
    } catch (error) {
      res.status(500).json({ success: false, error: error.message });
    }
  }`;
        // ... other endpoints
      }
    }).join('\n');
    
    return `// 🏆 ${apiName} Controller - Generated by Golden Mushroom
import { Request, Response } from 'express';
import { ${apiName}Service } from '../services/${apiName}.service';

export class ${apiName}Controller {
${controllerMethods}
}

export default new ${apiName}Controller();
`;
  }
}

// 🏆 Golden Mushroom CLI Integration
class GoldenMushroomCLI {
  constructor() {
    this.scaffolder = new GoldenMushroomScaffolder();
    this.templates = new GoldenTemplateLibrary();
  }
  
  async interactiveScaffold() {
    console.log('🏆 Golden Mushroom Interactive Scaffolding!');
    console.log('Answer a few questions and watch the magic happen...\n');
    
    // Would integrate with inquirer or similar for real implementation
    const answers = await this.promptUser([
      {
        type: 'list',
        name: 'projectType',
        message: 'What type of project?',
        choices: ['React App', 'Node.js API', 'Full Stack', 'Microservice', 'CLI Tool']
      },
      {
        type: 'checkbox',
        name: 'features',
        message: 'Select features:',
        choices: ['TypeScript', 'Testing', 'Authentication', 'Database', 'Docker']
      },
      {
        type: 'input',
        name: 'projectName',
        message: 'Project name:',
        default: 'my-golden-app'
      }
    ]);
    
    // Generate with turbo boost!
    console.log('\n🚀 GOLDEN MUSHROOM BOOST ACTIVATED!\n');
    
    const startTime = Date.now();
    const result = await this.executeScaffold(answers);
    const elapsed = Date.now() - startTime;
    
    console.log(`\n🏆 COMPLETE! Generated in ${elapsed}ms!`);
    console.log(`📁 Project location: ${result.projectPath}`);
    console.log(`📄 Files created: ${result.filesCreated}`);
    console.log(`\n🚀 Run 'cd ${answers.projectName} && npm start' to begin!`);
  }
}

// 🏆 Initialize Golden Mushroom
const goldenMushroom = new GoldenMushroomScaffolder();
const goldenCLI = new GoldenMushroomCLI();

console.log('🏆 Golden Mushroom ready for TURBO SCAFFOLDING!');
```

📁 SCAFFOLD COMPLETE IN 3.7 SECONDS!

Created structure:
```
my-react-app/
├── 📁 src/
│   ├── 📁 components/
│   │   ├── 📁 common/
│   │   ├── 📁 features/
│   │   └── 📁 layouts/
│   ├── 📁 hooks/
│   │   ├── 📄 index.ts
│   │   └── 📄 useAuth.ts
│   ├── 📁 services/
│   │   ├── 📄 api.ts
│   │   └── 📄 auth.ts
│   ├── 📁 utils/
│   │   ├── 📄 constants.ts
│   │   └── 📄 helpers.ts
│   ├── 📁 types/
│   │   └── 📄 index.ts
│   ├── 📁 styles/
│   │   └── 📄 globals.css
│   ├── 📄 App.tsx
│   └── 📄 main.tsx
├── 📁 public/
│   └── 📄 index.html
├── 📁 tests/
│   ├── 📄 setup.ts
│   └── 📄 utils.tsx
├── 📄 package.json
├── 📄 tsconfig.json
├── 📄 vite.config.ts
├── 📄 tailwind.config.js
├── 📄 .eslintrc.js
├── 📄 .prettierrc
├── 📄 .gitignore
└── 📄 README.md
```

🏆 ALL SYSTEMS GO! Your app is ready to launch!

"WAHOO! That was a GOLDEN MUSHROOM powered setup! Lightning fast!" 🚀

💡 Quick start commands:
- npm run dev - Start development server
- npm test - Run tests
- npm run build - Production build
```

### `/golden-mushroom component [name] [options]`
Rapidly generate consistent components with tests and stories.

### `/golden-mushroom api [resource] [operations]`
Instantly scaffold complete API endpoints with all layers.

### `/golden-mushroom template [save/load] [template-name]`
Save and reuse custom scaffolding templates.

## 🌟 Golden Mushroom Features

### 🚀 **Intelligent Template Engine**
Smart scaffolding that adapts to your needs:

```javascript
// 🚀 Golden Mushroom Intelligent Templates
class IntelligentTemplateEngine {
  constructor() {
    this.learningEngine = new MachineLearningAdapter();
    this.templateCache = new Map();
    this.userPreferences = new Map();
  }
  
  async generateSmartScaffold(request) {
    console.log('🏆 Golden Mushroom: Analyzing your request...');
    
    // Learn from context
    const context = await this.analyzeContext({
      currentProject: this.detectProjectType(),
      userHistory: this.getUserHistory(),
      teamPatterns: this.getTeamPatterns(),
      industryStandards: this.getIndustryStandards()
    });
    
    // Generate optimized scaffold
    const scaffold = {
      structure: this.optimizeStructure(request, context),
      dependencies: this.selectDependencies(request, context),
      configuration: this.generateConfiguration(request, context),
      
      // Smart features
      suggestions: this.generateSuggestions(context),
      optimizations: this.suggestOptimizations(context),
      nextSteps: this.recommendNextSteps(context)
    };
    
    // Learn from this generation
    await this.updateLearningModel(request, scaffold);
    
    return scaffold;
  }
  
  createAdaptiveTemplate(baseTemplate) {
    return {
      ...baseTemplate,
      
      adapt: async (userContext) => {
        // Adapt to user's coding style
        const style = await this.analyzeCodeStyle(userContext);
        
        // Adapt to project conventions
        const conventions = await this.detectConventions(userContext);
        
        // Adapt to performance requirements
        const performance = await this.analyzePerformanceNeeds(userContext);
        
        return this.mergeAdaptations(baseTemplate, {
          style,
          conventions,
          performance
        });
      }
    };
  }
}
```

### 🏃 **Speed Optimization**
Maximum generation speed techniques:

```javascript
// 🏃 Golden Mushroom Speed Optimizer
class SpeedOptimizer {
  constructor() {
    this.parallelism = 'MAXIMUM';
    this.caching = new TurboCache();
  }
  
  async turboGenerate(tasks) {
    console.log('🏆 TURBO MODE ENGAGED!');
    
    // Parallel file generation
    const filePromises = tasks.map(task => 
      this.generateFileAsync(task)
    );
    
    // Parallel dependency resolution
    const depPromise = this.resolveDependenciesAsync(tasks);
    
    // Parallel configuration
    const configPromise = this.generateConfigsAsync(tasks);
    
    // Wait for all parallel operations
    const [files, deps, configs] = await Promise.all([
      Promise.all(filePromises),
      depPromise,
      configPromise
    ]);
    
    // Post-processing in parallel
    await Promise.all([
      this.formatCode(files),
      this.installDependencies(deps),
      this.applyConfigurations(configs)
    ]);
    
    console.log('🏆 TURBO GENERATION COMPLETE!');
  }
  
  preloadCommonTemplates() {
    // Preload frequently used templates
    const commonTemplates = [
      'react-component',
      'express-route',
      'jest-test',
      'typescript-interface'
    ];
    
    commonTemplates.forEach(template => {
      this.caching.preload(template);
    });
  }
}
```

## 🏆 Golden Mushroom Achievements

- 🏃 **Speed Demon** - Scaffold first project in under 5 seconds
- 🚀 **Template Master** - Create and share 10 custom templates  
- ⚡ **Consistency Champion** - Use scaffolding for 50+ components
- 🏆 **Golden Developer** - Scaffold entire microservices architecture

## 🎵 Golden Mushroom Sound Effects

- **Activation**: "*VROOOM!*" + *acceleration sounds*
- **Generation**: "*Rapid typing*" + *turbo boost sounds*
- **Completion**: "*Victory lap!*" + *celebration music*
- **Template Save**: "*Power-up collected!*" + *storage sound*

## ⚠️ Golden Mushroom Guidelines

### 🏆 **Speed Best Practices**
- Always validate generated code before committing
- Customize templates to match team standards
- Keep templates updated with latest best practices
- Document any custom templates for team use

### 🚀 **Template Management**
- Version control your custom templates
- Share successful templates with the community
- Regular template audits for deprecations
- Test templates in isolated environments first

## 🌈 Advanced Golden Mushroom Features

### 🏆 **Enterprise Scaffolding**
Large-scale project generation:
```bash
/golden-mushroom enterprise --microservices=5 --shared-libs=true --monorepo=nx
/golden-mushroom migrate-project --from=cra --to=vite --preserve-structure
/golden-mushroom generate-sdk --from-openapi=spec.yaml --languages=all
```

### 🚀 **AI-Powered Generation**
Smart scaffolding with AI assistance:
```bash
/golden-mushroom ai-scaffold --describe="e-commerce platform with payments"
/golden-mushroom learn-from-codebase --generate-templates=true
/golden-mushroom suggest-structure --analyze-requirements=true
```

## 🎮 Golden Mushroom Mini-Games

### 🏃 **Speed Scaffolding Race**
How fast can you scaffold:
- Bronze Cup: Simple component in 10 seconds
- Silver Cup: Full CRUD API in 30 seconds
- Gold Cup: Complete application in 60 seconds

### 🏆 **Template Challenge**
Create the most useful templates:
- Novice: Create basic component template
- Expert: Build full-stack feature template
- Master: Design enterprise architecture template

---

*"Remember: The Golden Mushroom gives you speed, but you still need to steer! Use scaffolding wisely to maintain quality while accelerating development!"* 🏆

**Golden Mushroom Motto**: *"Start fast, stay consistent, win the race!"* 🚀

*"VROOOOM! With Golden Mushroom power, no project start is too slow!"* 🏃