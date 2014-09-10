From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 10 Sep 2014 20:46:49 +0200
Subject: [PATCH 0/6] ARM: dts: Pull rk3066 and rk3188 along with recent rk3288
 developments
Message-ID: <1410374815-20208-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some cleanups and enablement of dwc2, spi and emmc functionality,
that recent got added to the rk3288, for the Cortex-A9 SoCs
rk3066 and rk3188.

Heiko Stuebner (6):
  ARM: dts: rockchip: remove rockchip,bus-index from rk3xxx i2c0
  ARM: dts: rockchip: add dwc2 controllers for rk3066 and rk3188
  ARM: dts: rockchip: enable usb ports on Radxa Rock
  ARM: dts: rockchip: add Cortex-A9 SPI controller nodes
  ARM: dts: rockchip: add emmc nodes for rk3066 and rk3188
  ARM: dts: clean up mmc nodes

 arch/arm/boot/dts/rk3066a.dtsi         | 67 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts | 43 +++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi          | 69 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi          | 61 +++++++++++++++++++++++++++---
 4 files changed, 235 insertions(+), 5 deletions(-)

-- 
2.0.1
