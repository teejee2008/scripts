#!/bin/bash

cd "$(mktemp -d)"

echo ""
echo "Install git..."
echo ""
sudo apt install refind git tree

echo ""
echo "Download theme files..."
echo ""
git clone --depth 1 https://github.com/bobafetthotmail/refind-theme-regular.git || exit 1
echo "OK"

echo ""
echo "Install theme files..."
echo ""
sudo rm -rf /boot/efi/EFI/refind/{regular-theme,refind-theme-regular}
sudo cp -r refind-theme-regular /boot/efi/EFI/refind/

echo ""
echo "Apply theme..."
echo ""
conf="/boot/efi/EFI/refind/refind.conf"
if ! sudo grep -q 'include refind-theme-regular/theme.conf' "$conf" ; then
echo "include refind-theme-regular/theme.conf" | sudo tee -a "$conf"
fi
