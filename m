From: saeed@marvell.com (Saeed Bishara)
Date: Sun,  2 May 2010 17:22:37 +0300
Subject: [PATCH 0/5] USB: orion ehci patches for 2.6.35 
Message-ID: <1272810162-14858-1-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Saeed Bishara (5):
      USB: add support for phy init for the Dove SoC
      ARM: use the Dove USB phy setup
      USB: add clk structure for systems that support clkdev framework
      USB: manage the orion ehci clock using the clkdev
      USB: add power management support for orion ehci

 arch/arm/mach-dove/common.c                   |    2
 arch/arm/plat-orion/include/plat/ehci-orion.h |    1
 drivers/usb/core/hcd.h                        |    4
 drivers/usb/host/ehci-orion.c                 |  139 ++++++++++++++++++++----
 drivers/usb/host/ehci-orion.c                   |  108 ++++++++++++++++++
 5 files changed, 233 insertions(+), 21 deletions(-)
