From: josh.wu@atmel.com (Josh Wu)
Date: Tue,  5 Nov 2013 14:58:07 +0800
Subject: [PATCH 0/2] ARM: at91: sama5d3: add sama5d36ek support 
Message-ID: <1383634689-15343-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add support for sama5d36 in sama5d3x family.
It also add a dts file for sama5d36ek board.

Josh Wu (2):
  ARM: at91: sama5d3: add support for sama5d36 chip
  ARM: at91: sama5d3/dt: add sama5d36ek dts file

 arch/arm/boot/dts/Makefile            |    1 +
 arch/arm/boot/dts/sama5d3.dtsi        |    2 +-
 arch/arm/boot/dts/sama5d36ek.dts      |   52 +++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Kconfig            |    2 +-
 arch/arm/mach-at91/include/mach/cpu.h |    3 +-
 arch/arm/mach-at91/sama5d3.c          |    7 ++---
 arch/arm/mach-at91/setup.c            |    4 +++
 7 files changed, 64 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/sama5d36ek.dts

-- 
1.7.10
