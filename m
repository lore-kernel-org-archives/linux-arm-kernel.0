From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 18:25:37 +0200
Subject: ARM: SoC fixes for 3.10-rc
Message-ID: <201306211825.37495.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 323226bbb3d865af12644d66df2b7f161adf51c7:

  Merge tag 'fixes-3.10-4' of git://git.infradead.org/users/jcooper/linux into fixes (2013-06-11 17:05:56 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 8b6fd652641e5ab1892d092e73e83d49291ed638:

  irqchip: gic: call gic_cpu_init() as well in CPU_STARTING_FROZEN case (2013-06-20 14:52:23 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 3.10-rc

These are two fixes that came in this week, one for a regression we
introduced in 3.10 in the GIC interrupt code, and the other one
fixes a typo in newly introduced code.

----------------------------------------------------------------
Padmavathi Venna (1):
      ARM: dts: Correct the base address of pinctrl_3 on Exynos5250

Shawn Guo (1):
      irqchip: gic: call gic_cpu_init() as well in CPU_STARTING_FROZEN case

 arch/arm/boot/dts/exynos5250-pinctrl.dtsi | 2 +-
 arch/arm/boot/dts/exynos5250.dtsi         | 4 ++--
 drivers/irqchip/irq-gic.c                 | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
