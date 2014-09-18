From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Sep 2014 13:11:02 -0700
Subject: [GIT PULL 3/4] part 2 of omap dts changes for v3.18 merge window
In-Reply-To: <pull-1411070912-460910>
References: <pull-1411070912-460910>
Message-ID: <pull-1411070912-460910-3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d27704d1ec2f9ba06247b402c58a6f2febecef78:

  ARM: dts: OMAP2+: Add sub mailboxes device node information (2014-09-11 11:46:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/dt-part2-v2-for-v3.18

for you to fetch changes up to f53e3c538da314913e5d3d82c9610f8da42bd894:

  ARM: dts: DRA7: Add PMU nodes (2014-09-18 09:58:10 -0700)

----------------------------------------------------------------
Changes to add dra7 PMU, display support for cm-t54, misc
changes needed for omap3 boards for device tree support.

----------------------------------------------------------------
Dmitry Lifshitz (6):
      ARM: dts: sbc-t54: fix mux mode comment style
      ARM: dts: cm-t54: fix mux mode comment style
      ARM: dts: cm-t54: add HDMI/DVI display data
      ARM: dts: cm-t54: add Startek LCD support
      ARM: dts: cm-t54: add ADS7846 touchscreen support
      ARM: dts: cm-t54: setup omap_dwc3

Lucas Weaver (1):
      ARM: dts: DRA7: Add PMU nodes

Tony Lindgren (5):
      ARM: dts: omap3-overo: Fix UART wake-up events
      ARM: dts: omap: Remove WAKEUPENABLE mux options for UARTs
      ARM: dts: Do not set pulls for I2C lines
      ARM: dts: Add support for Ethernet on some N900 macro boards
      ARM: dts: Enable PMIC idle configuration for LDP

 arch/arm/boot/dts/dra72x.dtsi                      |   5 +
 arch/arm/boot/dts/dra74x.dtsi                      |   6 +
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   4 +-
 arch/arm/boot/dts/omap3-ldp.dts                    |   5 +
 arch/arm/boot/dts/omap3-n900.dts                   |  54 +++-
 .../boot/dts/omap3-overo-common-peripherals.dtsi   |   5 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 | 272 ++++++++++++++++++++-
 arch/arm/boot/dts/omap5-sbc-t54.dts                |   4 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |   3 +
 9 files changed, 344 insertions(+), 14 deletions(-)
