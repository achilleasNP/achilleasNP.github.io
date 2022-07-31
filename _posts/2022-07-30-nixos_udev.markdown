---
layout: post
title:  "Udev rules in NixOS"
date:   2022-07-30 12:26:24+02:00
categories: udev nixos
---

Last week, I finally took the time to set up my computer such that it extends 
my screen when I plug in my external monitor and sets the external display as 
the primary and switches back to the previous setting when I unplug.

I decided to use udev for this. I have had some experience with udev rules on 
other systems, but this is the first time I am using them on nixos. 
I used the [nixos.org options search](https://search.nixos.org/options)
which I find easier to use than the searching the options appendix in the manual.
Few keystrokes later, I found that I needed: `services.udev.extraRules`

I added the following in my configuration.nix where desktop.sh contains the 
xrandr command I needed.

```{nix}
 services.udev.extraRules = 
   "SUBSYSTEM==\"drm\", ACTION==\"change\", ATTR{status}==\"connected\",  ENV{DISPLAY}=\":0\", ENV{XAUTHORITY}=\"/home/anp4r/.Xauthority\",RUN+=\"/home/anp4r/.screenlayout/desktop.sh\"";;

```

However, `nixos-rebuild` was unhappy.

```
Checking that all programs called by absolute paths in udev rules exist... FAIL
/home/anp4r/.screenlayout/desktop.sh is called in udev rules but is not executable or does not exist
error: builder for '/nix/store/02bc4hsvsj9j7ppymfg91nih2x820hv3-udev-rules.drv' failed with exit code 1
```


I found that strange; according to the `file` command, I did have an executable.
```
$ file /home/anp4r/.screenlayout/desktop.sh 
/home/anp4r/.screenlayout/desktop.sh: POSIX shell script, ASCII text executable
```

Ok, maybe executables for udev are only looked up in the derivation and not the system.
Let's just replace the script with the xrandr command.
```
 services.udev.extraRules = 
   "SUBSYSTEM==\"drm\", ACTION==\"change\", ATTR{status}==\"connected\",  ENV{DISPLAY}=\":0\", ENV{XAUTHORITY}=\"/home/anp4r/.Xauthority\",RUN+=\"xrandr --output eDP-1 --mode 1920x1080 --pos 2560x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal \"";
```

At least, now the error has changed but it's still an error.
```
xrandr is called in udev rules but not installed by udev
error: builder for '/nix/store/ryiysp9fy019wa92pvffy0vdispaahh0-udev-rules.drv' failed with exit code 1
```

Since xrandr was not installed by udev maybe we can just refer to it by an
absolute path. So let's try:
```
 services.udev.extraRules = 
   "SUBSYSTEM==\"drm\", ACTION==\"change\", ATTR{status}==\"connected\",  ENV{DISPLAY}=\":0\", ENV{XAUTHORITY}=\"/home/anp4r/.Xauthority\",RUN+=\"/run/current-system/sw/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 2560x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal \"";
```
Not there yet. Let's take a look at the 
code [nixos/modules/services/hardware/udev.nix](https://github.com/NixOS/nixpkgs/blob/nixos-22.05/nixos/modules/services/hardware/udev.nix). 

We can see on line 111 that the check for executables is basically using `-x filepath `
which is false for symlinks. Now we know that we should not use the symbolic link to
the executable, but the absolute path to the executable itself. In this case, 
this is `${pkgs.xorg.xrand}/bin/xrandr`. So our code is:
```
 services.udev.extraRules = 
   "SUBSYSTEM==\"drm\", ACTION==\"change\", ATTR{status}==\"connected\",  ENV{DISPLAY}=\":0\", ENV{XAUTHORITY}=\"/home/anp4r/.Xauthority\",RUN+=\"${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 2560x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output HDMI-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal \"";
```

This produced a valid generation, but it didn't quite do what I wanted.
On the upside though, I had most of the elements I needed. 

At the end, I used an overlay and the writeShellApplication builder to write 
a script that does the toggling between the two modes and calling it by the 
same udev rule. I hope someone finds this useful.
