From: tony@atomide.com (Tony Lindgren)
Date: Wed, 07 Jul 2010 12:43:44 +0300
Subject: [PATCH 00/13] omap2/3/4 board updates for 2.6.36 merge window
Message-ID: <20100707094308.2562.91921.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some omap board updates for review.

Regards,

Tony

---

Ameya Palande (1):
      tsl2563 ALS support for Nokia N900

David Anders (1):
      Add OMAP4 Panda Support

Grazvydas Ignotas (2):
      omap3: pandora: update gpio-keys data
      omap3: pandora: add NAND and wifi support

Hemanth V (1):
      OMAP4: Add GPIO LED support for SDP board

Jarkko Nikula (4):
      omap: rx51: Set regulator V28 always on
      omap: rx51: Add platform_data for tlv320aic3x with reset gpionumber
      omap: rx51: Use REGULATOR_SUPPLY macro when initializingregulator consumers
      omap: rx51: Add supply and data for the tpa6130a2 headphoneamplifier

Ohad Ben-Cohen (2):
      omap: zoom2: wlan board muxing
      omap: zoom3: wlan board muxing

Santosh Shilimkar (1):
      omap4: mmc: Fix the regulator resource for MMC2 on 4430sdp

Shubhrajyoti Datta (1):
      omap4: Board changes for 4430sdp tmp105 temperature sensor


 arch/arm/mach-omap2/Kconfig                  |    5 
 arch/arm/mach-omap2/Makefile                 |    2 
 arch/arm/mach-omap2/board-4430sdp.c          |   70 ++++++
 arch/arm/mach-omap2/board-omap3pandora.c     |  148 +++++++++++--
 arch/arm/mach-omap2/board-omap4panda.c       |  304 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-rx51-peripherals.c |   71 +++---
 arch/arm/mach-omap2/board-zoom2.c            |   15 +
 arch/arm/mach-omap2/board-zoom3.c            |   15 +
 8 files changed, 574 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap4panda.c

-- 
Signature
