# Contributing Guidelines

## Commit Message Rules

### Format
All commits must follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>: <description>

[optional body]

[optional footer(s)]
```

### Requirements

1. **All lowercase**: Commit messages must be entirely in lowercase
2. **Conventional commits**: Must use a valid commit type prefix
3. **GPG signed**: All commits must be signed with your GPG key

### Valid Commit Types

- `feat:` - a new feature
- `fix:` - a bug fix
- `docs:` - documentation only changes
- `style:` - changes that do not affect the meaning of the code (white-space, formatting, etc)
- `refactor:` - a code change that neither fixes a bug nor adds a feature
- `perf:` - a change that improves performance
- `test:` - adding missing tests or correcting existing tests
- `build:` - changes that affect the build system or external dependencies
- `ci:` - changes to CI configuration files and scripts
- `chore:` - other changes that don't modify src or test files
- `revert:` - reverts a previous commit

### Examples

Good:
```
feat: add network scanning to wifi-manager
fix: correct path in wifi-manager installer
docs: update readme with installation instructions
refactor: simplify json parsing in wifi-manager
chore: add contributing guidelines
```

Bad:
```
Add feature          (missing type, not lowercase)
Fix: bug in script   (capital letter)
FEAT: new installer  (not lowercase)
```

### GPG Signing

Ensure your Git is configured to sign commits automatically:

```sh
git config --global commit.gpgsign true
git config --global user.signingkey YOUR_KEY_ID
```

To verify a commit is signed:
```sh
git log --show-signature -1
```

### Enforcement

- All commits pushed to the repository must follow these rules
- Pull requests with non-compliant commits will be rejected
- Use `git commit --amend` to fix the most recent commit message if needed
- For older commits, use `git rebase -i` to reword commit messages

## Adding New Tools

When adding new tools to the repository:

1. Place custom tools in `tools/<tool-name>/`
2. Create a README.md for the tool in its directory
3. Add an installer script in `installers/<tool-name>-installer.sh`
4. Include metadata headers in the installer:
   ```sh
   # INSTALLER_NAME: tool-name
   # INSTALLER_DESC: Brief description
   # INSTALLER_VERSION: 1.0
   ```
5. Update packages.txt if the tool requires system packages
6. Follow the commit message format when committing changes

## Platform Compatibility

This project targets:
- **Primary**: PowerBook G4 12" running OpenBSD 7.7 (macppc)
- **Architecture**: 32-bit PowerPC
- **Shell**: POSIX sh (ksh on OpenBSD)

When contributing:
- Test on actual PowerPC hardware when possible
- Use POSIX-compliant shell syntax
- Avoid bashisms unless bash is a documented dependency
- Note any hardware-specific requirements in documentation
