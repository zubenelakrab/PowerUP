#!/usr/bin/env node

/**
 * 🍄⭐ Mario Bros PowerUps Node.js Installer ⭐🍄
 * Cross-platform installer for npm distribution
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

class MarioPowerUpsInstaller {
    constructor() {
        this.claudeDir = path.join(os.homedir(), '.claude');
        this.packageDir = path.resolve(__dirname, '..');
        this.configDir = path.join(this.packageDir, 'claude-config');
    }

    /**
     * Install Mario PowerUps to Claude Code
     */
    async install() {
        console.log('🍄⭐ Installing Mario Bros PowerUps with Node.js installer ⭐🍄\n');

        try {
            // Step 1: Verify Claude Code installation
            this.verifyClaudeCode();

            // Step 2: Create required directories
            this.createDirectories();

            // Step 3: Check for existing installation
            this.handleExistingInstallation();

            // Step 4: Copy all components
            await this.copyComponents();

            // Step 5: Set permissions for hooks
            this.setHookPermissions();

            // Step 6: Installation success
            this.showInstallationSuccess();

        } catch (error) {
            console.error('❌ Installation failed:', error.message);
            process.exit(1);
        }
    }

    /**
     * Uninstall Mario PowerUps from Claude Code
     */
    async uninstall() {
        console.log('🗑️ Uninstalling Mario Bros PowerUps...\n');

        try {
            if (!fs.existsSync(this.claudeDir)) {
                console.log('⚠️ Claude Code directory not found - nothing to uninstall');
                return;
            }

            // Remove all Mario PowerUps components
            this.removeComponents();

            console.log('\n✅ Mario Bros PowerUps uninstalled successfully!');
            console.log('🏰 Your Claude Code is back to vanilla - but we\'ll miss the adventure!');

        } catch (error) {
            console.error('❌ Uninstallation failed:', error.message);
            process.exit(1);
        }
    }

    /**
     * Verify Claude Code is installed
     */
    verifyClaudeCode() {
        if (!fs.existsSync(this.claudeDir)) {
            throw new Error(`Claude Code not found at ${this.claudeDir}. Please install Claude Code first.`);
        }
        console.log('✅ Claude Code found');
    }

    /**
     * Create required directories
     */
    createDirectories() {
        const dirs = ['agents', 'commands', 'hooks'];
        
        dirs.forEach(dir => {
            const dirPath = path.join(this.claudeDir, dir);
            if (!fs.existsSync(dirPath)) {
                console.log(`📁 Creating ~/.claude/${dir} directory...`);
                fs.mkdirSync(dirPath, { recursive: true });
            }
        });
    }

    /**
     * Handle existing installation
     */
    handleExistingInstallation() {
        const agentsDir = path.join(this.claudeDir, 'agents');
        const existingAgents = fs.existsSync(agentsDir) ? 
            fs.readdirSync(agentsDir).filter(f => 
                f.includes('mario') || f.includes('luigi') || f.includes('peach') ||
                f.includes('bowser') || f.includes('rosalina') || f.includes('toadette')
            ) : [];

        if (existingAgents.length > 0) {
            console.log('⚠️ Mario PowerUps components found - updating existing installation...');
            // Clean up existing Mario components
            this.removeComponents(false); // Don't show completion message
        }
    }

    /**
     * Copy all components to Claude Code directories
     */
    async copyComponents() {
        console.log('📋 Installing Mario PowerUps components...\n');

        // Copy subagents
        await this.copyDirectory(
            path.join(this.configDir, 'agents'),
            path.join(this.claudeDir, 'agents'),
            'subagents'
        );

        // Copy slash commands  
        await this.copyDirectory(
            path.join(this.configDir, 'commands'),
            path.join(this.claudeDir, 'commands'),
            'slash commands'
        );

        // Copy development hooks
        await this.copyDirectory(
            path.join(this.configDir, 'hooks'),
            path.join(this.claudeDir, 'hooks'),
            'development hooks'
        );

        // Copy legacy support files
        await this.copyLegacySupport();

        // Copy documentation
        await this.copyDocumentation();
    }

    /**
     * Copy a directory with progress indication
     */
    async copyDirectory(sourceDir, targetDir, componentName) {
        if (!fs.existsSync(sourceDir)) {
            console.log(`⚠️ ${componentName} directory not found at ${sourceDir}`);
            return;
        }

        const files = fs.readdirSync(sourceDir);
        let copiedCount = 0;

        for (const file of files) {
            const sourcePath = path.join(sourceDir, file);
            const targetPath = path.join(targetDir, file);

            try {
                const stats = fs.statSync(sourcePath);
                
                if (stats.isFile()) {
                    fs.copyFileSync(sourcePath, targetPath);
                    copiedCount++;
                } else if (stats.isDirectory()) {
                    // Recursively copy subdirectories
                    if (!fs.existsSync(targetPath)) {
                        fs.mkdirSync(targetPath, { recursive: true });
                    }
                    await this.copyDirectory(sourcePath, targetPath, `${componentName}/${file}`);
                    copiedCount++;
                }
            } catch (error) {
                console.log(`⚠️ Failed to copy ${file}: ${error.message}`);
            }
        }

        if (copiedCount > 0) {
            console.log(`✅ ${copiedCount} ${componentName} installed`);
        }
    }

    /**
     * Copy legacy support files
     */
    async copyLegacySupport() {
        // Orchestra directory removed - contains only theoretical documentation
        // Core functionality is provided by claude-config/ components
        console.log('ℹ️ Orchestra documentation available in NPM package but not copied (theoretical only)');
    }

    /**
     * Copy documentation files
     */
    async copyDocumentation() {
        const docFiles = [
            'THINKING_MODIFIERS_GUIDE.md',
            'ULTIMATE_COMMAND_REFERENCE.md',
            'README.md',
            'CLAUDE.md'
        ];

        for (const docFile of docFiles) {
            const sourcePath = path.join(this.packageDir, docFile);
            if (fs.existsSync(sourcePath)) {
                const targetPath = path.join(this.claudeDir, `MARIO_${docFile}`);
                try {
                    fs.copyFileSync(sourcePath, targetPath);
                    console.log(`✅ ${docFile} documentation installed`);
                } catch (error) {
                    console.log(`⚠️ Failed to copy ${docFile}: ${error.message}`);
                }
            }
        }
    }

    /**
     * Set executable permissions for hook scripts
     */
    setHookPermissions() {
        const hooksDir = path.join(this.claudeDir, 'hooks');
        
        if (fs.existsSync(hooksDir)) {
            try {
                const hookFiles = fs.readdirSync(hooksDir).filter(f => f.endsWith('.sh'));
                
                hookFiles.forEach(hookFile => {
                    const hookPath = path.join(hooksDir, hookFile);
                    try {
                        fs.chmodSync(hookPath, '755');
                    } catch (error) {
                        console.log(`⚠️ Failed to set permissions for ${hookFile}: ${error.message}`);
                    }
                });

                if (hookFiles.length > 0) {
                    console.log(`✅ Set executable permissions for ${hookFiles.length} hook scripts`);
                }
            } catch (error) {
                console.log(`⚠️ Failed to set hook permissions: ${error.message}`);
            }
        }
    }

    /**
     * Remove Mario PowerUps components
     */
    removeComponents(showCompletion = true) {
        const patterns = [
            // Agent patterns
            { dir: 'agents', patterns: ['mario-*', 'luigi-*', 'peach-*', 'bowser-*', 'rosalina-*', 'toadette-*', 'toad-*'] },
            // Command patterns  
            { dir: 'commands', patterns: ['mario-*', 'luigi-*', 'peach-*', 'bowser-*', 'fire-trio*', 'smart-builder*', 'fortress*', 'chaos-*'] },
            // Hook patterns
            { dir: 'hooks', patterns: ['mario-*', 'coin-*', 'power-*', 'session-*', 'progress-*'] },
            // Legacy directories
            { dir: '.', patterns: ['powerups', 'orchestra'] }
        ];

        patterns.forEach(({ dir, patterns: filePatterns }) => {
            const targetDir = dir === '.' ? this.claudeDir : path.join(this.claudeDir, dir);
            
            if (fs.existsSync(targetDir)) {
                filePatterns.forEach(pattern => {
                    this.removeMatchingFiles(targetDir, pattern);
                });
            }
        });

        // Remove documentation files
        const docFiles = fs.readdirSync(this.claudeDir).filter(f => f.startsWith('MARIO_'));
        docFiles.forEach(docFile => {
            try {
                fs.unlinkSync(path.join(this.claudeDir, docFile));
                console.log(`🗑️ Removed ${docFile}`);
            } catch (error) {
                // Ignore errors for missing files
            }
        });

        if (showCompletion) {
            console.log('\n✅ Mario Bros PowerUps components removed');
        }
    }

    /**
     * Remove files matching a pattern
     */
    removeMatchingFiles(directory, pattern) {
        if (!fs.existsSync(directory)) return;

        try {
            const items = fs.readdirSync(directory);
            const regex = new RegExp(pattern.replace('*', '.*'));

            items.forEach(item => {
                if (regex.test(item)) {
                    const itemPath = path.join(directory, item);
                    const stats = fs.statSync(itemPath);

                    if (stats.isDirectory()) {
                        // Remove directory recursively
                        fs.rmSync(itemPath, { recursive: true, force: true });
                        console.log(`🗑️ Removed directory ${item}`);
                    } else {
                        fs.unlinkSync(itemPath);
                        console.log(`🗑️ Removed file ${item}`);
                    }
                }
            });
        } catch (error) {
            console.log(`⚠️ Failed to clean ${directory}: ${error.message}`);
        }
    }

    /**
     * Show installation success message
     */
    showInstallationSuccess() {
        console.log('\n🎉 Mario Bros PowerUps installed successfully!\n');
        
        console.log('🎮 **Quick Start:**');
        console.log('   Check status: /mario-status');
        console.log('   Get help: /mario-help');
        console.log('   Token stats: /mario-token-stats');
        console.log('');
        
        console.log('🤖 **Character Subagents Available:**');
        console.log('   - mario-hero: Full-stack development powerhouse');
        console.log('   - luigi-debugger: Debugging and quality assurance');
        console.log('   - peach-architect: Elegant system architecture');
        console.log('   - bowser-optimizer: Raw performance optimization');
        console.log('   - rosalina-systems-analysis: Cosmic systems thinking');
        console.log('   - toadette-i18n: Global internationalization');
        console.log('');
        
        console.log('🧠 **Thinking Modifiers System:**');
        console.log('   Use advanced reasoning: /mario:cot+reflection "your task"');
        console.log('   30+ strategies available: :tot, :got, :multi-agent, :verify, etc.');
        console.log('');
        
        console.log('📚 **Documentation:**');
        console.log('   ~/.claude/MARIO_THINKING_MODIFIERS_GUIDE.md');
        console.log('   ~/.claude/MARIO_ULTIMATE_COMMAND_REFERENCE.md');
        console.log('');
        
        console.log('🏰 Welcome to the Mario Bros AI Orchestra! Let\'s-a-go! 🍄⚡');
    }
}

// Export for use as module
module.exports = {
    install: () => new MarioPowerUpsInstaller().install(),
    uninstall: () => new MarioPowerUpsInstaller().uninstall(),
    MarioPowerUpsInstaller
};

// Allow direct execution
if (require.main === module) {
    const command = process.argv[2];
    const installer = new MarioPowerUpsInstaller();
    
    if (command === 'install') {
        installer.install();
    } else if (command === 'uninstall') {
        installer.uninstall();
    } else {
        console.log('Usage: node installer.js [install|uninstall]');
    }
}