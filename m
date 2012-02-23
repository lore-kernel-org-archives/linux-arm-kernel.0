From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 23 Feb 2012 12:28:28 +0530
Subject: [PATCH 0/2] OMAP: Section mismatch warning fixes
Message-ID: <1329980310-9007-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Below are couple of section mismatch warning fixes for v3.3-rc5

Santosh Shilimkar (2):
  ARM: OMAP: fix section mismatch warning for omap4_hotplug_cpu()
  ARM: OMAP: Fix section mismatch warning for platform_cpu_die()

 arch/arm/mach-omap2/omap-hotplug.c        |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.4.1
