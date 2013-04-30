From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 1 May 2013 03:09:07 +0400
Subject: [PATCH v6 0/3] Add USB support to R8A7778/BOCK-W
Message-ID: <201305010309.07744.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130426' tag and the R8A7779/Marzen patchset I've posted.
 It was created to add support of R8A7778/BOCK-W USB to the platform code and
the USB common PHY driver, and so spans both arch/arm/mach-shmobile/ and
drivers/usb/phy/ subtrees.

[1/3] rcar-phy: add R8A7778 support
[2/3] ARM: shmobile: r8a7778: add USB support
[3/3] ARM: shmobile: BOCK-W: add USB support

The patch #4 (ARM: shmobile: BOCK-W: enable USB in defconfig) that has been
already merged, is not reposted.

WBR, Sergei
