From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  7 May 2015 13:32:34 +0900
Subject: [PATCH v6 0/4] ARM: SoC: add a new platform,
 UniPhier (arch/arm/mach-uniphier)
Message-ID: <1430973158-12264-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is an initial series for supporting Socionext UniPhier SoCs,
based on ARM Cortex-A9, mainly used for digital TVs, video recorders, etc.


Masahiro Yamada (4):
  ARM: UniPhier: add basic support for UniPhier architecture
  ARM: multi_v7_defconfig: enable UniPhier SoC family
  ARM: dts: UniPhier: add support for UniPhier SoCs and boards
  MAINTAINERS: add myself as ARM/UniPhier maintainer

 MAINTAINERS                                  |   7 ++
 arch/arm/Kconfig                             |   2 +
 arch/arm/Makefile                            |   1 +
 arch/arm/boot/dts/Makefile                   |   5 ++
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts   |  79 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi      | 110 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts  |  79 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi     | 117 +++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts  |  80 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi     | 117 +++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts  |  79 ++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi     | 110 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-support-card.dtsi |  66 +++++++++++++++
 arch/arm/configs/multi_v7_defconfig          |   1 +
 arch/arm/mach-uniphier/Kconfig               |  11 +++
 arch/arm/mach-uniphier/Makefile              |   2 +
 arch/arm/mach-uniphier/platsmp.c             |  90 +++++++++++++++++++++
 arch/arm/mach-uniphier/uniphier.c            |  30 +++++++
 18 files changed, 986 insertions(+)
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
 create mode 100644 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-support-card.dtsi
 create mode 100644 arch/arm/mach-uniphier/Kconfig
 create mode 100644 arch/arm/mach-uniphier/Makefile
 create mode 100644 arch/arm/mach-uniphier/platsmp.c
 create mode 100644 arch/arm/mach-uniphier/uniphier.c

-- 
1.9.1
