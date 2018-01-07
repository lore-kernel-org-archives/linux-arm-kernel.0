From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  7 Jan 2018 12:36:25 +0100
Subject: [GIT PULL 4/4] ARM: exynos/samsung: Stuff for v4.16
In-Reply-To: <20180107113625.15488-1-krzk@kernel.org>
References: <20180107113625.15488-1-krzk@kernel.org>
Message-ID: <20180107113625.15488-5-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.16-2

for you to fetch changes up to 4490e3c688d9e409a98189a6ea08bc2823d452e2:

  ARM: SAMSUNG: Add SPDX license identifiers (2018-01-03 18:43:13 +0100)

----------------------------------------------------------------
Samsung mach/soc changes for v4.16

Add SPDX license identifiers.

----------------------------------------------------------------
Krzysztof Kozlowski (5):
      ARM: EXYNOS: Add SPDX license identifiers
      ARM: S3C24XX: Add SPDX license identifiers
      ARM: S3C64XX: Add SPDX license identifiers
      ARM: S5PV210: Add SPDX license identifiers
      ARM: SAMSUNG: Add SPDX license identifiers

 arch/arm/mach-exynos/Kconfig                       |  4 +--
 arch/arm/mach-exynos/Makefile                      |  4 +--
 arch/arm/mach-exynos/common.h                      |  5 +--
 arch/arm/mach-exynos/exynos-smc.S                  |  5 +--
 arch/arm/mach-exynos/exynos.c                      | 16 ++++-----
 arch/arm/mach-exynos/firmware.c                    | 14 +++-----
 arch/arm/mach-exynos/headsmp.S                     |  6 +---
 arch/arm/mach-exynos/include/mach/map.h            |  7 ++--
 arch/arm/mach-exynos/mcpm-exynos.c                 | 17 +++-------
 arch/arm/mach-exynos/platsmp.c                     | 21 +++++-------
 arch/arm/mach-exynos/pm.c                          | 24 ++++++-------
 arch/arm/mach-exynos/sleep.S                       | 11 +-----
 arch/arm/mach-exynos/smc.h                         |  5 +--
 arch/arm/mach-exynos/suspend.c                     | 24 ++++++-------
 arch/arm/mach-s3c24xx/Kconfig                      |  4 +--
 arch/arm/mach-s3c24xx/Makefile                     |  4 +--
 arch/arm/mach-s3c24xx/Makefile.boot                |  2 ++
 arch/arm/mach-s3c24xx/anubis.h                     |  7 ++--
 arch/arm/mach-s3c24xx/bast-ide.c                   | 17 ++++------
 arch/arm/mach-s3c24xx/bast-irq.c                   | 28 ++++------------
 arch/arm/mach-s3c24xx/bast.h                       |  7 ++--
 arch/arm/mach-s3c24xx/common-smdk.c                | 21 +++++-------
 arch/arm/mach-s3c24xx/common-smdk.h                |  7 ++--
 arch/arm/mach-s3c24xx/common.c                     | 29 ++++------------
 arch/arm/mach-s3c24xx/common.h                     |  5 +--
 arch/arm/mach-s3c24xx/cpufreq-utils.c              | 18 ++++------
 arch/arm/mach-s3c24xx/fb-core.h                    |  5 +--
 arch/arm/mach-s3c24xx/gta02.h                      |  7 ++--
 arch/arm/mach-s3c24xx/h1940-bluetooth.c            | 16 +++------
 arch/arm/mach-s3c24xx/h1940.h                      |  7 ++--
 arch/arm/mach-s3c24xx/include/mach/dma.h           | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/fb.h            |  1 +
 arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h  |  7 ++--
 arch/arm/mach-s3c24xx/include/mach/hardware.h      |  7 ++--
 arch/arm/mach-s3c24xx/include/mach/irqs.h          | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/map.h           | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/pm-core.h       |  9 ++---
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h    | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h     | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/regs-irq.h      | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/regs-lcd.h      | 11 ++----
 .../mach-s3c24xx/include/mach/regs-s3c2443-clock.h | 10 ++----
 arch/arm/mach-s3c24xx/include/mach/rtc-core.h      |  7 ++--
 arch/arm/mach-s3c24xx/include/mach/s3c2412.h       |  5 +--
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c           | 18 ++++------
 arch/arm/mach-s3c24xx/iotiming-s3c2412.c           | 18 ++++------
 arch/arm/mach-s3c24xx/irq-pm.c                     | 19 ++++-------
 arch/arm/mach-s3c24xx/mach-amlm5900.c              | 35 +++++--------------
 arch/arm/mach-s3c24xx/mach-anubis.c                | 15 +++------
 arch/arm/mach-s3c24xx/mach-at2440evb.c             | 21 +++++-------
 arch/arm/mach-s3c24xx/mach-bast.c                  | 17 ++++------
 arch/arm/mach-s3c24xx/mach-gta02.c                 | 33 +++++-------------
 arch/arm/mach-s3c24xx/mach-h1940.c                 | 17 ++++------
 arch/arm/mach-s3c24xx/mach-jive.c                  | 17 ++++------
 arch/arm/mach-s3c24xx/mach-mini2440.c              | 23 +++++--------
 arch/arm/mach-s3c24xx/mach-n30.c                   | 27 +++++++--------
 arch/arm/mach-s3c24xx/mach-nexcoder.c              | 22 +++++-------
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            | 19 ++++-------
 arch/arm/mach-s3c24xx/mach-osiris.c                | 14 +++-----
 arch/arm/mach-s3c24xx/mach-otom.c                  | 13 +++-----
 arch/arm/mach-s3c24xx/mach-qt2410.c                | 27 +++------------
 arch/arm/mach-s3c24xx/mach-rx1950.c                | 17 ++++------
 arch/arm/mach-s3c24xx/mach-rx3715.c                | 18 ++++------
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            | 28 +++++++---------
 arch/arm/mach-s3c24xx/mach-smdk2410.c              | 39 ++++++----------------
 arch/arm/mach-s3c24xx/mach-smdk2413.c              | 19 ++++-------
 arch/arm/mach-s3c24xx/mach-smdk2416.c              | 18 ++++------
 arch/arm/mach-s3c24xx/mach-smdk2440.c              | 23 +++++--------
 arch/arm/mach-s3c24xx/mach-smdk2443.c              | 22 +++++-------
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            | 33 +++++-------------
 arch/arm/mach-s3c24xx/mach-vr1000.c                | 19 ++++-------
 arch/arm/mach-s3c24xx/mach-vstms.c                 | 15 +++------
 arch/arm/mach-s3c24xx/nand-core.h                  |  7 ++--
 arch/arm/mach-s3c24xx/osiris.h                     |  7 ++--
 arch/arm/mach-s3c24xx/otom.h                       |  7 ++--
 arch/arm/mach-s3c24xx/pll-s3c2410.c                | 30 +++++------------
 arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c       | 20 +++++------
 arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c       | 20 +++++------
 arch/arm/mach-s3c24xx/pm-h1940.S                   | 19 ++---------
 arch/arm/mach-s3c24xx/pm-s3c2410.c                 | 27 ++++-----------
 arch/arm/mach-s3c24xx/pm-s3c2412.c                 | 17 ++++------
 arch/arm/mach-s3c24xx/pm-s3c2416.c                 | 17 ++++------
 arch/arm/mach-s3c24xx/pm.c                         | 39 +++++++---------------
 arch/arm/mach-s3c24xx/regs-dsc.h                   |  7 ++--
 arch/arm/mach-s3c24xx/regs-mem.h                   |  5 +--
 arch/arm/mach-s3c24xx/s3c2410.c                    | 17 ++++------
 arch/arm/mach-s3c24xx/s3c2412-power.h              |  5 +--
 arch/arm/mach-s3c24xx/s3c2412.c                    | 16 ++++-----
 arch/arm/mach-s3c24xx/s3c2416.c                    | 31 +++++------------
 arch/arm/mach-s3c24xx/s3c2440.c                    | 17 ++++------
 arch/arm/mach-s3c24xx/s3c2442.c                    | 29 ++++------------
 arch/arm/mach-s3c24xx/s3c2443.c                    | 17 ++++------
 arch/arm/mach-s3c24xx/s3c244x.c                    | 17 ++++------
 arch/arm/mach-s3c24xx/setup-camif.c                | 14 +++-----
 arch/arm/mach-s3c24xx/setup-i2c.c                  | 17 ++++------
 arch/arm/mach-s3c24xx/setup-sdhci-gpio.c           | 21 +++++-------
 arch/arm/mach-s3c24xx/setup-spi.c                  | 16 ++++-----
 arch/arm/mach-s3c24xx/setup-ts.c                   | 17 ++++------
 arch/arm/mach-s3c24xx/simtec-audio.c               | 19 ++++-------
 arch/arm/mach-s3c24xx/simtec-nor.c                 | 19 ++++-------
 arch/arm/mach-s3c24xx/simtec-pm.c                  | 21 +++++-------
 arch/arm/mach-s3c24xx/simtec-usb.c                 | 21 +++++-------
 arch/arm/mach-s3c24xx/simtec.h                     | 10 ++----
 arch/arm/mach-s3c24xx/sleep-s3c2410.S              | 20 ++---------
 arch/arm/mach-s3c24xx/sleep-s3c2412.S              | 20 ++---------
 arch/arm/mach-s3c24xx/sleep.S                      | 20 ++---------
 arch/arm/mach-s3c24xx/spi-core.h                   |  5 +--
 arch/arm/mach-s3c24xx/vr1000.h                     | 11 ++----
 arch/arm/mach-s3c64xx/Kconfig                      |  5 +--
 arch/arm/mach-s3c64xx/Makefile                     |  4 +--
 arch/arm/mach-s3c64xx/ata-core.h                   |  7 ++--
 arch/arm/mach-s3c64xx/backlight.h                  |  5 +--
 arch/arm/mach-s3c64xx/common.c                     | 26 ++++++---------
 arch/arm/mach-s3c64xx/common.h                     |  5 +--
 arch/arm/mach-s3c64xx/cpuidle.c                    | 15 +++------
 arch/arm/mach-s3c64xx/crag6410.h                   |  5 +--
 arch/arm/mach-s3c64xx/dev-audio.c                  | 13 +++-----
 arch/arm/mach-s3c64xx/dev-backlight.c              | 16 ++++-----
 arch/arm/mach-s3c64xx/dev-uart.c                   | 22 +++++-------
 arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h  |  7 ++--
 arch/arm/mach-s3c64xx/include/mach/hardware.h      |  1 +
 arch/arm/mach-s3c64xx/include/mach/map.h           | 10 ++----
 arch/arm/mach-s3c64xx/include/mach/pm-core.h       |  8 ++---
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h    | 10 ++----
 arch/arm/mach-s3c64xx/include/mach/regs-irq.h      | 10 ++----
 arch/arm/mach-s3c64xx/irq-pm.c                     | 21 +++++-------
 arch/arm/mach-s3c64xx/irq-uart.h                   |  7 ++--
 arch/arm/mach-s3c64xx/mach-anw6410.c               | 22 +++++-------
 arch/arm/mach-s3c64xx/mach-crag6410-module.c       | 15 ++++-----
 arch/arm/mach-s3c64xx/mach-crag6410.c              | 19 ++++-------
 arch/arm/mach-s3c64xx/mach-hmt.c                   | 14 +++-----
 arch/arm/mach-s3c64xx/mach-mini6410.c              | 20 ++++-------
 arch/arm/mach-s3c64xx/mach-ncp.c                   | 13 ++------
 arch/arm/mach-s3c64xx/mach-real6410.c              | 20 ++++-------
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c            | 14 +++-----
 arch/arm/mach-s3c64xx/mach-smartq.c                | 13 ++------
 arch/arm/mach-s3c64xx/mach-smartq.h                |  6 +---
 arch/arm/mach-s3c64xx/mach-smartq5.c               | 13 ++------
 arch/arm/mach-s3c64xx/mach-smartq7.c               | 13 ++------
 arch/arm/mach-s3c64xx/mach-smdk6400.c              | 15 +++------
 arch/arm/mach-s3c64xx/mach-smdk6410.c              | 18 ++++------
 arch/arm/mach-s3c64xx/onenand-core.h               |  7 ++--
 arch/arm/mach-s3c64xx/pl080.c                      | 14 +++-----
 arch/arm/mach-s3c64xx/pm.c                         | 21 +++++-------
 arch/arm/mach-s3c64xx/regs-modem.h                 |  7 ++--
 arch/arm/mach-s3c64xx/regs-srom.h                  |  7 ++--
 arch/arm/mach-s3c64xx/s3c6400.c                    | 15 +++------
 arch/arm/mach-s3c64xx/s3c6410.c                    | 17 ++++------
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c             | 21 +++++-------
 arch/arm/mach-s3c64xx/setup-i2c0.c                 | 21 +++++-------
 arch/arm/mach-s3c64xx/setup-i2c1.c                 | 21 +++++-------
 arch/arm/mach-s3c64xx/setup-ide.c                  | 17 ++++------
 arch/arm/mach-s3c64xx/setup-keypad.c               | 17 ++++------
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c           | 19 ++++-------
 arch/arm/mach-s3c64xx/setup-spi.c                  | 13 +++-----
 arch/arm/mach-s3c64xx/setup-usb-phy.c              | 14 +++-----
 arch/arm/mach-s3c64xx/sleep.S                      |  7 ++--
 arch/arm/mach-s3c64xx/watchdog-reset.h             |  7 ++--
 arch/arm/mach-s5pv210/Kconfig                      |  4 +--
 arch/arm/mach-s5pv210/Makefile                     |  4 +--
 arch/arm/mach-s5pv210/common.h                     |  5 +--
 arch/arm/mach-s5pv210/pm.c                         | 25 ++++++--------
 arch/arm/mach-s5pv210/regs-clock.h                 |  7 ++--
 arch/arm/mach-s5pv210/s5pv210.c                    | 18 ++++------
 arch/arm/mach-s5pv210/sleep.S                      |  6 +---
 arch/arm/plat-samsung/Kconfig                      |  4 +--
 arch/arm/plat-samsung/Makefile                     |  4 +--
 arch/arm/plat-samsung/adc.c                        | 19 ++++-------
 arch/arm/plat-samsung/cpu.c                        | 17 ++++------
 arch/arm/plat-samsung/dev-uart.c                   | 21 +++++-------
 arch/arm/plat-samsung/devs.c                       | 17 ++++------
 arch/arm/plat-samsung/gpio-samsung.c               | 26 ++++++---------
 arch/arm/plat-samsung/include/plat/adc-core.h      | 10 ++----
 arch/arm/plat-samsung/include/plat/adc.h           | 10 ++----
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h | 10 ++----
 arch/arm/plat-samsung/include/plat/cpu-freq.h      | 10 ++----
 arch/arm/plat-samsung/include/plat/cpu.h           | 10 ++----
 arch/arm/plat-samsung/include/plat/devs.h          | 10 ++----
 arch/arm/plat-samsung/include/plat/fb-s3c2410.h    |  8 ++---
 arch/arm/plat-samsung/include/plat/fb.h            | 10 ++----
 .../plat-samsung/include/plat/gpio-cfg-helpers.h   | 10 ++----
 arch/arm/plat-samsung/include/plat/gpio-cfg.h      | 10 ++----
 arch/arm/plat-samsung/include/plat/gpio-core.h     | 10 ++----
 arch/arm/plat-samsung/include/plat/iic-core.h      | 10 ++----
 arch/arm/plat-samsung/include/plat/keypad.h        |  6 +---
 arch/arm/plat-samsung/include/plat/map-base.h      | 10 ++----
 arch/arm/plat-samsung/include/plat/map-s3c.h       | 10 ++----
 arch/arm/plat-samsung/include/plat/map-s5p.h       | 10 ++----
 arch/arm/plat-samsung/include/plat/pm-common.h     |  7 ++--
 arch/arm/plat-samsung/include/plat/pm.h            | 10 ++----
 arch/arm/plat-samsung/include/plat/pwm-core.h      |  5 +--
 arch/arm/plat-samsung/include/plat/regs-adc.h      | 10 ++----
 arch/arm/plat-samsung/include/plat/regs-irqtype.h  |  8 ++---
 arch/arm/plat-samsung/include/plat/regs-spi.h      | 10 ++----
 arch/arm/plat-samsung/include/plat/regs-udc.h      | 11 ++----
 arch/arm/plat-samsung/include/plat/samsung-time.h  | 10 ++----
 arch/arm/plat-samsung/include/plat/sdhci.h         | 10 ++----
 arch/arm/plat-samsung/include/plat/usb-phy.h       |  6 +---
 arch/arm/plat-samsung/include/plat/wakeup-mask.h   | 11 ++----
 arch/arm/plat-samsung/init.c                       | 19 ++++-------
 arch/arm/plat-samsung/platformdata.c               | 15 +++------
 arch/arm/plat-samsung/pm-check.c                   | 22 +++++-------
 arch/arm/plat-samsung/pm-common.c                  | 24 ++++++-------
 arch/arm/plat-samsung/pm-debug.c                   | 24 ++++++-------
 arch/arm/plat-samsung/pm-gpio.c                    | 22 +++++-------
 arch/arm/plat-samsung/pm.c                         | 21 +++++-------
 arch/arm/plat-samsung/wakeup-mask.c                | 15 +++------
 arch/arm/plat-samsung/watchdog-reset.c             | 21 +++++-------
 208 files changed, 962 insertions(+), 1999 deletions(-)
