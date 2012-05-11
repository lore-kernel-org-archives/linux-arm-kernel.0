From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 14:42:43 +0800
Subject: [PATCH 0/5] Enable audio support for imx51-babbage and imx53-qsb
Message-ID: <1336718568-26810-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series enables audio support for imx51-babbage and imx53-qsb
booting from device tree.

Shawn Guo (5):
      ARM: imx: add more imx5 ssi clocks
      ARM: imx: add audmux pad setting for imx51-babbage
      ARM: imx: add audio codec clk lookup for imx53-qsb
      ARM: dts: imx51-babbage: enable audio support
      ARM: dts: imx53-qsb: enable audio support

 arch/arm/boot/dts/imx51-babbage.dts   |   28 ++++++++++++++++++++++-
 arch/arm/boot/dts/imx51.dtsi          |   33 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx53-qsb.dts       |   39 +++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx53.dtsi          |   33 +++++++++++++++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c   |   40 +++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx53-dt.c          |   19 +++++++++++++++
 arch/arm/mach-imx/mach-mx51_babbage.c |    6 +++++
 7 files changed, 196 insertions(+), 2 deletions(-)
