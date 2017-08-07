From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 7 Aug 2017 16:41:24 +0100
Subject: [PATCH v2 1/3] mfd: syscon: update Atmel SMC binding doc
In-Reply-To: <20170718132220.25018-2-ludovic.desroches@microchip.com>
References: <20170718132220.25018-1-ludovic.desroches@microchip.com>
 <20170718132220.25018-2-ludovic.desroches@microchip.com>
Message-ID: <20170807154124.norjlxavx4u75yzs@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enjoy!

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-arm-v4.14

for you to fetch changes up to 5df46ec0f4cf3b2cb0791abe5c68821a4f7ffffe:

  ARM: dts: at91: sama5d2: Use sama5d2 compatible string for SMC (2017-08-07 16:38:30 +0100)

----------------------------------------------------------------
Immutable branch between MFD and ARM due for the v4.14 merge window

----------------------------------------------------------------
Ludovic Desroches (3):
      mfd: syscon: Update Atmel SMC binding doc
      mfd: syscon: atmel-smc: Add helper to retrieve register layout
      ARM: dts: at91: sama5d2: Use sama5d2 compatible string for SMC

 .../devicetree/bindings/mfd/atmel-smc.txt          |  1 +
 arch/arm/boot/dts/sama5d2.dtsi                     |  2 +-
 drivers/memory/atmel-ebi.c                         | 13 +++--
 drivers/mfd/atmel-smc.c                            | 67 +++++++++++++++++-----
 drivers/mtd/nand/atmel/nand-controller.c           | 10 +++-
 include/linux/mfd/syscon/atmel-smc.h               | 32 ++++++++---
 
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
