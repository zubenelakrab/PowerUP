#!/usr/bin/env node

/**
 * 🍄⭐ Mario Bros PowerUps CLI ⭐🍄
 * Command line interface for installing and managing Mario PowerUps
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

// ASCII Art Banner
const banner = `
                          🍄⭐ MARIO BROS POWERUPS ⭐🍄
    
    ██████╗  ██████╗ ██╗    ██╗███████╗██████╗ ██╗   ██╗██████╗ 
    ██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗██║   ██║██╔══██╗
    ██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝██║   ██║██████╔╝
    ██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗██║   ██║██╔═══╝ 
    ██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║╚██████╔╝██║     
    ╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     
                                                                
              🎮 THE ULTIMATE AI COLLABORATION SYSTEM 🎮
`;

function showHelp() {
    console.log(banner);
    console.log(`
🍄 Mario Bros PowerUps CLI

Commands:
  install     Install PowerUps to Claude Code
  uninstall   Remove PowerUps from Claude Code
  status      Check installation status
  help        Show this help message
  version     Show version information

Examples:
  powerup install
  powerup status
  powerup uninstall

For more information: https://github.com/zubenelakrab/PowerUP
`);
}

function showVersion() {
    const packageJson = require('./package.json');
    console.log(`🍄 Mario Bros PowerUps v${packageJson.version}`);
}

function checkClaudeDir() {
    const claudeDir = path.join(os.homedir(), '.claude');
    if (!fs.existsSync(claudeDir)) {
        console.log('⚠️  Claude Code directory not found at ~/.claude');
        console.log('   Please make sure Claude Code is installed first.');
        return false;
    }
    return true;
}

async function installPowerUps() {
    console.log(banner);
    
    try {
        // Use Node.js installer for cross-platform compatibility
        const nodeInstaller = require('./lib/installer');
        await nodeInstaller.install();
        
    } catch (error) {
        console.log('⚠️ Node.js installer failed, trying shell script fallback...\n');
        
        // Fallback to shell script for compatibility
        try {
            if (!checkClaudeDir()) {
                process.exit(1);
            }
            
            const packageDir = __dirname;
            const installScript = path.join(packageDir, 'install.sh');
            
            if (!fs.existsSync(installScript)) {
                console.error('❌ No installation method available');
                process.exit(1);
            }
            
            // Make install script executable and run it
            execSync(`chmod +x "${installScript}"`, { stdio: 'inherit' });
            execSync(`cd "${packageDir}" && ./install.sh`, { stdio: 'inherit' });
            
            console.log('\n🎉 Mario Bros PowerUps installed successfully! (via shell script)');
            
        } catch (shellError) {
            console.error('❌ Both Node.js and shell installation failed');
            console.error('Node.js error:', error.message);
            console.error('Shell error:', shellError.message);
            process.exit(1);
        }
    }
}

async function uninstallPowerUps() {
    console.log('🗑️ Uninstalling Mario Bros PowerUps...\n');
    
    try {
        // Use Node.js installer for cross-platform compatibility
        const nodeInstaller = require('./lib/installer');
        await nodeInstaller.uninstall();
        
    } catch (error) {
        console.log('⚠️ Node.js uninstaller failed, trying shell script fallback...\n');
        
        // Fallback to shell script for compatibility
        try {
            const packageDir = __dirname;
            const uninstallScript = path.join(packageDir, 'uninstall.sh');
            
            if (!fs.existsSync(uninstallScript)) {
                console.error('❌ No uninstallation method available');
                process.exit(1);
            }
            
            // Make uninstall script executable and run it
            execSync(`chmod +x "${uninstallScript}"`, { stdio: 'inherit' });
            execSync(`cd "${packageDir}" && ./uninstall.sh`, { stdio: 'inherit' });
            
        } catch (shellError) {
            console.error('❌ Both Node.js and shell uninstallation failed');
            console.error('Node.js error:', error.message);
            console.error('Shell error:', shellError.message);
            process.exit(1);
        }
    }
}

function checkStatus() {
    console.log('🍄 Mario Bros PowerUps Status Check\n');
    
    const claudeDir = path.join(os.homedir(), '.claude');
    
    if (!fs.existsSync(claudeDir)) {
        console.log('❌ Claude Code not found');
        console.log('   Please install Claude Code first');
        return;
    }
    
    console.log('✅ Claude Code found');
    
    // Check for new structure components
    const agentsDir = path.join(claudeDir, 'agents');
    const commandsDir = path.join(claudeDir, 'commands');
    const hooksDir = path.join(claudeDir, 'hooks');
    
    let componentsFound = 0;
    
    // Check subagents
    if (fs.existsSync(agentsDir)) {
        const marioAgents = fs.readdirSync(agentsDir).filter(f => 
            f.includes('mario') || f.includes('luigi') || f.includes('peach') ||
            f.includes('bowser') || f.includes('rosalina') || f.includes('toadette')
        );
        if (marioAgents.length > 0) {
            console.log(`✅ Subagents: ${marioAgents.length} Mario character subagents`);
            componentsFound++;
        }
    }
    
    // Check slash commands
    if (fs.existsSync(commandsDir)) {
        const marioCommands = fs.readdirSync(commandsDir).filter(f => f.includes('mario'));
        if (marioCommands.length > 0) {
            console.log(`✅ Commands: ${marioCommands.length} Mario slash commands`);
            componentsFound++;
        }
    }
    
    // Check hooks
    if (fs.existsSync(hooksDir)) {
        const marioHooks = fs.readdirSync(hooksDir).filter(f => f.includes('mario') || f.includes('coin'));
        if (marioHooks.length > 0) {
            console.log(`✅ Hooks: ${marioHooks.length} Mario development hooks`);
            componentsFound++;
        }
    }
    
    // Check legacy components
    const powerupsDir = path.join(claudeDir, 'powerups');
    const orchestraDir = path.join(claudeDir, 'orchestra');
    
    if (fs.existsSync(powerupsDir)) {
        console.log('✅ Legacy PowerUps directory found');
        componentsFound++;
    }
    
    if (fs.existsSync(orchestraDir)) {
        console.log('✅ Orchestra system found');
        componentsFound++;
    }
    
    // Check documentation
    const docFiles = fs.existsSync(claudeDir) ? 
        fs.readdirSync(claudeDir).filter(f => f.startsWith('MARIO_')).length : 0;
    if (docFiles > 0) {
        console.log(`✅ Documentation: ${docFiles} files installed`);
        componentsFound++;
    }
    
    if (componentsFound === 0) {
        console.log('\n❌ Mario PowerUps not installed');
        console.log('   Run: powerup install');
    } else {
        console.log(`\n🎮 Mario PowerUps: ${componentsFound} components installed`);
        console.log('\n🚀 Quick Start:');
        console.log('   /mario-status     - Check Mario system status');
        console.log('   /mario:cot "task" - Use Chain of Thought reasoning');
        console.log('   Use mario-hero subagent for full-stack development');
        console.log('   Use luigi-debugger subagent for debugging tasks');
    }
}

// Main CLI logic
const args = process.argv.slice(2);
const command = args[0];

switch (command) {
    case 'install':
        installPowerUps();
        break;
    case 'uninstall':
        uninstallPowerUps();
        break;
    case 'status':
        checkStatus();
        break;
    case 'version':
        showVersion();
        break;
    case 'help':
    case '--help':
    case '-h':
        showHelp();
        break;
    default:
        if (!command) {
            showHelp();
        } else {
            console.log(`❌ Unknown command: ${command}`);
            console.log('Run "powerup help" for available commands.');
            process.exit(1);
        }
}