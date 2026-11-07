# Target directory for symlinks
target := home_directory()

# Show available recipes (default when you just run `just`)
default:
    @just --list

# Preview what stow would link, without making changes
dry-run:
    stow -nv --dotfiles -t {{target}} */

# Create the symlinks
install: submodules
    stow -v --dotfiles -t {{target}} */

# Remove the symlinks stow created
uninstall:
    stow -Dv --dotfiles -t {{target}} */

# Re-link everything (useful after adding or moving files)
restow: submodules
    stow -Rv --dotfiles -t {{target}} */

# Fetch/update git submodules (e.g. tpm)
submodules:
    git submodule update --init --recursive
