# Disclaimer
I am in no way affiliated with CCP and running the launcher through linux is unsupported by them. Any issues should be reported here as tickets. Use at your own risk.  

# What is this?
EVE Online launcher packaged in a flatpak, configured to work with EVE-O Preview out of the box. Eve-O needs to run in the same prefix as eve, and by default proton doesn't allow two processes to run in the same prefix. This simplifies the setup to work around these issues.

# Why use this over Steam?
This project offers a couple advantages over Steam. If these are not appealing to you, then using a Steam approach will likely make more sense for you.
1. Out-of-the-box EVE-O-Preview configuration with automated updates. No need to use protontricks or rig up a wine command with steam's WinePrefix
2. The ability to reopen the launcher if it closes without needing to kill all clients first
3. SSO Support to login via Steam/Epic

# Known Issues
1. Running in GameMode on a steam deck currently does not work. It works in Desktop Mode.
2. Even if you manage to launch it in GameMode, the window switcher does not detect launched clients

# Installation 
### Dependencies
- wmctrl - This is used by eve-o to switch the focus of the windows on the host. Usually just wmctrl in the package manager.
- If on an immutable distro like bazzite, you can install via `rpm-ostree install wmctrl`

### Repo (automated updates) - This below command is the only one you need to run to get the launcher running.
- Open a terminal (konsole, etc)
- Run 
```
curl -fSsL https://raw.githubusercontent.com/nmlynch94/com.eveonline.EveOnline/refs/heads/main/install-eve-online-repo.sh | bash
```
Now, you should have an icon in your application menu for both Eve-Online and Eve-O-Preview. Make sure you always launch Eve Online first.

You can also launch them from the cli:
```
flatpak run com.eveonline.EveOnline
flatpak run --command=eve-o-run com.eveonline.EveOnline
```
