From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri, 23 May 2014 01:06:21 +0200
Subject: [PATCH 0/5] ARM: omap3-lilly-a83x: update board support
Message-ID: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches updates board support for omap3-lilly-a83x.

Christoph Fritz (5):
  [RFC-HACK] pinctrl-single: init by postcore_initcall()
  [RFC-HACK] ARM: dts: OMAP3: reorder pinmux_gpio1_pins
  ARM: dts: omap3: set mcbsp2 status
  [RFC] ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable
  ARM: dts: OMAP3 a83x: fix duplicate usb pin config

 arch/arm/boot/dts/omap3-lilly-a83x.dtsi |    7 +++---
 arch/arm/boot/dts/omap34xx.dtsi         |   28 ++++++++++++----------
 arch/arm/boot/dts/omap36xx.dtsi         |   40 ++++++++++++++++---------------
 arch/arm/mach-omap2/gpmc-nand.c         |   16 +++++--------
 drivers/pinctrl/pinctrl-single.c        |   15 ++++++++++++
 5 files changed, 61 insertions(+), 45 deletions(-)

-- 
1.7.10.4
