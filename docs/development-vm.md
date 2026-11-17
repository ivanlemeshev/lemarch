# Development VM

Run all Linux commands inside the VM.

## 1. Create the VM

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) on Windows.
2. Download the official [Arch Linux x86-64 ISO](https://archlinux.org/download/).
3. Create a VM named `lemarch-dev`.
4. Select the Arch ISO.
5. Disable unattended installation.
6. Apply these settings:

| Setting         | Value                            |
| --------------- | -------------------------------- |
| OS              | Arch Linux, 64-bit               |
| CPU             | 4 virtual cores                  |
| RAM             | 8 GB                             |
| Disk            | 64 GB, dynamically allocated VDI |
| Firmware        | UEFI                             |
| Secure Boot     | Disabled in the VM               |
| Network         | NAT                              |
| Graphics        | VMSVGA                           |
| Video memory    | 128 MB                           |
| 3D acceleration | Enabled                          |

## 2. Install Arch Linux

1. Start the VM.
2. Select the normal Arch Linux installation entry.
3. At the terminal prompt, run:

   ```bash
   archinstall
   ```

4. Use these installer settings:

   | Setting        | Value                               |
   | -------------- | ----------------------------------- |
   | Disk layout    | Best-effort default layout          |
   | Target disk    | The 64 GB VirtualBox disk           |
   | Filesystem     | ext4                                |
   | Separate /home | No                                  |
   | Encryption     | None                                |
   | Bootloader     | systemd-boot                        |
   | Hostname       | `lemarch-dev`                       |
   | User           | Your username, with sudo permission |
   | Profile        | Minimal                             |
   | Kernel         | linux                               |
   | Network        | NetworkManager                      |
   | Timezone       | Your local timezone                 |

   The installer erases the selected virtual disk.

5. Select **Install**.
6. When the installer asks to enter a chroot, select **No**.
7. Shut down with `poweroff`.
8. Remove the ISO from the virtual optical drive in **Settings → Storage**.
9. Start the VM.
10. Log in with your new user account.

## 3. Install the desktop packages

Run:

```bash
sudo pacman -Syu hyprland kitty mesa vim ttf-dejavu \
  xdg-desktop-portal-hyprland virtualbox-guest-utils
sudo systemctl enable --now vboxservice.service
sudo reboot
```

## 4. Set the Kitty command

1. Log in after the reboot.
2. Start Hyprland to create its configuration:

   ```bash
   start-hyprland
   ```

3. Press **Super+M** to exit Hyprland.
4. Open the configuration:

   ```bash
   vim ~/.config/hypr/hyprland.lua
   ```

5. Find the `local terminal` line.
6. Set the command to:

   ```lua
   local terminal = "env LIBGL_ALWAYS_SOFTWARE=true kitty"
   ```

7. Save the file and exit vim.

This setting uses software rendering for Kitty in the VM. The Super key is the Windows key.

## 5. Check the desktop

1. Run `start-hyprland`.
2. Press **Super+Q**.
3. Make sure that Kitty stays open.
4. Run `nmcli general status` in Kitty.
5. Make sure that NetworkManager shows a network connection.

Press **Right Ctrl** to release the keyboard and mouse to Windows.

## 6. Save a VM snapshot

1. Shut down the VM with `sudo poweroff`.
2. Select the VM in VirtualBox.
3. Open **Snapshots → Take**.
4. Name the snapshot `hyprland-working`.
