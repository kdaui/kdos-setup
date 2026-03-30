#!/bin/bash
# KDOS Branding Setup Script
# Run with: curl -fsSL https://raw.githubusercontent.com/kdaui/kdos-setup/master/setup.sh | bash

set -e

echo "Setting up KDOS branding..."

# Create config directory
mkdir -p ~/.config/kdos ~/.local/bin

# Create restore script
cat > ~/.config/kdos/restore-branding.sh << 'SCRIPT'
#!/bin/bash
# Restore KDOS branding after system updates

pkexec tee /etc/os-release > /dev/null << 'EOF'
NAME="KDOS"
VERSION="43 (Based on Fedora)"
RELEASE_TYPE=stable
ID=fedora
VERSION_ID=43
VERSION_CODENAME=""
PRETTY_NAME="KDOS 43 (Based on Fedora)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:43"
DEFAULT_HOSTNAME="fedora"
HOME_URL="https://fedoraproject.org/"
DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora/f43/"
SUPPORT_URL="https://ask.fedoraproject.org/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT="Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=43
REDHAT_SUPPORT_PRODUCT="Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=43
SUPPORT_END=2026-12-02
VARIANT="KDE Plasma Desktop Edition"
VARIANT_ID=kde
EOF

pkexec tee /etc/fedora-release > /dev/null << 'EOF'
KDOS 43 (Based on Fedora)
EOF
SCRIPT

chmod +x ~/.config/kdos/restore-branding.sh

# Create dnf wrapper
cat > ~/.local/bin/dnf << 'WRAPPER'
#!/bin/bash
# KDOS dnf wrapper - restores branding after updates
/usr/bin/dnf "$@"
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    bash ~/.config/kdos/restore-branding.sh 2>/dev/null || true
fi

exit $EXIT_CODE
WRAPPER

chmod +x ~/.local/bin/dnf

# Ensure ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    export PATH="$HOME/.local/bin:$PATH"
fi

# Apply branding now
bash ~/.config/kdos/restore-branding.sh

echo "KDOS branding setup complete!"
