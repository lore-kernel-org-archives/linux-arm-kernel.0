From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 13 Feb 2017 18:59:26 +0800
Subject: [PATCH 0/7] Rename RK1108 to RV1108
Message-ID: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Rockchip finally named this soc as RV1108, so change
RK1108/rk1108 to RV1108/rv1108 for compatible.


Andy Yan (7):
  dt-bindings: rockchip-dw-mshc: rename RK1108 to RV1108
  dt-bindings: rk1108-cru: rename RK1108 to RV1108
  clk: rockchip: rename RK1108 to RV1108
  dt-bindings: rockchip,pinctrl: rename RK1108 to RV1108
  pinctrl: rockchip: rename RK1108 to RV1108
  ARM: dts: rename RK1108 to RV1108
  ARM: rockchip: reanme RK1108 to RV1108

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +-
 ...chip,rk1108-cru.txt => rockchip,rv1108-cru.txt} |  12 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   2 +-
 .../bindings/pinctrl/rockchip,pinctrl.txt          |  16 +-
 arch/arm/boot/dts/Makefile                         |   2 +-
 .../boot/dts/{rk1108-evb.dts => rv1108-evb.dts}    |   7 +-
 arch/arm/boot/dts/{rk1108.dtsi => rv1108.dtsi}     |  24 +-
 drivers/clk/rockchip/Makefile                      |   2 +-
 .../clk/rockchip/{clk-rk1108.c => clk-rv1108.c}    | 414 ++++++++++-----------
 drivers/clk/rockchip/clk.h                         |  28 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  76 ++--
 .../clock/{rk1108-cru.h => rv1108-cru.h}           |   6 +-
 12 files changed, 300 insertions(+), 293 deletions(-)
 rename Documentation/devicetree/bindings/clock/{rockchip,rk1108-cru.txt => rockchip,rv1108-cru.txt} (83%)
 rename arch/arm/boot/dts/{rk1108-evb.dts => rv1108-evb.dts} (89%)
 rename arch/arm/boot/dts/{rk1108.dtsi => rv1108.dtsi} (94%)
 rename drivers/clk/rockchip/{clk-rk1108.c => clk-rv1108.c} (57%)
 rename include/dt-bindings/clock/{rk1108-cru.h => rv1108-cru.h} (97%)

-- 
2.7.4
