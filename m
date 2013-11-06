From: josh.wu@atmel.com (Josh Wu)
Date: Wed,  6 Nov 2013 10:31:09 +0800
Subject: [PATCH v2 0/2] ARM: at91: sama5d3: add sama5d36ek support 
Message-ID: <1383705071-7332-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for sama5d36 in sama5d3x family.
It also adds the dts & dtsi file for sama5d36ek board.

v1 --> v2:
  base on the at91-3.13-cleanup tree.
  add a new sama5d36.dtsi to include the splitted peripherals.

Josh Wu (2):
  ARM: at91: sama5d3: add support for sama5d36 chip
  ARM: at91: sama5d3/dt: add sama5d36ek dts files

 arch/arm/boot/dts/Makefile            |    1 +
 arch/arm/boot/dts/sama5d3.dtsi        |    2 +-
 arch/arm/boot/dts/sama5d36.dtsi       |   19 +++++++++++++
 arch/arm/boot/dts/sama5d36ek.dts      |   53 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Kconfig            |    2 +-
 arch/arm/mach-at91/include/mach/cpu.h |    3 +-
 arch/arm/mach-at91/sama5d3.c          |    7 ++---
 arch/arm/mach-at91/setup.c            |    4 +++
 8 files changed, 84 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/sama5d36.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d36ek.dts

-- 
1.7.10
