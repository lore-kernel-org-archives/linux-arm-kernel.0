From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 17 Jul 2015 17:20:30 +0530
Subject: [PATCH v2 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
Message-ID: <1437133833-32355-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements lock and unlock functions for RTC and hooks
the same to DRA7 and AMx3xx hwmod.
This is dependent on the patch https://patchwork.kernel.org/patch/6578281/,
which is queued recently by Paul.

Tested on DRA72-evm: http://pastebin.ubuntu.com/11892356/

Lokesh Vutla (3):
  ARM: hwmod: RTC: Add lock and unlock functions
  ARM: DRA7: RTC: Add lock and unlock functions
  ARM: AMx3xx: RTC: Add lock and unlock functions

 arch/arm/mach-omap2/omap_hwmod.h                   |  2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +
 arch/arm/mach-omap2/omap_hwmod_reset.c             | 56 ++++++++++++++++++++++
 4 files changed, 62 insertions(+)

-- 
2.1.4
