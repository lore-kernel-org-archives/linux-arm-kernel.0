From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  4 Aug 2015 20:21:01 +0900
Subject: [PATCH 0/3] Device Tree updates of UniPhier SoCs for Linux 4.3
Message-ID: <1438687264-26538-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,


Here are a little more updates for device trees for UniPhier SoCs.

Please consider applying this series to your ARM-SOC tree.

Thanks!



Masahiro Yamada (3):
  ARM: dts: UniPhier: add I2C controller device nodes
  ARM: dts: UniPhier: add PH1-Pro5 SoC support
  ARM: dts: UniPhier: add ProXstream2 and PH1-LD6b SoC/board support

 arch/arm/boot/dts/Makefile                  |   3 +-
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts  |   8 +
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     |  58 ++++++
 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts | 105 +++++++++++
 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi    |  67 +++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts |  10 +
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    |  82 +++++++++
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi    | 252 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts |   9 +
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi    |  61 +++++++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts |   8 +
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    |  58 ++++++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi     |  20 ++
 arch/arm/boot/dts/uniphier-proxstream2.dtsi | 273 ++++++++++++++++++++++++++++
 14 files changed, 1013 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-proxstream2.dtsi

-- 
1.9.1
