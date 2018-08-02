From: heiko@sntech.de (Heiko Stuebner)
Date: Thu,  2 Aug 2018 15:01:30 +0200
Subject: [PATCH 0/3] add dwc2 support for px30
Message-ID: <20180802130133.4898-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is split out from the series adding the px30 support, due to
the dwc2 binding change not having landed yet in a maintainer tree.

The Acked binding change should go through some usb tree, while
I'll pick up the dts changes once that has happened.

The binding itself is unchanged.


Heiko Stuebner (2):
  arm64: dts: rockchip: add dwc2 otg controller on px30
  arm64: dts: rockchip: enable dwc2-based otg controller on px30-evb

Liang Chen (1):
  dt-bindings: usb: dwc2: add description for px30

 Documentation/devicetree/bindings/usb/dwc2.txt |  1 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts      |  4 ++++
 arch/arm64/boot/dts/rockchip/px30.dtsi         | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

-- 
2.17.0
