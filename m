From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 20 Dec 2010 16:48:53 +0100
Subject: [patch 0/5] iMX51 usb fixes
Message-ID: <20101220154853.254931637@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



This patchset aims at fixing several issues I found in the usb support for
iMX51 while working on the Genesis EFIKAMX/EFIKASB systems. The most
"annoying" one is the usb clock patch. I found out that when the clocks are
not properly enabled my system just hangs when trying to read a usb register.
So far, I guess only luck (or different bootloader behaviour) may explain that
nobody got hit by this.

Warning:
It has been tested on both devices against Sascha's imx-for-2.6.38 branch.
It's possible that some of them apply against current mainline but I can't
test such a configuration.

Arnaud
