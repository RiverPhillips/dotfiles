# Target directory for symlinks
target := home_directory()

# Show available recipes (default when you just run `just`)
default:
    @just --list

# Preview what stow would link, without making changes
dry-run:
    stow -nv -t {{target}} */

# Create the symlinks
install:
    stow -v -t {{target}} */

# Remove the symlinks stow created
uninstall:
    stow -Dv -t {{target}} */

# Re-link everything (useful after adding or moving files)
restow:
    stow -Rv -t {{target}} */
