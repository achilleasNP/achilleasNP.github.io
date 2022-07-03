---
layout: post
title:  "Galaxy Book Pro and NixOS"
date:   2022-06-17 12:01:09 +0200
categories: gbook linux
---

Last year, I was itching to upgrade my laptop. The requirements were a good 
screen $$\geq 15''$$ and a great battery life (I have been spoiled rotten from my chromebooks). 

I usually go for the standard business lines from Lenovo and Dell (Thinkpad, Lattitude, Precision, e.t.c).
I have had a pleasant experience running Linux on such systems and I was often 
able to order them without Windows. The bussiness lines laptops tend to be easy 
to work on when things go wrong with good part availability (at least in the US).

As a longtime Linux user, I have learned that sticking with older technology 
( a year or two older than the latest and greatest ) tends to provide fairly 
smooth sailing in Linux land.

However, Samsung was running a crazy sale on the Galaxy Book Pro (NP950XDB-KB2US).
The Galaxy book ticked a lot of the boxes. It has a good 15" OLED screen that can
be used outdoors, great battery life, and is thin and light (good to have but 
not a big deal for my use case). The drawback was an 8GB soldered memory, I was 
mainly bothered by the idea that I couldn't upgrade it if I wanted to, but I was
fully aware that it wouldn't be a problem with my setup. I threw caution in the
wind and ended up with a Galaxy book pro.

This thing is light, the screen is great and the battery life is good. The
touchpad drives me nuts at times, it seems it can be engaged when your rest
your wrist on the computer when you are typing or when you hold it from the corner.
The disable while typing option makes the experience bearable.However, I couldn't
live with it without a short cut for disabling the trackpad.

Trying to get a distribution working on it reminded me why I usually stick with
older hardware. After multiple attempts, I gave up trying to install debian which 
is my go to distro. I ended up using Manjaro the sway edition (which I used
previously with my pinebook pro). I found the defaults of the Manjaro sway gave
a pleasant user experience, so much so, that I considered switching from xmonad
on my other systems. I would have kept it, if I hadn't decided to complicate my
life again and try NixOS one more time.

I have started with NixOS version 21.11, but the kernel didn't support my wireless interface.
After a bit of searching around, I found that you can get NixOS image with the latest linuxPackages_latest from
Hydra as discussed here <https://discourse.nixos.org/t/how-to-get-a-nixos-image-with-newer-kernel/17334>.
The image with the newer kernel did the trick and started me on my NixOS journey.
