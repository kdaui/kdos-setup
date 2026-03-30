# KDOS Branding

Custom Fedora branding that renames your distribution to "KDOS 43 (Based on Fedora)".

## What it does

- Customizes `/etc/os-release` and `/etc/fedora-release` with KDOS branding
- Creates a dnf wrapper that automatically restores branding after system updates

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/kdos-setup/main/setup.sh | bash
```

After running, restart your terminal or run `source ~/.bashrc`, then execute `fastfetch` to see the result.

## Uninstall

```bash
rm -f ~/.config/kdos/restore-branding.sh ~/.local/bin/dnf
```

Then restore original Fedora branding:
```bash
sudo dnf distro-sync --refresh
```
