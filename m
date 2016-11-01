From: Nicolae_Rosia@mentor.com (Nicolae Rosia)
Date: Tue, 1 Nov 2016 13:36:41 +0200
Subject: [PATCH 0/5] ARM: OMAP: dead code removal
Message-ID: <1478000206-10855-1-git-send-email-Nicolae_Rosia@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have identified some dead code which can be removed.

Nicolae Rosia (5):
  ARM: OMAP4: kill omap4_pmic_init and omap4_pmic_get_config
  ARM: OMAP3: kill omap3_pmic_get_config and twl_{get,set}_voltage
  ARM: OMAP3: kill omap3_pmic_init
  ARM: OMAP2: kill omap2_pmic_init
  ARM: OMAP: kill omap_pmic_init

 arch/arm/mach-omap2/twl-common.c | 483 ---------------------------------------
 arch/arm/mach-omap2/twl-common.h |  24 --
 2 files changed, 507 deletions(-)

-- 
2.5.5
