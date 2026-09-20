# Snippets and One-liners

Located at `~/.local/share/snippets`

## Dependencies

`fd`, `ydotool`

## `ytodool` setup

### 1: Set Up Permissions for /dev/uinput

By default, ydotoold needs write access to /dev/uinput.

1. Add your user to the input group:  

```fish
sudo usermod \-aG input $USER
```

2. Create a udev rule to grant access to /dev/uinput for the input group:  

```fish
echo 'KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/80-uinput.rules
```

3. Reload udev rules:  

```fish
# modify this command for bash
sudo udevadm control \--reload-rules; and sudo udevadm trigger
```

4. Reboot for this to take effect.

### Step 2: Start the ydotool Daemon via Systemd

Instead of running sudo ydotoold manually every time, configure it as a user service:

1. Enable and start the systemd user service:  

```fish
systemctl --user enable --now ydotool.service
```

2. Check the service status to verify it is running active:  

```fish
systemctl --user status ydotool.service
```

## Snippets format in `./one_liners/one-liners.txt`

Each line begins with a description.
The delimiter is `::`.
After the delimiter write your snippet, you can use spaces before or after the snippet.

**Example:**

```plaintext
List all files including the hidden ones:: ls -a
```
