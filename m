From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Apr 2015 16:40:34 +0900
Subject: [PATCH 0/4] ARM: SoC: add a new platform,
 UniPhier (arch/arm/mach-uniphier)
Message-ID: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is an initial series for supporting Socionext UniPhier SoCs,
based on ARM Cortex-A9, mainly used for digital TVs, video recorders, etc.



Masahiro Yamada (4):
  ARM: UniPhier: add basic support for UniPhier architecture
  ARM: multi_v7_defconfig: enable UniPhier SoC family
  ARM: dts: UniPhier: add support for UniPhier SoCs and boards
  MAINTAINERS: add myself as ARM/UniPhier maintainer

 MAINTAINERS                                  |  7 +++
 arch/arm/Kconfig                             |  2 +
 arch/arm/Makefile                            |  1 +
 arch/arm/boot/dts/Makefile                   |  5 ++
 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts   | 51 +++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi      | 78 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts  | 51 +++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi     | 85 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts  | 52 +++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi     | 85 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts  | 51 +++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi     | 78 +++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-support-card.dtsi | 39 +++++++++++++
 arch/arm/configs/multi_v7_defconfig          |  1 +
 arch/arm/mach-uniphier/Kconfig               | 11 ++++
 arch/arm/mach-uniphier/Makefile              |  2 +
 arch/arm/mach-uniphier/headsmp.S             | 21 +++++++
 arch/arm/mach-uniphier/platsmp.c             | 78 +++++++++++++++++++++++++
 arch/arm/mach-uniphier/uniphier.c            | 31 ++++++++++
 19 files changed, 729 insertions(+)
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
 create mode 100644 arch/arm/mach-uniphier/headsmp.S
 create mode 100644 arch/arm/mach-uniphier/platsmp.c
 create mode 100644 arch/arm/mach-uniphier/uniphier.c

-- 
1.9.1
