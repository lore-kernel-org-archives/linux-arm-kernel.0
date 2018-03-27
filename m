From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 27 Mar 2018 19:32:44 +0900
Subject: [PATCH 0/2] add ethernet nodes for UniPhier PXs3 SoC
Message-ID: <1522146766-14435-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds ethernet nodes for UniPhier PXs3 SoC and the board,
and adds pinctrl groups for second ethernet instances because PXs3 has two
ethernet instances.

Kunihiko Hayashi (2):
  ARM: dts: uniphier: add pinctrl groups of ethernet for second instance
  arm64: dts: uniphier: add ethernet node for PXs3

 arch/arm/boot/dts/uniphier-pinctrl.dtsi            | 10 ++++++
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts | 22 +++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   | 36 ++++++++++++++++++++++
 3 files changed, 68 insertions(+)

-- 
2.7.4
