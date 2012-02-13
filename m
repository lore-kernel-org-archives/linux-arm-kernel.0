From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 13 Feb 2012 11:44:18 +0530
Subject: [PATCH v2 0/2] AM335X: SoC type detection & SRAM support
Message-ID: <1329113658-7417-1-git-send-email-afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These changes does,
1. detect SoC type (i.e. GP or not)
2. add minimal SRAM support
 for AM335X devices

These are required to get AM335X boot to prompt (but not sufficient)

v2: Use OMAP naming conventions for subject

Regards
Afzal

Afzal Mohammed (1):
  ARM: OMAP2+: id: Add am33xx SoC type detection

Vaibhav Bedia (1):
  ARM: OMAP: sram: Add am33xx SRAM support (minimal)

 arch/arm/mach-omap2/control.h          |    5 +++++
 arch/arm/mach-omap2/id.c               |    2 ++
 arch/arm/plat-omap/include/plat/sram.h |    1 +
 arch/arm/plat-omap/sram.c              |   14 ++++++++++++--
 4 files changed, 20 insertions(+), 2 deletions(-)
