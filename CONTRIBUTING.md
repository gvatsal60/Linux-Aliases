# Contributing to Linux-Aliases

Thank you for your interest in contributing to Linux-Aliases!
Please follow these guidelines to ensure a smooth process.

## How to Contribute

1. Fork the repository and create your branch from `master`.
2. Open an issue or feature request on GitHub or pick an existing one.
3. Work on your changes.
4. Ensure your code follows our coding standards and conventions.
5. Test your changes thoroughly.
6. Submit a pull request referencing the original issue.

## Code Style

### General Guidelines

- **Indentation**: Use 4 spaces for indentation in all code files. Avoid using tabs.
- **Line Length**: Limit lines to improve readability.
- **Naming Conventions**: Use meaningful variable and function names. Variables should be written in lowercase with underscores separating words (e.g., `my_variable`), while function names should use lowercase with underscores (e.g., `my_function`).

### Bash Scripts

- **Indentation**: Use 4 spaces for indentation. Ensure consistent indentation throughout the script.
- **POSIX Compliance**: Write scripts to be POSIX-compliant whenever possible to ensure compatibility across different Unix-like systems. Avoid using non-standard features or extensions specific to a particular shell.
- **Quoting**: Always quote variable expansions (e.g., `"${variable}"`) to prevent issues with spaces or special characters.
- **Shebang**: Use `#!/bin/sh` for POSIX-compliant scripts. If specific shell features are needed, document the specific shell requirement in the script header.
- **Function Definitions**: Define functions without `function` keyword (e.g., `my_function() { ... }`). Consistency is key.
- **Comments**: Use comments to explain complex logic or provide context. Keep comments concise and relevant.
- **Error Handling**: Include error handling for critical operations.
- **External Commands**: Prefer using built-in commands and utilities when possible. Minimize the use of external commands to improve script portability and performance.

## Reporting Bugs

Please report bugs using the GitHub issue tracker. Include steps to reproduce the bug and
any relevant error messages.

## Contact

If you have questions or need further assistance, feel free to contact us at [Telegram](https://t.me/gvatsal60).
