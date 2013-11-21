From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Nov 2013 10:51:03 -0800
Subject: [PATCH 0/3] Yet more fixes for booting omaps with device tree
Message-ID: <1385059866-10646-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Hopefully this is the last set for the -rc cycle on the legacy booting
vs device tree booting regressions.

Regards,

Tony


Tony Lindgren (3):
  ARM: OMAP2+: Fix more missing data for omap3.dtsi file
  ARM: OMAP2+: Add fixed regulator to omap2plus_defconfig
  ARM: OMAP2+: Fix eMMC on n900 with device tree

 arch/arm/boot/dts/omap3-n900.dts     |  6 +++++-
 arch/arm/boot/dts/omap3.dtsi         | 42 ++++++++++++++++++++++++++++++++++++
 arch/arm/configs/omap2plus_defconfig |  1 +
 arch/arm/mach-omap2/pdata-quirks.c   |  1 +
 4 files changed, 49 insertions(+), 1 deletion(-)

-- 
1.8.1.1
