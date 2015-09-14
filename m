From: s-anna@ti.com (Suman Anna)
Date: Mon, 14 Sep 2015 15:49:19 -0500
Subject: [PATCH 0/2] OMAP hwspinlock hwmod cleanup
Message-ID: <1442263761-16757-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Following are couple of hwmod cleanup patches for HwSpinlock IP. 
Patches based on 4.3-rc1. The legacy platform device instantiation 
logic has been cleaned up in 4.2 kernel when DT-support was added
to the OMAP HwSpinlock driver.

regards
Suman

Suman Anna (2):
  ARM: OMAP4: hwmod data: Remove spinlock hwmod addrs
  ARM: DRA7: hwmod data: Remove spinlock hwmod addrs

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 ----------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 10 ----------
 2 files changed, 20 deletions(-)

-- 
2.5.0
