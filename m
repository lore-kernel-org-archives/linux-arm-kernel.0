From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri,  9 Sep 2016 10:01:01 -0400
Subject: [PATCH 0/8] ARM: dts: rockchip: Remove skeleton.dtsi usage and fix
 memory node DTC warnings
Message-ID: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Heiko,

This series removes the inclusion of the skeleton.dtsi in all the Rockchip
dts, which allows to get rid of the DTC warnings about a mismatch between
the memory nodes' unit names and reg properties.

Patches are pretty trivial and shouldn't cause functional changes AFAIK,
but were only built tested and dtbs compared with scripts/dtc/dtx_diff.

Best regards,
Javier


Javier Martinez Canillas (8):
  ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk3036.dtsi
  ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk322x.dtsi
  ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk3288.dtsi
  ARM: dts: rockchip: Remove skeleton.dtsi inclusion in rk3xxx.dtsi
  ARM: dts: rockchip: Add missing unit name to memory nodes in rk3036
    boards
  ARM: dts: rockchip: Add missing unit name to memory nodes in rk322x
    boards
  ARM: dts: rockchip: Add missing unit name to memory nodes in rk3288
    boards
  ARM: dts: rockchip: Add missing unit name to memory nodes in rk3xxx
    boards

 arch/arm/boot/dts/rk3036-evb.dts                  | 2 +-
 arch/arm/boot/dts/rk3036-kylin.dts                | 2 +-
 arch/arm/boot/dts/rk3036.dtsi                     | 4 +++-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts            | 2 +-
 arch/arm/boot/dts/rk3066a-marsboard.dts           | 2 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts            | 2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts            | 2 +-
 arch/arm/boot/dts/rk3228-evb.dts                  | 2 +-
 arch/arm/boot/dts/rk3229-evb.dts                  | 2 +-
 arch/arm/boot/dts/rk322x.dtsi                     | 4 +++-
 arch/arm/boot/dts/rk3288-evb.dtsi                 | 2 +-
 arch/arm/boot/dts/rk3288-fennec.dts               | 2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi             | 2 +-
 arch/arm/boot/dts/rk3288-miqi.dts                 | 2 +-
 arch/arm/boot/dts/rk3288-popmetal.dts             | 2 +-
 arch/arm/boot/dts/rk3288-r89.dts                  | 2 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi           | 2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi              | 2 +-
 arch/arm/boot/dts/rk3288.dtsi                     | 4 +++-
 arch/arm/boot/dts/rk3xxx.dtsi                     | 4 +++-
 21 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.7.4
