#!/bin/bash
# ft_linux pre-check script

echo "=== ft_linux Pre-Check ==="

STUDENT_LOGIN=$(whoami)
KERNEL_VERSION=$(uname -r)

echo "1️⃣ Kernel Checks"
echo "- Kernel version: $KERNEL_VERSION"
[ $(echo $KERNEL_VERSION | grep -c "4\..*-$STUDENT_LOGIN") -eq 1 ] && echo "[OK] Kernel version includes login" || echo "[FAIL] Kernel version missing login"
[ -d "/usr/src/kernel-$KERNEL_VERSION" ] && echo "[OK] Kernel source directory exists" || echo "[FAIL] Kernel source missing"
[ -f "/boot/vmlinuz-$KERNEL_VERSION" ] && echo "[OK] Kernel binary exists" || echo "[FAIL] Kernel binary missing"
echo "- Hostname: $(hostname)"
[ "$(hostname)" = "$STUDENT_LOGIN" ] && echo "[OK] Hostname correct" || echo "[FAIL] Hostname incorrect"

echo "2️⃣ Partitions"
[ $(swapon --show | wc -l) -ge 1 ] && echo "[OK] Swap partition exists" || echo "[WARN] Swap partition missing"
[ -d "/boot" ] && [ -d "/" ] && echo "[OK] /boot and / exist" || echo "[FAIL] /boot or / missing"

echo "3️⃣ udev Checks"
if command -v udevadm &>/dev/null; then
    echo "[OK] udev installed, version: $(udevadm --version)"
else
    echo "[FAIL] udev not installed"
fi
if systemctl list-units --type=service | grep -q systemd-udevd; then
    echo "[OK] udev service running"
else
    echo "[WARN] udev service not running"
fi

echo "5️⃣ Network Check"
ping -c1 8.8.8.8 &>/dev/null && echo "[OK] Internet reachable" || echo "[WARN] Cannot reach internet"

echo "6️⃣ Checksum Verification"
echo "current checksum: $(cat CHECKSUM 2>/dev/null || echo 'N/A')"
