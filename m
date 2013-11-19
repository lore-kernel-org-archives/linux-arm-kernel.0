From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Nov 2013 08:31:23 -0800
Subject: [PATCH 0/2] Remove some dead code for omaps
Message-ID: <1384878685-1515-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I noticed we have some dead code left over after we made omap4
to boot in device tree only mode, so let's just remove it.

Regards,

Tony


Tony Lindgren (2):
  ARM: OMAP2+: Remove legacy mux code for display.c
  ARM: OMAP2+: Remove legacy omap4_twl6030_hsmmc_init

 arch/arm/mach-omap2/common.h       |  1 -
 arch/arm/mach-omap2/display.c      | 78 --------------------------------------
 arch/arm/mach-omap2/omap4-common.c | 57 ----------------------------
 3 files changed, 136 deletions(-)

-- 
1.8.1.1
