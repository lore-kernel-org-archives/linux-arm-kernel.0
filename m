From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:22:10 +0000
Subject: [PATCH 01/12] ARM: S3C24XX: Define a macro to avoid compilation
	error
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <20091028122208.GC31509@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series should have had the following prefix:

S3C64XX/S3C24XX fixes based on -rc5.

shortlog:

Ben Dooks (9):
      ARM: S3C2410: Fix link if CONFIG_S3C2410_IOTIMING is not set
      ARM: S3C: Add info for supporting circular DMA buffers
      Merge branch 'fixes-s3c24xx' into fixes-s3c
      Merge branch 'fixes-s3c64xx-dma' into fixes-s3c
      Merge branch 'fixes-s3c64xx' into fixes-s3c
      ARM: S3C2440: mini2440: Fix missing CONFIG_S3C_DEV_USB_HOST
      ARM: S3C24XX: Fix warnings in arch/arm/plat-s3c24xx/gpio.c
      ARM: S3C2440: mini2440: Fix spare warnings
      ARM: S3C2410: Fix sparse warnings in arch/arm/mach-s3c2410/gpio.c

Harald Welte (1):
      ARM: S3C24XX: Introduce S3C2442B CPU

Julia Lawall (1):
      ARM: S3C24XX: arch/arm/plat-s3c24xx: Move dereference after NULL test

Kukjin Kim (1):
      ARM: S3C64XX: Fix S3C64XX_CLKDIV0_ARM_MASK value

Mark Brown (1):
      ARM: S3C64XX: Set rate of crystal mux

Ramax Lo (1):
      ARM: S3C24XX: Define a macro to avoid compilation error

Ryan Mallon (1):
      ARM: S3C: Fix adc function exports

 arch/arm/mach-s3c2410/gpio.c                       |    1 +
 arch/arm/mach-s3c2410/include/mach/dma.h           |    7 +++++++
 arch/arm/mach-s3c2440/Kconfig                      |    1 +
 arch/arm/mach-s3c2440/mach-mini2440.c              |    4 ++--
 arch/arm/mach-s3c6400/include/mach/dma.h           |    5 +++++
 arch/arm/plat-s3c24xx/adc.c                        |    2 +-
 arch/arm/plat-s3c24xx/cpu.c                        |   10 ++++++++++
 arch/arm/plat-s3c24xx/dma.c                        |    6 +++---
 arch/arm/plat-s3c24xx/gpio.c                       |    1 +
 arch/arm/plat-s3c24xx/include/plat/cpu-freq-core.h |    9 +++++++--
 arch/arm/plat-s3c24xx/include/plat/s3c2410.h       |    1 +
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h    |    4 ++--
 arch/arm/plat-s3c64xx/s3c6400-clock.c              |    3 +++
 sound/soc/s3c24xx/s3c24xx-pcm.c                    |   17 +++++++++++++++--
 14 files changed, 59 insertions(+), 12 deletions(-)

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
