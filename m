From: hong.xu@atmel.com (Hong Xu)
Date: Thu, 12 Apr 2012 14:26:32 +0800
Subject: [PATCH 0/4] Add support for Atmel's AT91SAM9N12-EK (With DT)
Message-ID: <1334211996-31572-1-git-send-email-hong.xu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Atmel's AT91SAM9N12-EK.

Patches are on top of v3.4-rc2 and target for v3.5

Hong Xu (4):
  AT91: Add DT description files for AT91SAM9N12-EK
  AT91: Add machine header file for AT91SAM9N12 SoC
  AT91: Add machine files for AT91SAM9N12 SoC
  Add default kernel configuration file for AT91SAM9N12-EK

 arch/arm/boot/dts/at91sam9n12.dtsi                 |  223 +++
 arch/arm/boot/dts/at91sam9n12ek.dts                |  111 ++
 arch/arm/configs/at91sam9n12ek_defconfig           | 1862 ++++++++++++++++++++
 arch/arm/mach-at91/Kconfig                         |    9 +
 arch/arm/mach-at91/Makefile                        |    1 +
 arch/arm/mach-at91/at91sam9n12.c                   |  275 +++
 arch/arm/mach-at91/board-dt.c                      |    1 +
 arch/arm/mach-at91/clock.c                         |   15 +-
 arch/arm/mach-at91/include/mach/at91sam9n12.h      |   68 +
 .../mach-at91/include/mach/at91sam9n12_matrix.h    |   53 +
 arch/arm/mach-at91/include/mach/cpu.h              |   10 +
 arch/arm/mach-at91/include/mach/hardware.h         |    2 +
 arch/arm/mach-at91/setup.c                         |    6 +
 arch/arm/mach-at91/soc.h                           |    5 +
 14 files changed, 2636 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9n12.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9n12ek.dts
 create mode 100644 arch/arm/configs/at91sam9n12ek_defconfig
 create mode 100644 arch/arm/mach-at91/at91sam9n12.c
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12.h
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12_matrix.h

-- 
1.7.3.3
