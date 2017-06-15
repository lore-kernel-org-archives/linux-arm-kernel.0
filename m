From: frank.wang@rock-chips.com (Frank Wang)
Date: Thu, 15 Jun 2017 15:16:14 +0800
Subject: [PATCH 0/6] add some device nodes support for rk322x SoC
Message-ID: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These series add sdmmc, sdio, and other device nodes support for
rk322x SoCs, and also introduce rk3229 basic dtsi file specifically.

David Wu (1):
  ARM: dts: rockchip: Add io-domain node for rk3228

Finley Xiao (1):
  ARM: dts: rockchip: add efuse device node for rk3228

Frank Wang (1):
  ARM: dts: rockchip: add basic dtsi file for RK3229 SoC

Shawn Lin (3):
  Documentation: rockchip-dw-mshc: add description for rk3228
  ARM: dts: rockchip: fix compatible string for eMMC node of rk3228 SoC
  ARM: dts: rockchip: add sdmmc and sdio nodes for rk3228 SoC

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   1 +
 arch/arm/boot/dts/rk3229-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk3229.dtsi                      | 110 +++++++++++++++++++++
 arch/arm/boot/dts/rk322x.dtsi                      |  84 +++++++++++++++-
 4 files changed, 195 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3229.dtsi

-- 
2.0.0
