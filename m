From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Tue, 9 Sep 2014 17:13:24 +0800
Subject: [PATCH V1 0/3] refine the ssi clock for imx6sl, and update dts file.
Message-ID: <cover.1410253534.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serial patch is for refining the ssi clock tree for imx6sl,
and update imx6qdl and imx6sl dts file.

Shengjiu Wang (3):
  ARM: clk-imx6sl: refine clock tree for SSI
  ARM: dts: imx6qdl: add baud clock and clock-names for ssi
  ARM: dts: imx6sl: add baud clock and clock-names for ssi

 arch/arm/boot/dts/imx6qdl.dtsi           |   12 +++++++++---
 arch/arm/boot/dts/imx6sl.dtsi            |   12 +++++++++---
 arch/arm/mach-imx/clk-imx6sl.c           |   13 ++++++++++---
 include/dt-bindings/clock/imx6sl-clock.h |    5 ++++-
 4 files changed, 32 insertions(+), 10 deletions(-)

-- 
1.7.9.5
