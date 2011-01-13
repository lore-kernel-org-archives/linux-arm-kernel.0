From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jan 2011 14:30:01 +0900
Subject: [GIT PULL] Samsung S5P for 2.6.38 merge window
Message-ID: <021901cbb2e2$ef4a0630$cdde1290$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please pull Samsung S5P updates from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk

These things are for 2.6.38.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 387c31c7e5c9805b0aef8833d1731a5fe7bdea14

  Linux 2.6.37-rc8

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk

Abhilash Kesavan (3):
      ARM: S5P64X0: Change GPIOlib initialization to core_initcall
      ARM: S5P6440: Change the name for MMC Special Clock
      ARM: S3C24XX: Add support UART3 for S3C2443 and S3C2416

Amit Daniel Kachhap (1):
      ARM: SAMSUNG: Add support for clock debugging through debug-fs
interface

Atul Dahiya (1):
      ARM: S5P64X0: Add clock support for RTC

Changhwan Youn (6):
      ARM: S5PV310: Add Interrupt of MCT
      ARM: S5PV310: Limit the irqs which support cascade interrupt
      ARM: S5PV310: Add irq_mask to handle combiner irqs properly
      ARM: SAMSUNG: Add support for Power Domain control
      ARM: S5PV310: Set bit 22 in the PL310 (cache controller) AuxCtlr
register
      ARM: S5PV310: Add support Power Domain

Darius Augulis (1):
      serial: samsung: fix device name

Donguk Ryu (2):
      ARM: S5P: Add Support System MMU
      ARM: S5PV310: Add Support System MMU

Jaecheol Lee (1):
      ARM: S5PV310: Add FOUT APLL get rate function

Jassi Brar (25):
      ARM: S5PV310: Add platform devices for PL330 DMACs
      ARM: SAMSUNG: Rename s3c64xx I2S platform device
      ARM: SAMSUNG: Prepare audio header for new I2S driver
      ARM: S3C64XX: Upgrade platform device for I2S
      ARM: S5P64X0: Upgrade platform device for I2S
      ARM: S5P6442: Upgrade platform device for I2S
      ARM: S5PC100: Upgrade platform device for I2S
      ARM: S5PV210: Upgrade platform device for I2S
      ARM: S5PV310: Add audio platform devices
      ARM: S5P6442: Implement i2c-gpio config
      ARM: S5P6442: Enable I2C0 device on SMDK6442
      ARM: S5P6450: Define clocks for I2S
      ARM: S5P6450: Define base addresses for I2S
      ARM: S5P6440: Enable I2S device to work on SMDK6440
      ARM: S5P6450: Enable I2S device to work on SMDK6450
      ARM: S5PV210: Enable I2S device to work on SMDKC110
      ARM: S5PV210: Enable I2S device to work on SMDKV210
      ARM: S5PV310: Enable I2C1 device
      ARM: S5PV310: Add PDMA clocks
      ARM: S5PV310: Add AC97 clock
      ARM: S5PV310: Define I2S clocks
      ARM: S5PV310: Add AC97 support for SMDK
      ARM: S5PV310: Enable I2S device on SMDKV310
      ARM: S5PV310: Enable I2S device on SMDKC210
      ARM: S3C64XX: Clear DMA_HALT upon start

Kukjin Kim (26):
      Merge branch 'next-samsung-asoc' into next-samsung-asoc2
      ARM: S5P64X0: Add GPIOlib support for S5P6450
      ARM: SAMSUNG: Cleanup GPIOlib adding 2bit chips
      ARM: S5P64X0: Cleanup S5P64X0 GPIOlib adding 2bit chips
      ARM: S5P64X0: Rename GPIOlib file to gpiolib.c
      ARM: S5P: Move the SROM register definitions to plat-s5p
      Merge branch 'next-samsung-asoc2' into for-next-new
      Merge branch 'next-samsung' into for-next-new
      Merge branch 'next-s5p' into for-next-new
      Merge branch 'next-s5p64x0' into for-next-new
      Merge branch 'next-s5pv210' into for-next-new
      Merge branch 'dev/s5pv310-irq' into next-s5pv310
      Merge branch 'next-s5pv310' into for-next
      Merge branch 'dev/s5pv310-cpufreq' into next-s5pv310
      Merge branch 'next-s5pv310' into for-next
      Merge branch 'next-samsung-irq_data' into for-next
      Merge branch 'next-s3c64xx' into for-next
      ARM: S3C64XX: Tidy register and disable clock usage
      ARM: S5P6440: Tidy register and disable clock usage
      ARM: S5P6442: Tidy register and disable clock usage
      ARM: S5P6450: Tidy register and disable clock usage
      ARM: S5PC100: Tidy register and disable clock usage
      ARM: S5PV210: Tidy init+disable clock usage and
s3c24xx_register_clocks cleanup
      ARM: S5PV310: Tidy init+disable clock usage and
s3c24xx_register_clocks cleanup
      Merge branch 'dev/cleanup-clocks' into for-next
      Merge branch 'next-s3c24xx' into for-next

Kyungmin Park (1):
      ARM: S5PV310: Universal SDHCI devices support

Lennert Buytenhek (3):
      ARM: S3C24XX: irq_data conversion
      ARM: S5P: irq_data conversion
      ARM: SAMSUNG: some GENERIC_HARDIRQS_NO_DEPRECATED build fixes

Mark Brown (5):
      ARM: SAMSUNG: Convert s3c_irqext_wake() to new irq_ interrupt methods
      ARM: S3C64XX: Convert S3C64xx irq-eint to use new irq_ methods
      ARM: S3C64XX: Use chip_data to store the shift for EINTs
      ARM: SAMSUNG: Convert irq-uart to use new irq_ functions
      ARM: SAMSUNG: Convert irq-vic-timer to irq_ functions

Rajeshwari Shinde (1):
      ARM: S5P64X0: Segregate audio devices

Sangwook Ju (2):
      ARM: S5PV310: Define missing CMU register for CPUFREQ
      ARM: S5PV310: Update CPUFREQ

Sunyoung Kang (4):
      ARM: S5PV310: Update CMU registers for CPUFREQ
      ARM: S5PV310: Add DMC registers and map_desc
      ARM: S5PV310: Add support CPUFREQ
      ARM: S5PV310: Update Kconfig and Makefile for supporting CPUFREQ

Sylwester Nawrocki (3):
      ARM: S5PV210: Add resource definitions for MIPI CSIS
      ARM: S5PV310: Add resource definitions for MIPI CSIS
      ARM: S5P: Add platform support for MIPI CSIS devices

Thomas Abraham (6):
      ARM: S5PV210: Add frame buffer display support for SMDKV210
      ARM: S5P: Add SROM control register shift macros for other banks.
      ARM: S5P: Add SROM bank 4 and 5 register offsets
      ARM: S5P: Move SROM controller IO mapping to plat-s5p for S5P SoCs
      ARM: S5PV210: Add SROM controller clock
      ARM: S5PV210: Add DM9000 support on SMDKV210

Yauhen Kharuzhy (5):
      ARM: S3C24XX: Add address map and clock definitions for HSMMC0
      ARM: S3C2416: Add platform helpers for setup SDHCI
      ARM: S3C2416: Add support of SD/MMC card detect on SMDK2416
      ARM: S3C2443: Implement GPIO pull-up/down configuration methods
      ARM: SAMSUNG: Don't export __init functions to modules

 arch/arm/Kconfig                                   |    1 +
 arch/arm/mach-s3c2410/bast-irq.c                   |   22 +-
 arch/arm/mach-s3c2410/include/mach/irqs.h          |    4 +-
 arch/arm/mach-s3c2410/include/mach/map.h           |    4 +-
 .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    1 +
 arch/arm/mach-s3c2412/irq.c                        |   50 +-
 arch/arm/mach-s3c2416/Kconfig                      |   12 +
 arch/arm/mach-s3c2416/Makefile                     |    4 +
 arch/arm/mach-s3c2416/clock.c                      |   18 +-
 arch/arm/mach-s3c2416/irq.c                        |   76 ++--
 arch/arm/mach-s3c2416/mach-smdk2416.c              |   23 +
 arch/arm/mach-s3c2416/s3c2416.c                    |    5 +
 arch/arm/mach-s3c2416/setup-sdhci-gpio.c           |   34 ++
 arch/arm/mach-s3c2416/setup-sdhci.c                |   61 ++
 arch/arm/mach-s3c2440/irq.c                        |   18 +-
 arch/arm/mach-s3c2440/s3c244x-irq.c                |   18 +-
 arch/arm/mach-s3c2443/Kconfig                      |    3 +-
 arch/arm/mach-s3c2443/clock.c                      |    4 +-
 arch/arm/mach-s3c2443/irq.c                        |   95 ++--
 arch/arm/mach-s3c2443/mach-smdk2443.c              |    9 +-
 arch/arm/mach-s3c2443/s3c2443.c                    |    7 +
 arch/arm/mach-s3c64xx/clock.c                      |   21 +-
 arch/arm/mach-s3c64xx/dev-audio.c                  |   60 ++-
 arch/arm/mach-s3c64xx/dma.c                        |    1 +
 arch/arm/mach-s3c64xx/irq-eint.c                   |   37 +-
 arch/arm/mach-s5p6442/clock.c                      |   16 +-
 arch/arm/mach-s5p6442/dev-audio.c                  |   44 ++-
 arch/arm/mach-s5p6442/include/mach/map.h           |    3 +
 arch/arm/mach-s5p6442/mach-smdk6442.c              |   10 +
 arch/arm/mach-s5p6442/setup-i2c0.c                 |    5 +-
 arch/arm/mach-s5p64x0/Makefile                     |    4 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |   24 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |   36 +-
 arch/arm/mach-s5p64x0/dev-audio.c                  |  144 ++++-
 arch/arm/mach-s5p64x0/{gpio.c => gpiolib.c}        |  221 +++++++-
 arch/arm/mach-s5p64x0/include/mach/map.h           |    5 +
 arch/arm/mach-s5p64x0/include/mach/regs-gpio.h     |   57 +--
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    1 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    1 +
 arch/arm/mach-s5pc100/clock.c                      |   16 +-
 arch/arm/mach-s5pc100/dev-audio.c                  |   54 ++-
 arch/arm/mach-s5pc100/include/mach/map.h           |    2 +
 arch/arm/mach-s5pv210/Kconfig                      |    2 +
 arch/arm/mach-s5pv210/clock.c                      |   35 +-
 arch/arm/mach-s5pv210/cpu.c                        |    5 -
 arch/arm/mach-s5pv210/dev-audio.c                  |   56 ++-
 arch/arm/mach-s5pv210/include/mach/irqs.h          |    3 +-
 arch/arm/mach-s5pv210/include/mach/map.h           |    6 +
 arch/arm/mach-s5pv210/include/mach/regs-clock.h    |    5 +-
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    1 +
 arch/arm/mach-s5pv210/mach-smdkv210.c              |  139 +++++-
 arch/arm/mach-s5pv310/Kconfig                      |   22 +
 arch/arm/mach-s5pv310/Makefile                     |    7 +-
 arch/arm/mach-s5pv310/clock.c                      |   77 ++-
 arch/arm/mach-s5pv310/cpu.c                        |   21 +-
 arch/arm/mach-s5pv310/cpufreq.c                    |  580
++++++++++++++++++++
 arch/arm/mach-s5pv310/dev-audio.c                  |  364 ++++++++++++
 arch/arm/mach-s5pv310/dev-pd.c                     |  139 +++++
 arch/arm/mach-s5pv310/dev-sysmmu.c                 |  187 +++++++
 arch/arm/mach-s5pv310/dma.c                        |  168 ++++++
 arch/arm/mach-s5pv310/include/mach/dma.h           |   26 +
 arch/arm/mach-s5pv310/include/mach/irqs.h          |   37 ++-
 arch/arm/mach-s5pv310/include/mach/map.h           |   50 ++
 arch/arm/mach-s5pv310/include/mach/regs-clock.h    |   80 +++-
 arch/arm/mach-s5pv310/include/mach/regs-mem.h      |   23 +
 arch/arm/mach-s5pv310/include/mach/regs-pmu.h      |   30 +
 arch/arm/mach-s5pv310/include/mach/regs-srom.h     |   50 --
 arch/arm/mach-s5pv310/include/mach/regs-sysmmu.h   |   24 +
 arch/arm/mach-s5pv310/include/mach/sysmmu.h        |  119 ++++
 arch/arm/mach-s5pv310/irq-combiner.c               |   32 +-
 arch/arm/mach-s5pv310/irq-eint.c                   |   55 +-
 arch/arm/mach-s5pv310/mach-smdkc210.c              |   52 ++-
 arch/arm/mach-s5pv310/mach-smdkv310.c              |   52 ++-
 arch/arm/mach-s5pv310/mach-universal_c210.c        |   80 +++
 arch/arm/plat-s3c24xx/devs.c                       |    1 -
 arch/arm/plat-s3c24xx/include/plat/irq.h           |    4 +-
 arch/arm/plat-s3c24xx/irq-pm.c                     |    9 +-
 arch/arm/plat-s3c24xx/irq.c                        |  182 +++----
 arch/arm/plat-s3c24xx/s3c2443-clock.c              |    2 +-
 arch/arm/plat-s5p/Kconfig                          |   26 +
 arch/arm/plat-s5p/Makefile                         |    3 +
 arch/arm/plat-s5p/cpu.c                            |    5 +
 arch/arm/plat-s5p/dev-csis0.c                      |   34 ++
 arch/arm/plat-s5p/dev-csis1.c                      |   34 ++
 arch/arm/plat-s5p/include/plat/csis.h              |   28 +
 arch/arm/plat-s5p/include/plat/map-s5p.h           |    1 +
 arch/arm/plat-s5p/include/plat/regs-srom.h         |   54 ++
 arch/arm/plat-s5p/include/plat/sysmmu.h            |   23 +
 arch/arm/plat-s5p/irq-eint.c                       |   86 ++--
 arch/arm/plat-s5p/irq-gpioint.c                    |   50 +-
 arch/arm/plat-s5p/irq-pm.c                         |    6 +-
 arch/arm/plat-s5p/sysmmu.c                         |  328 +++++++++++
 arch/arm/plat-samsung/Kconfig                      |   14 +
 arch/arm/plat-samsung/Makefile                     |    4 +
 arch/arm/plat-samsung/clock.c                      |   92 +++
 arch/arm/plat-samsung/dev-nand.c                   |    2 -
 arch/arm/plat-samsung/gpio-config.c                |   42 ++
 arch/arm/plat-samsung/gpiolib.c                    |    7 +
 arch/arm/plat-samsung/include/plat/audio.h         |   24 +
 arch/arm/plat-samsung/include/plat/clock.h         |    3 +
 arch/arm/plat-samsung/include/plat/devs.h          |   17 +
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   |    2 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h     |    2 +
 arch/arm/plat-samsung/include/plat/pd.h            |   30 +
 arch/arm/plat-samsung/include/plat/pm.h            |    4 +-
 arch/arm/plat-samsung/include/plat/sdhci.h         |   35 ++
 arch/arm/plat-samsung/irq-uart.c                   |   40 +-
 arch/arm/plat-samsung/irq-vic-timer.c              |   26 +-
 arch/arm/plat-samsung/pd.c                         |   95 ++++
 arch/arm/plat-samsung/pm.c                         |    6 +-
 drivers/serial/samsung.c                           |    4 +-
 111 files changed, 4277 insertions(+), 806 deletions(-)
