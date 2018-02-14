From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 14 Feb 2018 18:30:27 +0900
Subject: [PATCH v2 0/2] add ethernet nodes for UniPhier SoCs
Message-ID: <1518600629-14317-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds ethernet nodes for UniPhier Pro4, PXs2, LD6b, LD11, LD20 SoCs
and the boards.

Changes since v1:
- move common descriptions to .dtsi files
- rename labels of the ethernet nodes to "eth"

Kunihiko Hayashi (2):
  ARM: dts: uniphier: add AVE ethernet node
  arm64: dts: uniphier: add AVE ethernet node

 arch/arm/boot/dts/uniphier-ld6b-ref.dts                | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4-ace.dts                | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4-ref.dts                | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4-sanji.dts              | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi                   | 18 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts             | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts              | 11 +++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi                   | 18 ++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 11 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts    | 11 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 16 ++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 13 +++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    | 11 +++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 18 ++++++++++++++++++
 14 files changed, 182 insertions(+)

-- 
2.7.4
