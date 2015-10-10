From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Sat, 10 Oct 2015 18:15:05 +0800
Subject: [PATCH V3 0/2] Add SPDIF_GCLK clock in clock tree for imx6
Message-ID: <cover.1444471684.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPDIF_GCLK clock in clock tree

Shengjiu Wang (2):
  clk: imx6: Add SPDIF_GCLK clock in clock tree
  ARM: dts: imx6: change the core clock of spdif

Changes in v3:
- refine the commit logs.

 arch/arm/boot/dts/imx6qdl.dtsi            | 12 ++++++------
 arch/arm/boot/dts/imx6sl.dtsi             | 16 ++++++++++++++++
 arch/arm/boot/dts/imx6sx.dtsi             |  2 +-
 drivers/clk/imx/clk-imx6q.c               |  4 +++-
 drivers/clk/imx/clk-imx6sl.c              |  4 +++-
 drivers/clk/imx/clk-imx6sx.c              |  1 +
 include/dt-bindings/clock/imx6qdl-clock.h |  3 ++-
 include/dt-bindings/clock/imx6sl-clock.h  |  3 ++-
 include/dt-bindings/clock/imx6sx-clock.h  |  3 ++-
 9 files changed, 36 insertions(+), 12 deletions(-)

-- 
1.9.1
