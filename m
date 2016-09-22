From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 23 Sep 2016 00:22:04 +0200
Subject: [PATCH 0/4] ARM: at91: initial samx7 support
Message-ID: <20160922222208.23798-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds initial support for Atmel armv7m SoCs.
Most of the work has been done and tested by Andr?s, thanks!

Alexandre Belloni (1):
  ARM: at91: handle CONFIG_PM for armv7m configurations

Szemz? Andr?s (3):
  ARM: at91: Add armv7m support
  ARM: dts: at91: add samx7 dtsi
  ARM: at91: debug: add samx7 support

 arch/arm/Kconfig.debug           |   10 +
 arch/arm/boot/dts/samx7.dtsi     | 1166 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Kconfig       |   15 +-
 arch/arm/mach-at91/Makefile      |    4 +-
 arch/arm/mach-at91/Makefile.boot |    3 +
 arch/arm/mach-at91/samx7.c       |   72 +++
 arch/arm/mach-at91/soc.h         |   21 +
 7 files changed, 1288 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/samx7.dtsi
 create mode 100644 arch/arm/mach-at91/Makefile.boot
 create mode 100644 arch/arm/mach-at91/samx7.c

-- 
2.9.3
