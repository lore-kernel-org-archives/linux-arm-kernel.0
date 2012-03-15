From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 15 Mar 2012 17:08:29 +0000
Subject: [GIT PULL] [for v3.4] Pull request containing ux500 DT enablement
Message-ID: <4F62220D.1090106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fff9a13341312c8d0f06e04c1345e855528b03da:

  ARM: ux500: CONFIG: Enable Device Tree support for future endeavours (2012-03-15 16:33:54 +0000)

are available in the git repository at:
  git://git.linaro.org/people/ljones/linux-3.0-ux500.git device-tree-snowball-ux500

Arnd Bergmann (3):
      ARM: ux500: Initial Device Tree support for Snowball
      ARM: ux500: combine the board init functions for DT boot
      ARM: ux500: split dts file for snowball into generic part

Lee Jones (5):
      ARM: ux500: db8500: list most devices in the snowball device tree
      ARM: ux500: Enable Cortex-A9 GIC (Generic Interrupt Controller) in Device Tree
      ARM: ux500: Enable PL011 AMBA UART Controller for Device Tree
      ARM: ux500: Enable PL310 Level 2 Cache Controller in Device Tree
      ARM: ux500: Enable PL022 SSP Controller in Device Tree

 arch/arm/boot/dts/db8500.dtsi      |  269 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts     |  139 +++++++++++++++++++
 arch/arm/mach-ux500/Makefile.boot  |    1 +
 arch/arm/mach-ux500/board-mop500.c |   99 +++++++++++++-
 arch/arm/mach-ux500/cache-l2x0.c   |    7 +-
 arch/arm/mach-ux500/cpu.c          |   12 ++-
 6 files changed, 523 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/db8500.dtsi
 create mode 100644 arch/arm/boot/dts/snowball.dts


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515 
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
