From: heiko@sntech.de (Heiko Stuebner)
Date: Fri,  6 Mar 2015 19:03:58 +0100
Subject: [PATCH 0/8] ARM: dts: rockchip: the big relicensing
Message-ID: <1425665046-22927-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPL2/X11 seems to be the consensus to go for devicetree files, as shown for
examply by armada, meson and sunxi.

We already have the new board-files licensed under this combination, so
complete the transition for the older files.

Heiko Stuebner (8):
  ARM: dts: rockchip: relicense rk3xxx.dtsi under GPLv2/X11
  ARM: dts: rockchip: relicense rk3066a.dtsi under GPLv2/X11
  ARM: dts: rockchip: relicense rk3188.dtsi under GPLv2/X11
  ARM: dts: rockchip: relicense rk3288.dtsi under GPLv2/X11
  ARM: dts: rockchip: relicense rk3288-thermal.dtsi under GPLv2/X11
  ARM: dts: rockchip: relicense rk3066a-bqcurie2.dts under GPLv2/X11
  ARM: dts: rockchip: relicense rk3188-radxarock.dts under GPLv2/X11
  ARM: dts: rockchip: relicense rk3288-evb* under GPLv2/X11

 arch/arm/boot/dts/rk3066a-bqcurie2.dts   | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3066a.dtsi           | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3188-radxarock.dts   | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3188.dtsi            | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3288-evb-act8846.dts | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3288-evb-rk808.dts   | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3288-evb.dtsi        | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3288-thermal.dtsi    | 40 ++++++++++++++++++++++++++---
 arch/arm/boot/dts/rk3288.dtsi            | 44 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/rk3xxx.dtsi            | 44 ++++++++++++++++++++++++++------
 10 files changed, 361 insertions(+), 75 deletions(-)

-- 
2.1.4
