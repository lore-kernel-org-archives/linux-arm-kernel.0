From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2016 15:49:08 -0700
Subject: [GIT PULL] few minor fixes for omap dts files for v4.9 merge window
Message-ID: <20160921224907.l2nxg5ynw3rxztlm@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a2a2b8215621536a7620e31f36bede81bb86680b:

  Merge branch 'am335x-cpufreq-regression' into omap-for-v4.9/dt-v2 (2016-09-14 16:27:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.9/dt-pt3-signed

for you to fetch changes up to ce385a5e7a85c023af2e013101d4fe2240beec21:

  ARM: dts: omap5-igep0050.dts: Use tabs for indentation (2016-09-20 11:37:50 -0700)

----------------------------------------------------------------
Few fixes for omap dts files for v4.9 merge window. Let's also add
the tilcdc quirks:

- Fix typo with recent beagleboard-x15 changes for mmc2_pins_default

- Add am335x blue-and-red-wiring quirk as specified in the binding in
  Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt. Also
  fix up the whitespace formatting for am335x-evmsk.

- Fix for recent igepv5 power button for GPIO_ACTIVE_LOW. Also fix
  up the whitespace formatting for the button

----------------------------------------------------------------
Jyri Sarha (3):
      ARM: dts: am335x-evm: Add blue-and-red-wiring -property to lcdc node
      ARM: dts: am335x-evmsk: Whitespace cleanup of lcdc related nodes
      ARM: dts: am335x-evmsk: Add blue-and-red-wiring -property to lcdc node

Ladislav Michl (1):
      ARM: dts: omap5-igep0050.dts: Use tabs for indentation

Nishanth Menon (1):
      ARM: dts: am57xx-beagle-x15-common: Fix wrong pinctrl selection for mmc2

Tony Lindgren (1):
      ARM: dts: Fix igepv5 power button GPIO direction

 arch/arm/boot/dts/am335x-evm.dts                |  2 ++
 arch/arm/boot/dts/am335x-evmsk.dts              | 42 +++++++++++++------------
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  2 +-
 arch/arm/boot/dts/omap5-igep0050.dts            |  4 +--
 4 files changed, 27 insertions(+), 23 deletions(-)
