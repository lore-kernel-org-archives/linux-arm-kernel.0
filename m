From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Tue,  1 Mar 2016 14:39:58 +0800
Subject: [PATCH v3 0/3] Rockchip: rk3399: Add core dtsi for rk3399
In-Reply-To: <1456456341-14282-1-git-send-email-jay.xu@rock-chips.com>
References: <1456456341-14282-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1456814401-10711-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is the new SoCs from Rockchip which named rk3399, the
patches are added to support them.

Jianqun Xu (1):
  ARM64: dts: rockchip: add core dtsi file for rk3399

Xing Zheng (2):
  dt-bindings: add bindings for rk3399 clock controller
  clk: rockchip: add dt-binding header for rk3399

 .../bindings/clock/rockchip,rk3399-cru.txt         |  82 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 951 +++++++++++++++++++++
 include/dt-bindings/clock/rk3399-cru.h             | 716 ++++++++++++++++
 3 files changed, 1749 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
 create mode 100644 include/dt-bindings/clock/rk3399-cru.h

-- 
changes in v3:
- fix pmucru definations
- update dtsi depends on cru changes 

1.9.1
