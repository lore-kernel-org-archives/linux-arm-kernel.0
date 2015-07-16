From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 Jul 2015 04:59:09 -0700
Subject: [PATCH 0/2] Drop two more omap3 legacy board files for v4.3 merge
 window
Message-ID: <1437047951-22300-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I think we can drop these now. This just leaves n900 and ldp with
n900 pending patches for legacy proc support.

Regards,

Tony

Tony Lindgren (2):
  ARM: OMAP2+: Remove legacy booting support for LogicPD Torpedo
  ARM: OMAP2+: Remove legacy booting support for Pandora

 arch/arm/mach-omap2/Kconfig              |  20 -
 arch/arm/mach-omap2/Makefile             |   3 -
 arch/arm/mach-omap2/board-omap3logic.c   | 249 ------------
 arch/arm/mach-omap2/board-omap3pandora.c | 633 -------------------------------
 4 files changed, 905 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-omap3logic.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3pandora.c

-- 
2.1.4
