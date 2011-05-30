From: balajitk@ti.com (Balaji T K)
Date: Mon, 30 May 2011 19:55:32 +0530
Subject: [PATCH 0/2] ARM: OMAP4: fix MMC failure due to regulator
	enable/disable ops
Message-ID: <1306765534-20103-1-git-send-email-balajitk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Balaji T K (2):
  ARM: OMAP4: MMC: increase delay for pbias
  ARM: OMAP4: MMC: no regulator off during probe for eMMC

 arch/arm/mach-omap2/board-4430sdp.c   |    1 +
 arch/arm/mach-omap2/hsmmc.c           |   16 +++++++++++++---
 arch/arm/mach-omap2/hsmmc.h           |    1 +
 arch/arm/plat-omap/include/plat/mmc.h |    3 +++
 drivers/mmc/host/omap_hsmmc.c         |    3 +++
 5 files changed, 21 insertions(+), 3 deletions(-)
