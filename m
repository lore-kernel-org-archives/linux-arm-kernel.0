From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 30 Aug 2010 20:46:59 +0900
Subject: [PATCH 0/3] ARM: Samsung: Move/use the S3C/S5P common GPIO IRQ type
Message-ID: <20100830114659.GA13136@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29cfcddc0e745b515ec360ffe2ee4e7a4015efd8:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6 (2010-08-28 15:42:44 -0700)

Kyungmin Park (3):
      ARM: Samsung S5P: Move the common Samsung S5P series GPIO level type
      ARM: Samsung S5P: Use the Samsung S5P series common IRQ type
      ARM: Samsung S3C: Move/use the S3C common GPIO IRQ type

 arch/arm/mach-s3c64xx/irq-eint.c                  |   12 ++++++------
 arch/arm/mach-s5pc100/include/mach/regs-gpio.h    |    7 -------
 arch/arm/mach-s5pc100/irq-gpio.c                  |   16 +++++-----------
 arch/arm/mach-s5pv210/include/mach/regs-gpio.h    |    7 -------
 arch/arm/plat-s3c24xx/irq.c                       |   14 +++++++-------
 arch/arm/plat-s5p/irq-eint.c                      |   13 ++++++-------
 arch/arm/plat-samsung/include/plat/gpio-core.h    |   12 ++++++++++++
 arch/arm/plat-samsung/include/plat/regs-irqtype.h |   21 ---------------------
 8 files changed, 36 insertions(+), 66 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-irqtype.h
