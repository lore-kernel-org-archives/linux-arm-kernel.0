From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 20:50:50 +0800
Subject: [PATCH 0/3] Allwinner A64 EHCI0/OHCI0 devicetree change
Message-ID: <20170405125053.6170-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains devicetree parts of the EHCI0/OHCI0 controllers
on A64 SoC.

The first patch is a devicetree binding change, which has been planned
for 4.12; however, as Maxime Ripard suggested, it should go in 4.11
as it's part of the device's description.

The second patch added pmu0 regs and EHCI/OHCI controllers for USB0.

The third patch enabled EHCI0/OHCI0 for Pine64 board.

This patchset should go in 4.11 as Maxime Ripard suggested.

Icenowy Zheng (3):
  dt: bindings: add pmu0 regs for USB PHYs on Allwinner H3/V3s/A64
  arm64: allwinner: a64: add USB0 OHCI/EHCI related devicetree parts
  arm64: allwinner: a64: enable EHCI0/OHCI0 controller for Pine64

 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  1 +
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  8 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 24 ++++++++++++++++++++++
 3 files changed, 33 insertions(+)

-- 
2.12.2
