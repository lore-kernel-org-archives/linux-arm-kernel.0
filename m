From: balajitk@ti.com (Balaji T K)
Date: Thu, 29 Sep 2011 20:14:58 +0530
Subject: [PATCH 0/2] arm: omap4: hsmmc: pbias fixes
Message-ID: <1317307500-5514-1-git-send-email-balajitk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMC1 pbias and speed control fix for SDMMC1 extended I/O cell

Balaji T K (2):
  arm: omap4: hsmmc: Fix Pbias configuration on regulator OFF
  arm: omap4: hsmmc: configure SDMMC1_DR0 properly

 arch/arm/mach-omap2/hsmmc.c |   16 +++-------------
 1 files changed, 3 insertions(+), 13 deletions(-)
