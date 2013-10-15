From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 12:58:53 +0200
Subject: [PATCH 0/5] ARM: rockchip: Support for RK3188 and Radxa Rock board
Message-ID: <201310151258.53435.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some slight reordering of stuff to facilitate the addition of support for
the RK3188 SoC and the Radxa Rock board using it.

Heiko Stuebner (5):
  ARM: rockchip: move shared dt properties to common source file
  ARM: rockchip: enable arm-global-timer
  ARM: rockchip: add dts for bqcurie2 tablet
  ARM: rockchip: add support for rk3188 and Radxa Rock board
  MAINTAINERS: Add maintainers entry for Rockchip SoCs

 MAINTAINERS                            |    7 +
 arch/arm/boot/dts/rk3066a-bqcurie2.dts |  109 ++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi         |   98 +----------
 arch/arm/boot/dts/rk3188-clocks.dtsi   |  289 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts |   80 +++++++++
 arch/arm/boot/dts/rk3188.dtsi          |  253 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi          |  124 ++++++++++++++
 arch/arm/mach-rockchip/Kconfig         |    2 +
 8 files changed, 865 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3066a-bqcurie2.dts
 create mode 100644 arch/arm/boot/dts/rk3188-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/rk3188-radxarock.dts
 create mode 100644 arch/arm/boot/dts/rk3188.dtsi
 create mode 100644 arch/arm/boot/dts/rk3xxx.dtsi

-- 
1.7.10.4
