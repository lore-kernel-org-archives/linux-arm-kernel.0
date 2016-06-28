From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 28 Jun 2016 12:48:08 +0800
Subject: [PATCH v1 0/5] Enable graphic support on RK3288 EVB boards
Message-ID: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Heiko,

   This series just want to enable the graphic support on RK3288 EVB
boards, most of them are DTS changes, but still have one change about
new eDP panel support.

Thanks,
- Yakir


Yakir Yang (5):
  dt-bindings: Add support for LG LP079QX1-SP0V 1536x2048 panel
  drm/panel: simple: Add support for LG LP079QX1-SP0V 1536x2048 panel
  ARM: dts: rockchip: add eDP/panel display device nodes for rk3288-evb
  ARM: dts: rockchip: add the panel power supply for rk3288-evb board
    with act8846 pmu
  ARM: dts: rockchip: add the panel power supply for rk3288-evb board
    with rk808 pmu

 .../bindings/display/panel/lg,lp079qx1-sp0v.txt    |  7 ++++
 arch/arm/boot/dts/rk3288-evb-act8846.dts           |  4 ++
 arch/arm/boot/dts/rk3288-evb-rk808.dts             |  4 ++
 arch/arm/boot/dts/rk3288-evb.dtsi                  | 43 +++++++++++++++++++++-
 drivers/gpu/drm/panel/panel-simple.c               | 26 +++++++++++++
 5 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,lp079qx1-sp0v.txt

-- 
1.9.1
