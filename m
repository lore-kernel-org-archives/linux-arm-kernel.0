From: rogerq@ti.com (Roger Quadros)
Date: Mon, 18 Mar 2013 14:51:14 +0200
Subject: [PATCH v3 0/4] ARM: OMAP2+: Adapt to ehci-omap changes for 3.10
Message-ID: <1363611078-13002-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

I've revised the patches based on your comments. For now I've just
adapted Panda and Beagleboard.
If this looks OK then I can adapt the other boards as well.

cheers,
-roger

Roger Quadros (4):
  usb: phy: nop: Add some parameters to platform data
  ARM: OMAP2+: omap-usb-host: Add usbhs_init_phys()
  ARM: OMAP2+: omap4panda: Adapt to ehci-omap changes
  ARM: OMAP3: Beagle: Adapt to ehci-omap changes

 arch/arm/mach-omap2/board-omap3beagle.c |   32 ++++--
 arch/arm/mach-omap2/board-omap4panda.c  |   55 ++++------
 arch/arm/mach-omap2/usb-host.c          |  177 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/usb.h               |    9 ++
 include/linux/usb/nop-usb-xceiv.h       |    5 +
 5 files changed, 232 insertions(+), 46 deletions(-)

-- 
1.7.4.1
