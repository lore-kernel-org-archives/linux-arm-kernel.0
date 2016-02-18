From: jay.xu@rock-chips.com (jianqun.xu)
Date: Thu, 18 Feb 2016 10:36:19 +0800
Subject: [PATCH v2 0/4] Add core dtsi for rk3399 from Rockchip
Message-ID: <1455762983-29980-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianqun Xu <jay.xu@rock-chips.com>

There is the new SoCs from Rockchip which named rk3399, the
patches are added to support them.

Xing Zheng (2):
  clk: rockchip: add dt-binding header for rk3399
  dt-bindings: add documentation of rk3399 clock controller

Xu Jianqun (2):
  spi: rockchip: add bindings for rk3399 spi
  ARM64: dts: rockchip: add core dtsi file for rk3399

 .../bindings/clock/rockchip,rk3399-cru.txt         |  82 ++
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 949 +++++++++++++++++++++
 include/dt-bindings/clock/rk3399-cru.h             | 609 +++++++++++++
 4 files changed, 1641 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
 create mode 100644 include/dt-bindings/clock/rk3399-cru.h

-- 
changes in v2:
- remove changeID (Heiko, Mark)
- drop pmu and psci temporary (Mark)
- drop applied patch (Heiko)
- drop GIC_CPU_MASK_SIMPLE from the interrupt specifiers (Marc, Heiko)
- drop clock-frequency of timer (Marc, Mark)
- remove double defination for SCLK_SPI5

1.9.1
