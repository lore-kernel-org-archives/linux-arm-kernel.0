From: jay.xu@rock-chips.com (jianqun.xu)
Date: Tue, 23 Feb 2016 15:01:00 +0800
Subject: [PATCH 0/4] Rockchip: rk3399: Add core dtsi for rk3399
Message-ID: <1456210864-29037-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianqun Xu <jay.xu@rock-chips.com>

There is the new SoCs from Rockchip which named rk3399, the
patches are added to support them.

Jianqun Xu (2):
  soc: rockchip: add bindings for Rockchip grf
  ARM64: dts: rockchip: add core dtsi file for rk3399

Xing Zheng (2):
  dt-bindings: add bindings for rk3399 clock controller
  clk: rockchip: add dt-binding header for rk3399

 .../bindings/clock/rockchip,rk3399-cru.txt         |  82 ++
 .../devicetree/bindings/soc/rockchip/grf.txt       |  35 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 949 +++++++++++++++++++++
 include/dt-bindings/clock/rk3399-cru.h             | 714 ++++++++++++++++
 4 files changed, 1780 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
 create mode 100644 include/dt-bindings/clock/rk3399-cru.h

-- 
1.9.1
