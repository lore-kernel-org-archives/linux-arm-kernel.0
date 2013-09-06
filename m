From: olof@lixom.net (Olof Johansson)
Date: Fri,  6 Sep 2013 12:10:00 -0700
Subject: [GIT PULL 0/5] ARM: SoC updates for 3.12
Message-ID: <1378494605-14990-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's the first batch of arm-soc branches for 3.12. Besides this we
have two "regular" and one small branch that we'll send in a second set.

Nothing controversial, just more of the same as the last several releases:
- More conversions over to device-tree
- More removal of board code (and a bit of addition)
- More SoCs supported:
  - Allwinner A20/A31
  - TI DRA7
- Power management code for cpu and cluster power management on VExpress
- Power management code for low-power CPU states on Tegra

There's also some cleanups, removal of ARM local timer API, removal of
unused OMAP headers and other goodies.

A few conflicts, nothing too hard to deal with. They're documented in
each pull email.

I've pushed a "test-merge" branch to the same repo with my resolutions
to them in case you want to compare.


Thanks!

-Olof
