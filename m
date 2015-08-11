From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Tue, 11 Aug 2015 17:26:51 +0800
Subject: [PATCH V1 0/3] fix clock issue for fsl,spdif
Message-ID: <cover.1439284957.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix clock issue for fsl,spdif

Shengjiu Wang (3):
  ARM: imx6q: Add SPDIF_GCLK clock in clock tree
  ARM: imx6sl: Add SPDIF_GCLK clock in clock tree
  ARM: imx6sx: Add SPDIF_GCLK clock in clock tree

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
