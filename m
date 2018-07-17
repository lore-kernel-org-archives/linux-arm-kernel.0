From: cl@rock-chips.com (cl at rock-chips.com)
Date: Tue, 17 Jul 2018 15:49:00 +0800
Subject: [PATCH v1 0/7] arm64: dts: rockchip: add basic dts file for PX30 SoCs
Message-ID: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

Liang Chen (7):
  Documentation: usb: dwc2: add description for px30
  Documentation: rockchip-dw-mshc: add description for px30
  Documentation: spi-rockchip: add description for px30
  Documentation: rockchip-i2s: add description for px30
  Documentation: rockchip: grf: add grf and pmugrf description for px30
  arm64: dts: rockchip: add core dtsi file for PX30 SoCs
  arm64: dts: rockchip: add PX30 eavluation board devicetree

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |    1 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    2 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    1 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |    1 +
 Documentation/devicetree/bindings/usb/dwc2.txt     |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  539 ++++++
 arch/arm64/boot/dts/rockchip/px30.dtsi             | 2044 ++++++++++++++++++++
 9 files changed, 2594 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30.dtsi

-- 
1.9.1
