From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue,  2 Oct 2018 20:11:58 +0900
Subject: [PATCH 0/4] Add UniPhier USB3 controller and USB2 phy nodes
Message-ID: <1538478722-20351-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the DT nodes for USB3 controllers and USB2 phys
implemented on UniPhier SoCs.

Kunihiko Hayashi (4):
  ARM: dts: uniphier: Add USB3 controller nodes
  ARM: dts: uniphier: Add USB2 phy nodes
  arm64: dts: uniphier: Add USB3 controller nodes
  arm64: dts: uniphier: Add USB2 phy nodes

 arch/arm/boot/dts/uniphier-pro4-ace.dts            |   8 +
 arch/arm/boot/dts/uniphier-pro4-ref.dts            |   8 +
 arch/arm/boot/dts/uniphier-pro4.dtsi               | 127 +++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts         |   8 +
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts          |   4 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi               | 180 ++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |  27 +++
 .../boot/dts/socionext/uniphier-ld20-global.dts    |   4 +
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |   4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 194 +++++++++++++++++
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   8 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 240 +++++++++++++++++++++
 12 files changed, 812 insertions(+)

-- 
2.7.4
