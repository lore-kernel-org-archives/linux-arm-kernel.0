From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 03 Feb 2012 15:35:08 +0100
Subject: [GIT PULL] at91: devices and boards files update for 3.4
Message-ID: <4F2BF09C.3040208@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the "rebased" devices and boards update material that did not make it during 3.3 merge window. Like any other AT91 patch series for 3.4, it is based on top of the at91-3.4-base branch (that includes the "CAP9 removal" patch on top of 3.3-rc2 + depends/rmk/for-armsoc).

The following changes since commit 9918ceafd4a9e013572e03983f528017c29bb1cb:

  ARM: at91: code removal of CAP9 SoC (2012-02-03 13:33:05 +0100)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git at91-3.4-base+device_board

Hong Xu (1):
      ARM: at91: Update struct atmel_nand_data to support PMECC

Josh Wu (2):
      ARM: at91: add clock selection parameter for at91_add_device_isi()
      ARM: at91: add Atmel ISI and ov2640 support on sam9m10g45 board

Maxim Osipov (1):
      ARM: at91: Add external RTC for Flexibity board

Nicolas Ferre (2):
      ARM: at91/dma: remove platform data from DMA controller
      ARM: at91/dma: DMA controller registering with DT support

 arch/arm/mach-at91/at91sam9263_devices.c |   13 +++-
 arch/arm/mach-at91/at91sam9g45_devices.c |  113 +++++++++++++++++++++++++++---
 arch/arm/mach-at91/at91sam9rl_devices.c  |    8 +--
 arch/arm/mach-at91/board-flexibity.c     |   12 +++-
 arch/arm/mach-at91/board-sam9m10g45ek.c  |   80 ++++++++++++++++++++-
 arch/arm/mach-at91/include/mach/board.h  |    6 ++-
 6 files changed, 209 insertions(+), 23 deletions(-)

Thanks, best regards,
-- 
Nicolas Ferre
