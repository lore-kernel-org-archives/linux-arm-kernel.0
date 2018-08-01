From: cl@rock-chips.com (cl at rock-chips.com)
Date: Wed,  1 Aug 2018 16:45:12 +0800
Subject: [PATCH v3 0/4] arm64: dts: rockchip: add basic dts file for PX30 SoCs
Message-ID: <1533113116-8820-1-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

Changes in v3:
1. backlight: remove properties <brightness-levels>,<num-interpolated-steps>,
<default-brightness-level>, as the driver will compute a default table.

Changes in V2:
1. change the subject to format "dt-bindings: module: ..." for the documents. 
2. use new property <num-interpolated-steps> for backlight.
3. remove pinctrl of rk809, because the driver is not ready.

Liang Chen (4):
  dt-bindings: usb: dwc2: add description for px30
  dt-bindings: rockchip: grf: add grf and pmugrf description for px30
  arm64: dts: rockchip: add core dtsi file for PX30 SoCs
  arm64: dts: rockchip: add PX30 eavluation board devicetree

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    2 +
 Documentation/devicetree/bindings/usb/dwc2.txt     |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  470 +++++
 arch/arm64/boot/dts/rockchip/px30.dtsi             | 2043 ++++++++++++++++++++
 6 files changed, 2521 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30.dtsi

-- 
1.9.1
