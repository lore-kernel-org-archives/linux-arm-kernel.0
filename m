From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 13 Nov 2012 16:02:18 -0600
Subject: [PATCH 0/2] ARM: OMAP2420: Fix ethernet support
Message-ID: <1352844140-11103-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix ethernet support for OMAP2420 and remove legacy code for ethernet
configuration.

Jon Hunter (2):
  ARM: OMAP2420: Fix ethernet support for OMAP2420 H4
  ARM: OMAP: Remove debug-devices.c

 arch/arm/mach-omap2/board-h4.c      |   80 +++++++-----------------------
 arch/arm/mach-omap2/debug-devices.h |    9 ----
 arch/arm/plat-omap/Makefile         |    1 -
 arch/arm/plat-omap/debug-devices.c  |   93 -----------------------------------
 4 files changed, 19 insertions(+), 164 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/debug-devices.h
 delete mode 100644 arch/arm/plat-omap/debug-devices.c

-- 
1.7.9.5
