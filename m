From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 3 Oct 2018 15:45:53 +0200
Subject: [GIT PULL] ARM: at91: DT for 4.20 #2
Message-ID: <20181003134553.aqbogomrxqmpgpmo@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are the second round of DT changes for 4.20. It consists in NAND
description fixes (size and partitions).

Regards

Ludovic

The following changes since commit 97181516b0785dd032700ae4899842389c6bea78:

  arm: dts: sama5d2: Update coresight bindings for hardware ports (2018-09-19 19:12:25 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-dt2

for you to fetch changes up to 767466b63de3368376323958b7777b9319bfa8d8:

  ARM: dts: at91: sama5d4_xplained: even nand memory partitions (2018-10-03 10:26:57 +0200)

----------------------------------------------------------------
AT91 DT for 4.20 #2

 - fixes NAND size and partitions for some boards

----------------------------------------------------------------
Tudor Ambarus (6):
      ARM: dts: at91: sama5d4_xplained: fix addressable nand flash size
      ARM: dts: at91: at91sam9x5cm: fix addressable nand flash size
      ARM: dts: at91: sama5d2_ptc_ek: fix bootloader env offsets
      ARM: dts: at91: at91sam9x5cm: even nand memory partitions
      ARM: dts: at91: sama5d3_xplained: even nand memory partitions
      ARM: dts: at91: sama5d4_xplained: even nand memory partitions

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   |  8 ++++----
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 11 ++++++++---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 13 +++++++++----
 arch/arm/boot/dts/at91sam9x5cm.dtsi         | 18 ++++++++++++++----
 4 files changed, 35 insertions(+), 15 deletions(-)
