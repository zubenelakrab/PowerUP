#!/usr/bin/env node

/**
 * npm postinstall script for Mario Bros PowerUps
 * This runs automatically after npm install
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

console.log(`
🍄⭐ Mario Bros PowerUps installed via npm! ⭐🍄

To activate PowerUps in Claude Code, run:
  powerup install

Or check status:
  powerup status
`);

// Check if Claude Code is available
const claudeDir = path.join(os.homedir(), '.claude');
if (!fs.existsSync(claudeDir)) {
    console.log(`
⚠️  Claude Code not detected at ~/.claude
   Please install Claude Code first, then run: powerup install
`);
} else {
    console.log(`
✅ Claude Code detected!
   Ready to install PowerUps: powerup install
`);
}