From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Thu, 31 Jan 2013 19:55:25 +0530
Subject: [Patch v2 0/2] ARM: OMAP2+: AM33xx: fix hwmod & Clock Control Module
Message-ID: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Add add missing HWMOD_NO_IDLEST flags
2. Fix "register offset NULL check" bug

Changes in v2:
	- As per Paul's suggestion 1st add HWMOD_NO_IDLEST flag where
	  it is necessary and then correct the clock control register
	  offset check bug.

Hebbar Gururaja (2):
  ARM: OMAP2+: AM33xx: hwmod: add missing HWMOD_NO_IDLEST flags
  ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check" bug

 arch/arm/mach-omap2/cm33xx.c               |    3 ---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

-- 
1.7.9.5
