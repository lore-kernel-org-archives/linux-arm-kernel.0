From: tony@atomide.com (Tony Lindgren)
Date: Thu,  3 Dec 2015 17:25:28 -0800
Subject: [PATCH 0/7] Add mmc support for dm814x and dra62x
Message-ID: <1449192335-10137-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add mmc support for dm814x and dra62x. These patches
depend on what's listed at:

http://marc.info/?l=linux-omap&m=144918431819264&w=2

Regards,

Tony


Tony Lindgren (7):
  ARM: dts: Add pinctrl macros for dm814x
  ARM: dts: Update edma bindings on dm814x to use edma_xbar
  ARM: OMAP2+: Add mmc hwmod entries for dm814x
  ARM: dts: Add mmc device entries for dm814x
  ARM: dts: Add mmc support for dm8148-evm
  ARM: dts: Add mmc support for dra62x j5-eco evm
  ARM: dts: Enable emmc on hp t410

 arch/arm/boot/dts/dm8148-evm.dts           |  31 +++++++++
 arch/arm/boot/dts/dm8148-t410.dts          |  35 ++++++++++
 arch/arm/boot/dts/dm814x.dtsi              | 101 +++++++++++++++++++++++++----
 arch/arm/boot/dts/dra62x-j5eco-evm.dts     |  31 +++++++++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |  93 +++++++++++++++++++++++---
 include/dt-bindings/pinctrl/dm814x.h       |  48 ++++++++++++++
 include/dt-bindings/pinctrl/omap.h         |   1 +
 7 files changed, 319 insertions(+), 21 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/dm814x.h

-- 
2.6.2
