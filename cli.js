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

function installPowerUps() {
    console.log(banner);
    console.log('🍄 Installing Mario Bros PowerUps...\n');
    
    if (!checkClaudeDir()) {
        process.exit(1);
    }
    
    try {
        // Get the directory where this npm package is installed
        const packageDir = __dirname;
        const installScript = path.join(packageDir, 'install.sh');
        
        if (!fs.existsSync(installScript)) {
            console.error('❌ Installation script not found');
            process.exit(1);
        }
        
        // Make install script executable and run it
        execSync(`chmod +x "${installScript}"`, { stdio: 'inherit' });
        execSync(`cd "${packageDir}" && ./install.sh`, { stdio: 'inherit' });
        
        console.log('\n🎉 Mario Bros PowerUps installed successfully!');
        console.log('\n🎮 Try your first command:');
        console.log('   /mario-status');
        console.log('\n📚 View all commands:');
        console.log('   Open your Claude Code and type /mario- then press Tab');
        
    } catch (error) {
        console.error('❌ Installation failed:', error.message);
        process.exit(1);
    }
}

function uninstallPowerUps() {
    console.log('🗑️  Uninstalling Mario Bros PowerUps...\n');
    
    try {
        const packageDir = __dirname;
        const uninstallScript = path.join(packageDir, 'uninstall.sh');
        
        if (!fs.existsSync(uninstallScript)) {
            console.error('❌ Uninstall script not found');
            process.exit(1);
        }
        
        // Make uninstall script executable and run it
        execSync(`chmod +x "${uninstallScript}"`, { stdio: 'inherit' });
        execSync(`cd "${packageDir}" && ./uninstall.sh`, { stdio: 'inherit' });
        
    } catch (error) {
        console.error('❌ Uninstallation failed:', error.message);
        process.exit(1);
    }
}

function checkStatus() {
    console.log('🍄 Mario Bros PowerUps Status Check\n');
    
    const claudeDir = path.join(os.homedir(), '.claude');
    const powerupsDir = path.join(claudeDir, 'powerups');
    const commandsDir = path.join(claudeDir, 'commands');
    
    if (!fs.existsSync(claudeDir)) {
        console.log('❌ Claude Code not found');
        return;
    }
    
    if (!fs.existsSync(powerupsDir)) {
        console.log('❌ PowerUps not installed');
        console.log('   Run: powerup install');
        return;
    }
    
    // Count installed components
    const characters = fs.existsSync(path.join(powerupsDir, 'characters')) ? 
        fs.readdirSync(path.join(powerupsDir, 'characters')).length : 0;
    const commands = fs.existsSync(commandsDir) ? 
        fs.readdirSync(commandsDir).filter(f => f.startsWith('mario-')).length : 0;
    
    console.log('✅ Mario Bros PowerUps Status:');
    console.log(`   📁 PowerUps Directory: ${powerupsDir}`);
    console.log(`   🎭 Characters: ${characters}`);
    console.log(`   🎮 Commands: ${commands}`);
    console.log(`   🎼 Orchestra: ${fs.existsSync(path.join(claudeDir, 'orchestra')) ? 'Installed' : 'Not found'}`);
    console.log('\n🎮 Test it: /mario-status');
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