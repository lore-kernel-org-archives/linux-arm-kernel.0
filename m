From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Tue, 15 Sep 2015 18:01:00 +0800
Subject: [PATCH V2 0/2]  fix clock issue for fsl,spdi
Message-ID: <cover.1442310569.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix clock issue for fsl,spdi in imx6.

Changes in v2:
move the dts change to another patch

Shengjiu Wang (2):
  clk: imx6: Add SPDIF_GCLK clock in clock tree
  ARM: dts: imx6: change the core clock of spdif

 arch/arm/boot/dts/imx6qdl.dtsi            |  2 +-
 arch/arm/boot/dts/imx6sl.dtsi             | 16 ++++++++++++++++
 arch/arm/boot/dts/imx6sx.dtsi             |  2 +-
 drivers/clk/imx/clk-imx6q.c               |  4 +++-
 drivers/clk/imx/clk-imx6sl.c              |  4 +++-
 drivers/clk/imx/clk-imx6sx.c              |  1 +
 include/dt-bindings/clock/imx6qdl-clock.h |  3 ++-
 include/dt-bindings/clock/imx6sl-clock.h  |  3 ++-
 include/dt-bindings/clock/imx6sx-clock.h  |  3 ++-
 9 files changed, 31 insertions(+), 7 deletions(-)

-- 
1.9.1
