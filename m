From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Aug 2015 03:08:46 -0700
Subject: [GIT PULL 2/2] omap device tree changes for v4.3, part 4
In-Reply-To: <pull-1439455019-336197>
References: <pull-1439455019-336197>
Message-ID: <pull-1439455019-336197-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ed05637c30e6d13e5793aab64d6a6e57e30228af:

  ARM: dts: omap3-devkit8000: Add ADS7846 Touchscreen support (2015-08-06 02:43:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/dt-pt4-v2

for you to fetch changes up to 8cbd4c2f6a996f6cf5dfdf8775d331606cff95bd:

  arm: boot: dts: am4372: add ARM timers and SCU nodes (2015-08-13 01:25:11 -0700)

----------------------------------------------------------------
Fix up bogus RTC compatible change for am4372 and add missing
DPLL for am4372 cpsw Ethernet driver. Also add ARM global and
local timers for am4372.

----------------------------------------------------------------
Felipe Balbi (1):
      arm: boot: dts: am4372: add ARM timers and SCU nodes

Keerthy (3):
      ARM: dts: AM437X: add dpll_clksel_mac_clk node
      ARM: dts: am4372: Set the default clock rate for dpll_clksel_mac_clk clock
      ARM: dts: AM4372: Add the am4372-rtc compatible string

Tony Lindgren (1):
      Merge branch 'for-4.3/ti-clk-dt' of https://github.com/t-kristo/linux-pm into omap-for-v4.3/dt-v2

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |  1 +
 arch/arm/boot/dts/am4372.dtsi                      | 31 +++++++++++++++++++---
 arch/arm/boot/dts/am43xx-clocks.dtsi               |  9 +++++++
 drivers/clk/ti/clk-43xx.c                          |  1 +
 4 files changed, 39 insertions(+), 3 deletions(-)
