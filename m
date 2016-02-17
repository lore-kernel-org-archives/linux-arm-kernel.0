From: jay.xu@rock-chips.com (jianqun.xu)
Date: Wed, 17 Feb 2016 09:53:06 +0800
Subject: [PATCH 0/6] Add core dtsi for rk3399 from Rockchip
Message-ID: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xu Jianqun <jay.xu@rock-chips.com>

There is the new SoCs from Rockchip which named rk3399, the
patches are added to support them.

Two patch of cru from Xing are quoted, but the cru driver will
be pushed by Xing near later.

Xing Zheng (2):
  clk: rockchip: add dt-binding header for rk3399
  dt-bindings: add documentation of rk3399 clock controller

Xu Jianqun (4):
  spi: rockchip: add bindings for rk3399 spi
  ASoC: rockchip: add bindings for rk3399 i2s
  pinctrl: rockchip: add bindings for rk3399 pinctrl
  ARM64: dts: rockchip: add core dtsi file for rk3399

 .../bindings/clock/rockchip,rk3399-cru.txt         |  82 ++
 .../bindings/pinctrl/rockchip,pinctrl.txt          |   2 +-
 .../devicetree/bindings/sound/rockchip-i2s.txt     |   1 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 989 +++++++++++++++++++++
 include/dt-bindings/clock/rk3399-cru.h             | 610 +++++++++++++
 6 files changed, 1684 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
 create mode 100644 include/dt-bindings/clock/rk3399-cru.h

-- 
1.9.1
