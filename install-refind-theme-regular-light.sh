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

refind_path=""

if sudo test -f /boot/efi/EFI/refind/refind.conf ; then
    refind_path=/boot/efi/EFI/refind
elif sudo test -f /boot/efi/EFI/BOOT/refind.conf ; then
    refind_path=/boot/efi/EFI/BOOT
else
    echo "Refind was not found on this system"
    exit 1
fi

echo "Found Refind in path: ${refind_path}"

sudo rm -rf "${refind_path}/{regular-theme,refind-theme-regular}"
sudo cp -r refind-theme-regular "${refind_path}/"

echo ""
echo "Apply theme..."
echo ""

conf="${refind_path}/refind.conf"
if ! sudo grep -q 'include refind-theme-regular/theme.conf' "$conf" ; then
    echo "include refind-theme-regular/theme.conf" | sudo tee -a "$conf" || echo "OK"
fi
