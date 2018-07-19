From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu, 19 Jul 2018 15:23:26 +0900
Subject: [PATCH 0/3] Add SPI dts node for UniPhier SoCs
Message-ID: <1531981409-28396-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds SPI pin-mux node and SPI node for UniPhier SoCs.

Kunihiko Hayashi (3):
  ARM: dts: uniphier: add SPI pin-mux node
  ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
  arm64: dts: uniphier: add SPI node for LD20, LD11 and PXs3

 arch/arm/boot/dts/uniphier-ld4.dtsi              | 11 ++++++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi          | 20 +++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi             | 22 ++++++++++++
 arch/arm/boot/dts/uniphier-pro5.dtsi             | 33 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi             | 22 ++++++++++++
 arch/arm/boot/dts/uniphier-sld8.dtsi             | 11 ++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 22 ++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 44 ++++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 22 ++++++++++++
 9 files changed, 207 insertions(+)

-- 
2.7.4
