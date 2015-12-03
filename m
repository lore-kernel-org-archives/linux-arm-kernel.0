From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  3 Dec 2015 15:33:55 +0900
Subject: [PATCH 0/2] ARM: dts: uniphier: clean up DTSIs by factoring the
 common parts out
Message-ID: <1449124437-18479-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Masahiro Yamada (2):
  ARM: dts: uniphier: change IRQ number of UART3 of PH1-Pro4 SoC
  ARM: dts: uniphier: factor out common nodes to uniphier-common32.dtsi

 arch/arm/boot/dts/uniphier-common32.dtsi    | 135 +++++++++++++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     | 265 +++++++++----------------
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    | 288 ++++++++++------------------
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi    | 274 +++++++++-----------------
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    | 266 +++++++++----------------
 arch/arm/boot/dts/uniphier-proxstream2.dtsi | 269 +++++++++-----------------
 6 files changed, 605 insertions(+), 892 deletions(-)
 create mode 100644 arch/arm/boot/dts/uniphier-common32.dtsi

-- 
1.9.1
