From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 2 Aug 2013 19:25:19 +0300
Subject: [PATCHv5 00/31] CLK: OMAP conversion to DT
Message-ID: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set mainly fixes comments received from Nishanth Menon for v4.
AM43xx + AM35xx clock data was added as new feature, also OMAP3
platforms use either the old style kernel clock data or DT data,
based on boot type.

Testing done:

omap3 beagle : boot, suspend / resume
omap4 panda es: boot, suspend / resume
omap5 sevm: boot
am335x bone: boot

Branch available here:
git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
branch: mainline-3.11-rc3-omap-dt-clks-v5

-Tero
