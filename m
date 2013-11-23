From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:41:11 -0500
Subject: [PATCH 0/5] ARM: keystone: Misc updates
Message-ID: <1385250076-9596-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series contains few updates like enabling DMA zone, clock init
ordering fix and maintainers file updates.

Santosh Shilimkar (5):
  ARM: keystone: enable DMA zone for LPAE
  ARM: keystone: Make PM bus ready before populating platform devices
  ARM: keystone: Avoid calling of_clk_init() twice
  MAINTAINERS: Add keystone git tree information
  MAINTAINERS: Add keystone clock drivers

 MAINTAINERS                        |    2 ++
 arch/arm/mach-keystone/Kconfig     |    1 +
 arch/arm/mach-keystone/keystone.c  |    4 ++++
 arch/arm/mach-keystone/keystone.h  |    1 +
 arch/arm/mach-keystone/pm_domain.c |    2 --
 5 files changed, 8 insertions(+), 2 deletions(-)

-- 
1.7.9.5
