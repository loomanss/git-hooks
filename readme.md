## git-hooks
git hooks for developing on unix like systems

### pre-commit
For documentation on pre-commit, visit the [website](https://pre-commit.com/).

### Dependencies
- shellcheck
- uncrustify

### Quick Start
Copy `example.pre-commit-config.yaml` from this repo to the new project, edit as necessary, then follow standard pre-commit practices. Additional pre-commit hooks can be found [here](https://pre-commit.com/hooks.html).

*Note: The example file has all hooks in this repo enabled, make sure to disable hooks that are not required.*

### Supported Hooks

- `pretty-c` - Make C source pretty
- `pretty-shell` - Make shell scripts pretty
- `tab-fixer` - Replace all tabs with spaces
- `windows-encoding-fixer` - Replace Windows encoded files with UTF-8 encoded files

### Configuration

#### pretty-c

`pretty-c` uses [`uncrustify`](http://uncrustify.sourceforge.net/) at its core. In order to use the `pretty-c` hook, create a file called `.uncrustify` in the root of the project directory and fill it with the desired uncrustify configuration.
