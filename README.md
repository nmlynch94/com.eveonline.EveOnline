# Disclaimer
I am in no way affiliated with CCP and running the launcher through linux is unsupported by them. Any issues should be reported here as tickets. Use at your own risk.  

# What is this?
EVE Online launcher packaged in a flatpak, configured to work with EVE-O Preview out of the box. Eve-O needs to run in the same prefix as eve, and by default proton doesn't allow two processes to run in the same prefix. This simplifies the setup to work around these issues.

# Installation 
### Dependencies
- wmctrl - This is used by eve-o to switch the focus of the windows on the host

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
