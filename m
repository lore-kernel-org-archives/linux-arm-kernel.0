From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Thu, 18 Jan 2018 21:48:07 +0900
Subject: [PATCH 0/2] add ethernet nodes for UniPhier SoCs
Message-ID: <1516279689-3119-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds ethernet nodes for UniPhier Pro4, PXs2, LD6b, LD11, LD20 SoCs
and the boards.

Thank you,

---

Kunihiko Hayashi (2):
  ARM: dts: uniphier: add AVE ethernet node
  arm64: dts: uniphier: add AVE ethernet node

 arch/arm/boot/dts/uniphier-ld6b-ref.dts                | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pro4-ace.dts                | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pro4-ref.dts                | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pro4-sanji.dts              | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi                   | 12 ++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts             | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts              | 15 +++++++++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi                   | 12 ++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 15 +++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts    | 15 +++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 10 ++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    | 15 +++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 12 ++++++++++++
 14 files changed, 198 insertions(+)

-- 
2.7.4
