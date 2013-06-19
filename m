From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 19 Jun 2013 16:18:51 +0300
Subject: [PATCHv2 00/11] ARM: OMAP4 clock data conversion to DT
Message-ID: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set converts the OMAP4 clock data to device tree format.
This set also fixes a couple of problems detected in the basic clock
devicetree code (patches 2 & 3), and adds some generic support functions
for the transition phase when all the drivers are not fully devicetree
compliant (see patches 1 & 7.) OMAP4 clock data was converted from
cclock44xx_data.c file with a custom perl script, which can probably
be applied for other SoCs with some modifications also.

Version one for this work was done by Mike Turquette:
   http://comments.gmane.org/gmane.linux.ports.arm.omap/98741

This set needs the basic devicetree support code from Mike:
   http://comments.gmane.org/gmane.linux.kernel/1509300

Testing done with omap4-panda board, booted up to console and tested
that suspend / resume works with 3.10-rc6.

I have also provided a working branch here:
   git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
   branch:  mainline-3.10-rc6-omap4-dt-clks-v2

This branch contains the pre-req set from Mike, and a couple of additional
hacks you can ignore.

Any comments / testing feedback welcome.

-Tero
