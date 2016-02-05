From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 5 Feb 2016 11:12:29 +0530
Subject: [PATCH v4 0/3] ARM: OMAP2+: hwmod: RTC: Add lock and unlock hooks
Message-ID: <1454650952-20154-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements lock and unlock functions for RTC and hooks
the same to DRA7 and AMx3xx hwmod.

Tested RTC functionality on:
DRA74-EVM: http://pastebin.ubuntu.com/14885542/
BeagleBoard-X15: http://pastebin.ubuntu.com/14885568/
AM437x-GP EVM: http://pastebin.ubuntu.com/14885589/
AM335x BeagleBoneBlack: http://pastebin.ubuntu.com/14885600/

Changes since v3:
- Rebased on top of latest Mainline.
Link to v3 series: https://www.mail-archive.com/linux-omap%40vger.kernel.org/msg118342.html

Lokesh Vutla (3):
  ARM: hwmod: RTC: Add lock and unlock functions
  ARM: DRA7: RTC: Add lock and unlock functions
  ARM: AMx3xx: RTC: Add lock and unlock functions

 arch/arm/mach-omap2/omap_hwmod.h                   |  2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  2 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  2 +
 arch/arm/mach-omap2/omap_hwmod_reset.c             | 65 ++++++++++++++++++++++
 4 files changed, 71 insertions(+)

-- 
2.1.4
