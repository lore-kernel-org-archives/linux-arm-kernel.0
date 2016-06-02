From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  2 Jun 2016 15:50:08 +0800
Subject: [PATCH 0/3] ARM: dts: sun8i-h3: Add dts file for Sinovoip BPI-M2+
Message-ID: <1464853811-15233-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for Sinovoip's BPI-M2+, an Allwinner H3 SoC based
development board. It is a smaller form factor than the original BPI-M2,
which was based on a different SoC.

The patches are pretty self-explaining.

Regards
ChenYu


Chen-Yu Tsai (3):
  ARM: dts: sun8i-h3: move uart0 pins to sort pinmux list in proper
    order
  ARM: dts: sun8i-h3: Add uart1 pinmux setting
  ARM: dts: sun8i-h3: Add dts file for Sinovoip BPI-M2+

 arch/arm/boot/dts/Makefile                         |   3 +-
 .../arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts | 196 +++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  21 ++-
 3 files changed, 212 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts

-- 
2.8.1
