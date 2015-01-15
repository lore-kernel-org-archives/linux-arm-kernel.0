From: naobsd@gmail.com (FUKAUMI Naoki)
Date: Thu, 15 Jan 2015 11:40:56 +0900
Subject: [PATCH 0/3] add support for Firefly-RK3288 and Rayeager PX2 boards
Message-ID: <1421289659-16627-1-git-send-email-naobsd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for following Rockchip SoC based boards.

 - Firefly, Firefly-RK3288 (both beta and mass production version)
 - ChipSPARK, Rayeager PX2

FUKAUMI Naoki (3):
  dt-bindings: add vendor prefix and root compatible property for
    Rockchip boards
  ARM: dts: rockchip: add dts for Firefly Firefly-RK3288 boards
  ARM: dts: rockchip: add dts for ChipSPARK Rayeager PX2 board

 Documentation/devicetree/bindings/arm/rockchip.txt |   8 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts             | 457 +++++++++++++++++++
 arch/arm/boot/dts/rk3288-firefly-beta.dts          |  70 +++
 arch/arm/boot/dts/rk3288-firefly.dts               |  70 +++
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 498 +++++++++++++++++++++
 7 files changed, 1109 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk3066a-rayeager.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly-beta.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dts
 create mode 100644 arch/arm/boot/dts/rk3288-firefly.dtsi

-- 
2.2.2
