From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Jul 2014 21:27:49 +0200
Subject: [PATCH 0/7] ARM: dts: collected rockchip dtsi and board changes
Message-ID: <16344051.ZPa9bzz4Fj@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are collected dtsi changes for drivers that made it into a tree
recently - except the saradc nodes, where the driver is still in-flight.
As everything depends on the clock controller series [0] anyway, I'll simply
strip off the last patch if necessary once the clocks land.

[0] http://www.spinics.net/lists/arm-kernel/msg343927.html

Beniamino Galvani (2):
  ARM: dts: add i2c and regulator nodes to rk3188-radxarock
  ARM: dts: rockchip: add pwm nodes

Heiko Stuebner (5):
  ARM: dts: add rk3066 and rk3188 i2c device nodes and pinctrl settings
  ARM: dts: rockchip: add tps65910 regulator for bqcurie2
  ARM: dts: rk3188-radxarock: enable sd-card slot
  ARM: dts: rockchip: add both clocks to uart nodes
  ARM: dts: rockchip: add saradc nodes

 arch/arm/boot/dts/rk3066a-bqcurie2.dts |  98 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi         |  59 +++++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts | 147 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3188.dtsi          |  79 ++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi          | 139 ++++++++++++++++++++++++++++++-
 5 files changed, 518 insertions(+), 4 deletions(-)

-- 
1.9.0
