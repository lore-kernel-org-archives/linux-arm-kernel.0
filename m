From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 11 Jul 2015 02:29:18 +0200
Subject: [PATCH 0/4] ARM: dts: rockchip: add initial support for rk3288
 Chrome-devices
Message-ID: <1436574562-16308-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the basic support for two RK3288 Chrome-devices.
Of course the internal display does not yet work, because we're
missing the edp driver in mainline currently.
But we're nevertheless able to boot to a rootfs on the devices.


Alexandru M Stan (2):
  ARM: dts: rockchip: add shared rk3288-veyron files
  ARM: dts: rockchip: add veyron-jerry board

Chris Zhong (1):
  ARM: dts: Add sbs-battery dts fragment used by chromebooks

Heiko Stuebner (1):
  ARM: dts: rockchip: add Pinky board

 Documentation/devicetree/bindings/arm/rockchip.txt |  12 +
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/cros-ec-sbs.dtsi                 |  18 +
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    | 234 +++++++++
 arch/arm/boot/dts/rk3288-veyron-jerry.dts          | 199 +++++++
 arch/arm/boot/dts/rk3288-veyron-pinky.dts          | 128 +++++
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi         | 122 +++++
 arch/arm/boot/dts/rk3288-veyron.dtsi               | 583 +++++++++++++++++++++
 8 files changed, 1299 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/cros-ec-sbs.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-jerry.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-pinky.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron.dtsi

-- 
2.1.4
