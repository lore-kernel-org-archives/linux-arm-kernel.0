From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 17 Apr 2013 01:30:59 +0400
Subject: [PATCH v3 0/4] Add USB support to R8A7778/BOCK-W
Message-ID: <201304170131.00238.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 4 patches against the Simon Horman's 'renesas.git' repo,
'renesas-next-20130416' tag and the R8A7779/Marzen patchset I've posted.
 It was created to add support of R8A7778/BOCK-W USB to the platform code and
the USB common PHY driver, and so spans both arch/arm/mach-shmobile/ and
drivers/usb/phy/ subtrees.

[1/4] rcar-phy: add R8A7778 support
[2/4] ARM: shmobile: r8a7778: add USB support
[3/4] ARM: shmobile: BOCK-W: add USB support
[4/4] ARM: shmobile: BOCK-W: enable USB in defconfig

WBR, Sergei
