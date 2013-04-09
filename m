From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 10 Apr 2013 02:47:21 +0400
Subject: [PATCH 0/4] Add USB support to R8A7778/BOCK-W
Message-ID: <201304100247.22615.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 4 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130410' tag.  It was created to add support of R8A7778/BOCK-W
USB to the platform code and the USB common PHY driver, and so spans both
arch/arm/mach-shmobile/ and drivers/usb/phy/ subtrees.

[1/4] rcar-phy: add R8A7778 support
[2/4] ARM: shmobile: R8A7778: add USB support
[3/4] ARM: shmobile: BOCK-W: add USB support
[4/4] ARM: shmobile: BOCK-W: enable USB in defconfig

   I'm not sure thru which tree this patchset should be merged, however it turns
out that it's too late now to push it thru Felipe Balbi's USB tree for 3.10
(which would have been most convenient probably), and it's probably too late to
merge thru Simon's tree for 3.10 too. So it now have to be postponed to 3.11,
unfortunately...

WBR, Sergei
