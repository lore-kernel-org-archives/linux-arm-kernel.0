From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 09 Aug 2010 19:21:11 +0900
Subject: [GIT PULL] Samsung S5P updates for 2.6.36 merge window
Message-ID: <017201cb37ac$9979a5a0$cc6cf0e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

Please pull Samsung S5P updates from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk

These things are for 2.6.36 and merged Dmitry's input tree for avoiding
merge conflict as per Stephen's suggestion.
The merged input tree has been already merged into the Linus'.
If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


The following changes since commit 9fe6206f400646a2322096b56c59891d530e8d51

  Linux 2.6.35

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk

(Removed changes from Dmitry's input tree in the following)

Abhilash Kesavan (4):
      ARM: S5PC100: Add support for Compact Flash driver on SMDKC100
      ARM: S5PV210: Add support for Compact Flash driver on SMDKV210/C110
      ARM: SAMSUNG: Add Compact Flash device support for Samsung SoCs
      ARM: S3C64XX: Add support for Compact Flash driver on SMDK6410

Atul Dahiya (10):
      ARM: S5P6440: Add RTC support for S5P6440
      ARM: S5PC100: Add RTC support for S5PC100
      ARM: S5PV210: Add RTC support for S5PV210 and S5PC110
      ARM: S3C64XX: Move RTC clock from init_clocks to init_clocks_disable
      rtc: rtc-s3c: Updates RTC driver for clock enabling support
      ARM: SAMSUNG: Updates RTC register for support Alarm IRQ and Time
Tick.
      rtc: rtc-s3c: Updates driver for S3C64XX and newer SoCs
      ARM: S3C64XX: Add RTC support for S3C64XX
      rtc: rtc-s3c: Add extra option to include RTC for Samsung SoCs
      ARM: SAMSUNG: Make RTC driver dependency SoC specific instead of
machine specific

Banajit Goswami (4):
      ARM: S5P6442: Add Watchdog support for S5P6442
      ARM: S5PC100: Add Watchdog support for S5PC100
      ARM: SAMSUNG: Reduce virtual memory size for WDT device
      ARM: SAMSUNG: Make WDT driver dependency SoC specific instead of
machine specific

Ben Dooks (1):
      ARM: SAMSUNG: Add helper to clone and set platform data

Changhwan Youn (7):
      ARM: S5P: Remove fixed uart offset dependent code
      ARM: S5PV310: Add new CPU initialization support
      ARM: S5PV310: Add Clock and PLL support
      ARM: S5PV310: Add IRQ support
      ARM: S5PV310: Add Timer support
      ARM: S5PV310: Add new Kconfig and Makefiles
      ARM: S5PV310: Add Board support file

Dmitry Torokhov (1):
      Merge branch 'next' into for-linus

Hyuk Lee (2):
      ARM: S5PV210: Add support HSMMC on SMDKV210
      ARM: SAMSUNG: Add device definition for HSMMC3

Jongpill Lee (7):
      ARM: S5P: Add System define for arch_reset()
      ARM: S5P: Add Support common arch_reset() for S5P
      ARM: S5P: Add s5p_reset_hook() for perform reset using SWRESET on S5P
SoCs
      ARM: S5P6442: Add Watchdog Timer map for S5P6442
      ARM: S5PV210: Add s5pv210_sw_reset for SWRESET
      ARM: SAMSUNG: serial: Add FRACVAL support for newer UART
      ARM: S5PV310: Add serial port support

Joonyoung Shim (10):
      Input: mcs - Add MCS touchkey driver
      Input: Add ATMEL QT602240 touchscreen driver
      Input: samsung-keypad - Add samsung keypad driver
      ARM: S5P: Add PMU device
      ARM: S5PV210: Fix Aquila board UART FIFO mode configration
      ARM: S5PV210: Fix GONI board UART FIFO mode configration
      ARM: S5PV210: Add OneNAND device to the GONI board
      ARM: S5PV210: Add OneNAND device to the Aquila board
      ARM: S5PV210: Add keypad device helpers
      ARM: SAMSUNG: Add keypad device support

Kukjin Kim (14):
      ARM: S5P: Changes the definition name of default UART registers
      ARM: S5PV210: Fix on MAX_PHYSMEM_BITS on S5PV210/S5PC110.
      ARM: s5pv210_defconfig: Update for removing s5pc110_defconfig
      ARM: SAMSUNG: updates sdhci.h for Samsung SoCs
      Merge commit 'd01d0756f75e7a5b4b43764ad45b83c4340f11d6' into
next-samsung
      ARM: SAMSUNG: Fix on inclusion mach/gpio.h for Samsung SoCs
      Merge branch 'next-s5p6442' into for-next
      Merge branch 'next-s5pc100' into for-next
      Merge branch 'next-s5pv210' into for-next
      Merge branch 'next-s5pv310' into for-next
      Merge branch 'next-s5p' into for-next
      Merge branch 'next-samsung' into for-next
      ARM: S5P: Fix on missing S5P_DEV_FIMC in plat-s5p/Kconfig
      ARM: S5PV210: Fix on missing s3c-sdhci card detection method for
hsmmc3

Kyungmin Park (4):
      ARM: S5PV310: Add I2C channel 0, 1 and 2 support
      ARM: S5PC110: Add OneNAND interrupt number
      ARM: S5PV310: Add Samsung UNIVERSAL_C210 support
      ARM: SAMSUNG: Fix on inclusion mach/gpio.h on gpiolib.c

Marek Szyprowski (9):
      ARM: S5PC100: cleanup hsmmc clock definitions
      ARM: S5PV210: Add more GPIO banks to gpiolib
      ARM: S5PV210: Add Framebuffer support for GONI
      ARM: S5PV210: Add MAX8998 PMIC support for Aquila
      ARM: S5PV210: Add MAX8998 PMIC support for GONI
      ARM: SAMSUNG: Add new s3c-sdhci card detection methods for Samsung
SoCs
      ARM: S5PV210: Add SDHCI devices for Aquila board
      ARM: S5PV210: Add SDHCI devices for GONI board
      ARM: S5PV210: cleanup hsmmc clock definitions

Naveen Krishna Ch (9):
      ARM: S5PC100: Add Touchscreen support.
      ARM: S5PC100: Rename keypad clock for S5PC100.
      ARM: S5PC100: Add keypad device to the SMDKC100 board
      ARM: S5PV210: Add keypad device to the SMDKV210 board
      ARM: SAMSUNG: Implement set_name function for ADC devices
      ARM: SAMSUNG: i2c/busses: Add HAVE_S3C2410_I2C option to include I2C
for Samsung SoCs
      ARM: S5PV210: Add support for I2C devices on SMDKV210 and SMDKC110
      ARM: S5P6440: Add support for I2C channel 0 and 1 on SMDK6440
      ARM: S3C64XX: Add keypad device to the SMDK6410 board

Sylwester Nawrocki (5):
      ARM: SAMSUNG: Add platform definitions and helpers for FIMC driver
      ARM: S5PV210: enable FIMC on Aquila
      ARM: S5PV210: enable FIMC on Goni
      ARM: S5PC100: enable FIMC on SMDKC100
      ARM: S5PV210: Override FIMC driver name on Aquila board

Taekgyun Ko (1):
      rtc: rtc-s3c: Add BCD register initialization codes


 arch/arm/Kconfig                                 |   37 +-
 arch/arm/Makefile                                |    1 +
 arch/arm/configs/s5pc110_defconfig               |   66 -
 arch/arm/configs/s5pv210_defconfig               |    5 +
 arch/arm/mach-s3c64xx/Kconfig                    |   15 +
 arch/arm/mach-s3c64xx/Makefile                   |    2 +
 arch/arm/mach-s3c64xx/clock.c                    |   24 +-
 arch/arm/mach-s3c64xx/dev-audio.c                |    2 +-
 arch/arm/mach-s3c64xx/dev-spi.c                  |    2 +-
 arch/arm/mach-s3c64xx/gpiolib.c                  |    2 +-
 arch/arm/mach-s3c64xx/include/mach/map.h         |    6 +
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h  |    5 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c            |   33 +
 arch/arm/mach-s3c64xx/s3c6410.c                  |    6 +-
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c           |    2 +-
 arch/arm/mach-s3c64xx/setup-i2c0.c               |    2 +-
 arch/arm/mach-s3c64xx/setup-i2c1.c               |    2 +-
 arch/arm/mach-s3c64xx/setup-ide.c                |   46 +
 arch/arm/mach-s3c64xx/setup-keypad.c             |   34 +
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c         |   17 +-
 arch/arm/mach-s5p6440/Kconfig                    |   13 +-
 arch/arm/mach-s5p6440/Makefile                   |    1 +
 arch/arm/mach-s5p6440/cpu.c                      |    3 +-
 arch/arm/mach-s5p6440/dev-audio.c                |    2 +-
 arch/arm/mach-s5p6440/dev-spi.c                  |    2 +-
 arch/arm/mach-s5p6440/gpio.c                     |    4 +-
 arch/arm/mach-s5p6440/include/mach/irqs.h        |    2 +-
 arch/arm/mach-s5p6440/include/mach/map.h         |    4 +-
 arch/arm/mach-s5p6440/include/mach/system.h      |    7 +-
 arch/arm/mach-s5p6440/mach-smdk6440.c            |   51 +-
 arch/arm/mach-s5p6440/setup-i2c0.c               |    7 +-
 arch/arm/mach-s5p6440/setup-i2c1.c               |   30 +
 arch/arm/mach-s5p6442/Kconfig                    |    1 +
 arch/arm/mach-s5p6442/clock.c                    |    6 +
 arch/arm/mach-s5p6442/dev-audio.c                |    2 +-
 arch/arm/mach-s5p6442/dev-spi.c                  |    2 +-
 arch/arm/mach-s5p6442/include/mach/irqs.h        |    2 +-
 arch/arm/mach-s5p6442/include/mach/map.h         |    3 +
 arch/arm/mach-s5p6442/include/mach/system.h      |    7 +-
 arch/arm/mach-s5p6442/mach-smdk6442.c            |   25 +-
 arch/arm/mach-s5pc100/Kconfig                    |   23 +-
 arch/arm/mach-s5pc100/Makefile                   |    2 +
 arch/arm/mach-s5pc100/clock.c                    |    8 +-
 arch/arm/mach-s5pc100/cpu.c                      |    5 +
 arch/arm/mach-s5pc100/dev-audio.c                |    2 +-
 arch/arm/mach-s5pc100/dev-spi.c                  |    2 +-
 arch/arm/mach-s5pc100/include/mach/irqs.h        |    4 +-
 arch/arm/mach-s5pc100/include/mach/map.h         |   21 +
 arch/arm/mach-s5pc100/include/mach/regs-clock.h  |    3 +
 arch/arm/mach-s5pc100/include/mach/system.h      |    9 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c            |   78 +-
 arch/arm/mach-s5pc100/setup-ide.c                |   70 ++
 arch/arm/mach-s5pc100/setup-keypad.c             |   34 +
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c         |   22 +-
 arch/arm/mach-s5pc100/setup-sdhci.c              |    8 +-
 arch/arm/mach-s5pv210/Kconfig                    |   87 ++-
 arch/arm/mach-s5pv210/Makefile                   |    2 +
 arch/arm/mach-s5pv210/cpu.c                      |   29 +-
 arch/arm/mach-s5pv210/dev-audio.c                |    2 +-
 arch/arm/mach-s5pv210/dev-onenand.c              |    7 +-
 arch/arm/mach-s5pv210/dev-spi.c                  |    2 +-
 arch/arm/mach-s5pv210/gpiolib.c                  |   14 +
 arch/arm/mach-s5pv210/include/mach/gpio.h        |   12 +-
 arch/arm/mach-s5pv210/include/mach/irqs.h        |    4 +-
 arch/arm/mach-s5pv210/include/mach/map.h         |   16 +
 arch/arm/mach-s5pv210/include/mach/memory.h      |    9 +-
 arch/arm/mach-s5pv210/include/mach/regs-clock.h  |    2 +
 arch/arm/mach-s5pv210/include/mach/system.h      |    7 +-
 arch/arm/mach-s5pv210/mach-aquila.c              |  417 ++++++-
 arch/arm/mach-s5pv210/mach-goni.c                |  437 +++++++-
 arch/arm/mach-s5pv210/mach-smdkc110.c            |   66 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c            |   93 ++-
 arch/arm/mach-s5pv210/setup-fb-24bpp.c           |    2 +-
 arch/arm/mach-s5pv210/setup-i2c0.c               |    2 +-
 arch/arm/mach-s5pv210/setup-i2c1.c               |    2 +-
 arch/arm/mach-s5pv210/setup-i2c2.c               |    2 +-
 arch/arm/mach-s5pv210/setup-ide.c                |   50 +
 arch/arm/mach-s5pv210/setup-keypad.c             |   34 +
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c         |   47 +-
 arch/arm/mach-s5pv210/setup-sdhci.c              |    4 +-
 arch/arm/mach-s5pv310/Kconfig                    |   45 +
 arch/arm/mach-s5pv310/Makefile                   |   30 +
 arch/arm/mach-s5pv310/Makefile.boot              |    2 +
 arch/arm/mach-s5pv310/clock.c                    |  544 +++++++++
 arch/arm/mach-s5pv310/cpu.c                      |  122 ++
 arch/arm/mach-s5pv310/headsmp.S                  |   41 +
 arch/arm/mach-s5pv310/include/mach/debug-macro.S |   36 +
 arch/arm/mach-s5pv310/include/mach/entry-macro.S |   84 ++
 arch/arm/mach-s5pv310/include/mach/gpio.h        |  135 +++
 arch/arm/mach-s5pv310/include/mach/hardware.h    |   18 +
 arch/arm/mach-s5pv310/include/mach/io.h          |   26 +
 arch/arm/mach-s5pv310/include/mach/irqs.h        |   74 ++
 arch/arm/mach-s5pv310/include/mach/map.h         |   69 ++
 arch/arm/mach-s5pv310/include/mach/memory.h      |   22 +
 arch/arm/mach-s5pv310/include/mach/pwm-clock.h   |   70 ++
 arch/arm/mach-s5pv310/include/mach/regs-clock.h  |   62 +
 arch/arm/mach-s5pv310/include/mach/regs-irq.h    |   19 +
 arch/arm/mach-s5pv310/include/mach/smp.h         |   29 +
 arch/arm/mach-s5pv310/include/mach/system.h      |   22 +
 arch/arm/mach-s5pv310/include/mach/timex.h       |   29 +
 arch/arm/mach-s5pv310/include/mach/uncompress.h  |   30 +
 arch/arm/mach-s5pv310/include/mach/vmalloc.h     |   22 +
 arch/arm/mach-s5pv310/init.c                     |   41 +
 arch/arm/mach-s5pv310/irq-combiner.c             |  125 ++
 arch/arm/mach-s5pv310/localtimer.c               |   25 +
 arch/arm/mach-s5pv310/mach-smdkv310.c            |   92 ++
 arch/arm/mach-s5pv310/mach-universal_c210.c      |   86 ++
 arch/arm/mach-s5pv310/platsmp.c                  |  192 +++
 arch/arm/mach-s5pv310/setup-i2c0.c               |   28 +
 arch/arm/mach-s5pv310/setup-i2c1.c               |   25 +
 arch/arm/mach-s5pv310/setup-i2c2.c               |   25 +
 arch/arm/mach-s5pv310/time.c                     |  287 +++++
 arch/arm/mm/Kconfig                              |    3 +-
 arch/arm/plat-s5p/Kconfig                        |   20 +-
 arch/arm/plat-s5p/Makefile                       |    6 +
 arch/arm/plat-s5p/cpu.c                          |   19 +-
 arch/arm/plat-s5p/dev-fimc0.c                    |   36 +
 arch/arm/plat-s5p/dev-fimc1.c                    |   36 +
 arch/arm/plat-s5p/dev-fimc2.c                    |   36 +
 arch/arm/plat-s5p/dev-pmu.c                      |   36 +
 arch/arm/plat-s5p/include/plat/map-s5p.h         |   23 +-
 arch/arm/plat-s5p/include/plat/pll.h             |   41 +
 arch/arm/plat-s5p/include/plat/reset.h           |   16 +
 arch/arm/plat-s5p/include/plat/s5pv310.h         |   34 +
 arch/arm/plat-s5p/include/plat/system-reset.h    |   31 +
 arch/arm/plat-s5p/irq.c                          |    2 +
 arch/arm/plat-samsung/Kconfig                    |   15 +
 arch/arm/plat-samsung/Makefile                   |    7 +-
 arch/arm/plat-samsung/dev-hsmmc.c                |    5 +
 arch/arm/plat-samsung/dev-hsmmc1.c               |    5 +
 arch/arm/plat-samsung/dev-hsmmc2.c               |    5 +
 arch/arm/plat-samsung/dev-hsmmc3.c               |   77 ++
 arch/arm/plat-samsung/dev-ide.c                  |   44 +
 arch/arm/plat-samsung/dev-keypad.c               |   50 +
 arch/arm/plat-samsung/dev-wdt.c                  |    2 +-
 arch/arm/plat-samsung/gpiolib.c                  |    2 +-
 arch/arm/plat-samsung/include/plat/adc-core.h    |   28 +
 arch/arm/plat-samsung/include/plat/ata-core.h    |   28 +
 arch/arm/plat-samsung/include/plat/ata.h         |   36 +
 arch/arm/plat-samsung/include/plat/devs.h        |   20 +
 arch/arm/plat-samsung/include/plat/fimc-core.h   |   44 +
 arch/arm/plat-samsung/include/plat/keypad-core.h |   31 +
 arch/arm/plat-samsung/include/plat/keypad.h      |   56 +
 arch/arm/plat-samsung/include/plat/regs-ata.h    |   56 +
 arch/arm/plat-samsung/include/plat/regs-rtc.h    |    3 +
 arch/arm/plat-samsung/include/plat/regs-serial.h |    2 +
 arch/arm/plat-samsung/include/plat/sdhci.h       |  127 ++-
 arch/arm/plat-samsung/platformdata.c             |   37 +
 drivers/rtc/Kconfig                              |    9 +-
 drivers/rtc/rtc-s3c.c                            |   44 +-
 drivers/serial/Kconfig                           |    4 +-
 drivers/serial/s5pv210.c                         |    8 +
 drivers/serial/samsung.c                         |    9 +-
