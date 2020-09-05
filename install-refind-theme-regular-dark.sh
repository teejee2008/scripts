#!/bin/bash

cd "$(mktemp -d)"

echo "Install git..."
sudo apt install refind git tree

echo "Download theme files..."
git clone --depth 1 https://github.com/bobafetthotmail/refind-theme-regular.git || exit 1
echo "OK"

echo "Install theme files..."
sudo rm -rf /boot/efi/EFI/refind/{regular-theme,refind-theme-regular}
sudo cp -r refind-theme-regular /boot/efi/EFI/refind/

conf="/boot/efi/EFI/refind/refind.conf"
if ! [ grep -q 'include refind-theme-regular/theme.conf' "$conf" ]; then
echo "include refind-theme-regular/theme.conf" | sudo tee -a "$conf"
fi
