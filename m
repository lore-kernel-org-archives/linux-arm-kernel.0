From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 28 Feb 2012 12:20:25 +0800
Subject: [GIT PULL][v3.4] pull request of board-specific branch in pxa git tree
Message-ID: <CAN1soZyTz57eOPucSBathHUQcK-Lk21uX292eyOXt6bmkfS4Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please help to pull board-specific branch in pxa git tree.

The following changes since commit 6b21d18ed50c7d145220b0724ea7f2613abf0f95:

  Linux 3.3-rc5 (2012-02-25 12:18:16 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git board-specific

Haojian Zhuang (2):
      ARM: mmp: append irq name of gpio device
      ARM: pxa: add dummy clock for pxa25x and pxa27x

Paul Parsons (3):
      pxa/hx4700: Correct StrataFlash block size discovery
      pxa/hx4700: Add ASIC3 LED support
      pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values

 arch/arm/Kconfig           |    1 +
 arch/arm/mach-mmp/mmp2.c   |    1 +
 arch/arm/mach-mmp/pxa168.c |    1 +
 arch/arm/mach-mmp/pxa910.c |    1 +
 arch/arm/mach-pxa/hx4700.c |   27 +++++++++++++++++++++------
 arch/arm/mach-pxa/pxa25x.c |    1 +
 arch/arm/mach-pxa/pxa27x.c |    1 +
 7 files changed, 27 insertions(+), 6 deletions(-)
