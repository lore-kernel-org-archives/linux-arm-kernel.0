From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 14 Jun 2016 11:59:43 +0900
Subject: [PATCH 0/3] ARM: dts: uniphier: UniPhier DTS updates (32bit) for
 v4.8-rc1
Message-ID: <1465873186-30658-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




Masahiro Yamada (3):
  ARM: dts: uniphier: add System Bus pinmux node
  ARM: dts: uniphier: add SoC-Glue node to UniPhier 32bit SoCs
  ARM: dts: uniphier: renumber serial aliases for Gentil/Vodka boards

 arch/arm/boot/dts/uniphier-common32.dtsi          | 12 +++++++++---
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi           |  2 +-
 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi          |  2 +-
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi          |  2 +-
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi          |  2 +-
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi          |  2 +-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi           |  5 +++++
 arch/arm/boot/dts/uniphier-proxstream2-gentil.dts |  8 ++++----
 arch/arm/boot/dts/uniphier-proxstream2-vodka.dts  |  8 ++++----
 arch/arm/boot/dts/uniphier-proxstream2.dtsi       |  2 +-
 10 files changed, 28 insertions(+), 17 deletions(-)

-- 
1.9.1
