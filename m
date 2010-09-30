From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 13:48:14 +0900
Subject: [PATCH 0/7] ARM: S5PC210: I2C devices support and Universal board
	updates
Message-ID: <20100930044814.GA16892@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit aff078a9da27e0effb2a149834089e5788943d4b:
  Marek Szyprowski (1):
        ARM: S5PV210: Enable USB HSOTG gadget build

Kyungmin Park (7):
      ARM: S5PC210: Universal OneNAND support
      ARM: S5PC110: Fix wrong interrupt I2C2 number
      ARM: Samsung: Use the correct I2C2 interrupt
      ARM: S5PC210: I2C1/2 support
      ARM: S5PC210: I2C0/1 devices support on Universal board
      ARM: S5PC210: Define the more I2C{3,4,5,6,7} address & interrupt
      ARM: S5PC210: I2C{3, 4, 5, 6, 7} device support

 arch/arm/mach-s5pv210/include/mach/irqs.h   |    4 +-
 arch/arm/mach-s5pv310/Kconfig               |   18 +++++++
 arch/arm/mach-s5pv310/Makefile              |    5 ++
 arch/arm/mach-s5pv310/include/mach/irqs.h   |    7 +++
 arch/arm/mach-s5pv310/include/mach/map.h    |   11 ++++-
 arch/arm/mach-s5pv310/mach-universal_c210.c |   16 ++++++
 arch/arm/mach-s5pv310/setup-i2c3.c          |   25 ++++++++++
 arch/arm/mach-s5pv310/setup-i2c4.c          |   25 ++++++++++
 arch/arm/mach-s5pv310/setup-i2c5.c          |   25 ++++++++++
 arch/arm/mach-s5pv310/setup-i2c6.c          |   25 ++++++++++
 arch/arm/mach-s5pv310/setup-i2c7.c          |   25 ++++++++++
 arch/arm/plat-s5p/Kconfig                   |   25 ++++++++++
 arch/arm/plat-s5p/Makefile                  |    5 ++
 arch/arm/plat-s5p/dev-i2c3.c                |   67 +++++++++++++++++++++++++++
 arch/arm/plat-s5p/dev-i2c4.c                |   67 +++++++++++++++++++++++++++
 arch/arm/plat-s5p/dev-i2c5.c                |   67 +++++++++++++++++++++++++++
 arch/arm/plat-s5p/dev-i2c6.c                |   67 +++++++++++++++++++++++++++
 arch/arm/plat-s5p/dev-i2c7.c                |   67 +++++++++++++++++++++++++++
 arch/arm/plat-samsung/dev-i2c2.c            |    4 +-
 arch/arm/plat-samsung/include/plat/iic.h    |    5 ++
 20 files changed, 554 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c3.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c4.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c5.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c6.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c7.c
 create mode 100644 arch/arm/plat-s5p/dev-i2c3.c
 create mode 100644 arch/arm/plat-s5p/dev-i2c4.c
 create mode 100644 arch/arm/plat-s5p/dev-i2c5.c
 create mode 100644 arch/arm/plat-s5p/dev-i2c6.c
 create mode 100644 arch/arm/plat-s5p/dev-i2c7.c
