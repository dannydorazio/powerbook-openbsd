# PowerBook OpenBSD Project Context

This repository provides tools and configurations for running OpenBSD on 32-bit PowerPC Macs (macppc).

## Project Structure

- `tools/` - Custom-built tools specific to this project
  - Each tool has its own subdirectory with a README
- `installers/` - Installation scripts for each component
  - Metadata-driven (INSTALLER_NAME, INSTALLER_DESC, INSTALLER_VERSION)
  - Automatically discovered by master installer
- `packages.txt` - List of system packages to install via pkg_add
- `install.sh` - Master installer that discovers and runs all installers

## Key Principles

1. **Modularity**: Each tool/package has its own installer script
2. **Self-Documenting**: Installers contain metadata that the master installer reads
3. **Idempotent**: Installers check if software is already installed
4. **GPG Signed**: All commits are signed with GPG key 4F42936D533D487C (PowerBook) and 2F78B03149973970 (Mac Pro)
5. **Conventional Commits**: All commit messages follow conventional commits format in lowercase

## Target Platform

- **Primary:** PowerBook G4 12" (PowerBook6,4)
- **OS:** OpenBSD 7.7 macppc (32-bit PowerPC)
- **Goal:** Make OpenBSD usable on vintage PowerPC Macs

## Adding New Components

### Custom Tool
1. Create `tools/your-tool/` directory
2. Add tool and README.md
3. Create `installers/your-tool-installer.sh` with metadata headers
4. Master installer will auto-discover it

### System Package
- Add to `packages.txt` (one per line)

## Development Notes

- WiFi interface is `bwi0` (Broadcom)
- PowerPC compilation is slow - be patient with builds
- Some tools need to be built from source (fastfetch, pyenv)
- Git config: Dan Dorazio <hello@dorazio.me>
- See CONTRIBUTING.md for commit message format and GPG signing requirements
