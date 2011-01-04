From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 4 Jan 2011 14:30:33 +0100
Subject: [GIT PULL] i.MX patches for next merge window
Message-ID: <20110104133033.GA31631@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please pull the following for the next merge window.

Sascha

The following changes since commit 387c31c7e5c9805b0aef8833d1731a5fe7bdea14:

  Linux 2.6.37-rc8 (2010-12-28 17:05:48 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Alberto Panizzo (1):
      ARM: mx3/mach-pcm037_eet: Fix section mismatch for eet_init_devices()

Arnaud Patard (17):
      efikamx: read board id
      imx51: fix iomux configuration
      imx51: enhance iomux configuration for esdhc support
      efikamx: add mmc support
      imx51: add gpio mode for csi1 {h,v}sync
      efikamx: add leds support
      efikamx: add support for power key
      imx51: fix gpio_4_24 and gpio_4_25 pad configuration
      efikamx: add spi nor support
      efikamx: add reset
      imx: fix iomux v3
      mx5: Fix efikamx build
      iMX51: introduce IMX_GPIO_NR
      Fix imx cpufreq driver as module
      arch/arm/plat-mxc/ehci.c: fix errors/typos
      MX51: Add support for usb host 2
      mx51: fix usb clock support

Dinh Nguyen (3):
      ARM: imx: Add core definitions for MX53
      ARM: imx: Add mx53 support to common msl functions.
      ARM: imx: Get the silicon version from the IIM module

Eric B?nard (1):
      plat-mxc/ehci.c: fix compile breakage

Fabio Estevam (18):
      mx31_3ds: Add touchscreen support
      mx51_3ds: Add esdhc support
      mx51_babbage: Add SPI flash support
      ARM: mx5: introduce SOC_IMX51
      ARM: mx5: dynamically allocate imx2-wdt devices
      ARM: mx5: add support for the two watchdog modules
      ARM: mx5: add watchdog clocks
      ARM: mx5/mx51_babbage: Add watchdog support
      watchdog: imx: use clk_get to acquire the watchdog clock
      ARM: mx3/mx31_3ds: Add watchdog support
      ARM: imx/mx27_3ds: Add watchdog support
      ARM: mx5: check for error in ioremap
      ARM: mx3/mx35_3ds: Add USB OTG Host mode
      ARM: imx/mx27_3ds: Add USB OTG support
      ARM: imx/mx25_3ds: Add USB support
      ARM: mx3/mx31_3ds: Add support for OTG host mode
      ARM: mx3/mx31_3ds: Add support for USB Host2 port
      ARM: imx/mx27_3ds: Add PMIC support

Lothar Wa?mann (2):
      ARM: i.MX IOMUX-V3 replace struct pad_desc with bitmapped cookie
      MXC IOMUX-V3 replace struct pad_desc with bitmapped cookie (step 2)

Peter Horton (2):
      mx51: add SSI3
      mx51: support FIQ on TZIC, revised

Richard Zhao (6):
      ARM: mx5: use config to define boot related addresses
      arm: plat-mxc: add full parameter macro to define gpio port
      arm: mx51: define mx51's own MXC_GPIO_IRQS
      arm: mx5: mx51/53 have different mxc_cpu_type definition
      arm: mx50: add core functions support except clock
      arm: mx50: add mx50 reference design board support

Sascha Hauer (14):
      Merge branch 'imx-for-2.6.38' of git://git.pengutronix.de/git/ukl/linux-2.6 into imx-for-2.6.38
      ARM i.MX51 boards: Do not use PHYS_OFFSET
      ARM i.MX irq: Compile avic irq code only on SoCs that need it
      ARM i.MX51: Make CONFIG_MXC_TZIC an invisible option
      ARM i.MX DMA: return gracefully on different socs
      ARM i.MX51: return gracefully on different socs
      ARM i.MX27 pm: return gracefully on different socs
      dmaengine i.MX SDMA: Allow to run without firmware
      ARM i.MX SDMA: Add ROM script addresses to platform_data
      Merge commit 'v2.6.37-rc4' into imx-for-2.6.38
      ARM i.MX51: Full iomux support
      Merge branch 'sgu/mxs-core-v8' of git://git.pengutronix.de/git/ukl/linux-2.6 into imx-for-2.6.38-new
      ARM i.MX51: Add ipu clock support
      ARM i.MX51: rename IPU irqs

Shawn Guo (15):
      ARM: mxs: Add core definitions
      ARM: mxs: Add helper definition and function
      ARM: mxs: Add reset routines
      ARM: mxs: Add interrupt support
      ARM: mxs: Add low-level debug UART support
      ARM: mxs: Add timer support
      ARM: mxs: Add gpio support
      ARM: mxs: Add iomux support
      ARM: mxs: Add clock support
      ARM: mxs: Add static memory mapping
      ARM: mxs: Dynamically allocate duart devices
      ARM: mxs: Dynamically allocate fec devices
      ARM: mxs: Add initial mx23evk support
      ARM: mxs: Add initial mx28evk support
      ARM: mxs: Add build configuration for mxs

Uwe Kleine-K?nig (52):
      ARM: mx3: fix the last users of IMX_NEEDS_DEPRECATED_SYMBOLS
      ARM: imx: refactor the io mapping macro
      ARM: imx: use MXxy_IO_P2V macros to setup static mappings
      ARM: imx: remove last explicit users of virtual base address defines
      ARM: imx: change static io mapping to use a function
      ARM: imx/debug-macro: rework using the new io mapping macro
      ARM: imx: remove deprecated symbols as all users are gone now
      ARM: imx: dynamically allocate mxc_w1 devices
      ARM: imx: remove unused devices
      ARM: imx: dynamically allocate imx_udc device
      ARM: imx: allow specifying a dma mask when creating a platform device
      ARM: imx: dynamically allocate mx1-camera device
      ARM: imx/gpio: remove some useless casts
      ARM: imx: dynamically allocate mx2-camera device
      ARM: imx: dynamically allocate imx2-wdt devices
      ARM: imx: change the way flexcan devices are registered
      ARM: imx: dynamically register imx-fb devices
      ARM: mx3: enable SPI_IMX for better compile coverage
      ARM: imx: dynamically allocate mxc_pwm devices
      ARM: imx: dynamically register mxc-mmc devices
      ARM: imx: dynamically allocate mxc-ehci devices
      ARM: imx: dynamically allocate fsl-usb2-udc devices
      ARM: imx: dynamically allocate imx-keypad devices
      ARM: imx: dynamically allocate imx21-hcd devices
      ARM: imx: remove now empty devices.h
      ARM: imx: move registration of gpios to plat-mxc/gpio.c
      ARM: mx25: dynamically allocate mxc-ehci devices
      ARM: mx25: dynamically allocate fsl-usb2-udc devices
      ARM: mx25: dynamically allocate mxc_pwm devices
      ARM: mx25: move registration of gpios to plat-mxc/gpio.c
      ARM: mx25: dynamically allocate imx-keypad devices
      ARM: mx25: dynamically allocate imxdi_rtc devices
      ARM: mx25: dynamically allocatate imx-fb devices
      ARM: mx25: dynamically allocate imx2-wdt devices
      ARM: mx25: dynamically allocate mx2-camera devices
      ARM: mx25: remove now empty devices.h
      ARM: imx: move mx25 support to mach-imx
      ARM: imx: let IMX_HAVE_PLATFORM_IMX_FB select HAVE_FB_IMX
      ARM: imx: let the machines select SOC_IMX{21,27}
      ARM: imx: use SOC_IMX25 instead of ARCH_MX25 for multi-SoC
      ARM: mx3: move registration of gpios to plat-mxc/gpio.c
      ARM: mx3: use an MX35 constant in imx35 only code
      ARM: mx3: introduce SOC_IMX31 and SOC_IMX35
      ARM: mx3: dynamically register mxc-mmc devices
      ARM: mx3: dynamically allocate mxc_rnga devices
      ARM: mx3: dynamically allocate fsl-usb2-udc devices
      ARM: mx3: dynamically allocate mxc-ehci devices
      ARM: mx3: dynamically allocate imx2-wdt devices
      ARM: mx3: dynamically allocate imx-keypad devices
      ARM: mx3/mx35_3ds: Add watchdog support
      ARM: imx: fix name for functions adding sdhci-esdhc-imx devices
      ARM: mx25: fix offset for usb host controller

Vasiliy Kulikov (1):
      arm: dma: check clk_get() result

Yong Shen (2):
      ARM i.MX53: Some bug fix about MX53 MSL code
      ARM i.MX53: Make MX53 EVK bootable

 arch/arm/Kconfig                                   |   10 +
 arch/arm/Makefile                                  |    3 +-
 arch/arm/configs/mx3_defconfig                     |    1 +
 arch/arm/mach-imx/Kconfig                          |  138 ++-
 arch/arm/mach-imx/Makefile                         |    8 +-
 arch/arm/mach-imx/Makefile.boot                    |    4 +
 arch/arm/mach-imx/clock-imx21.c                    |    2 +-
 .../{mach-mx25/clock.c => mach-imx/clock-imx25.c}  |    2 +-
 arch/arm/mach-imx/clock-imx27.c                    |   24 +-
 arch/arm/mach-imx/cpu-imx27.c                      |   14 +-
 arch/arm/mach-imx/devices-imx21.h                  |   24 +
 arch/arm/mach-imx/devices-imx25.h                  |   87 +
 arch/arm/mach-imx/devices-imx27.h                  |   35 +
 arch/arm/mach-imx/devices.c                        |  553 ------
 arch/arm/mach-imx/devices.h                        |   29 -
 arch/arm/mach-imx/dma-v1.c                         |    4 +-
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |   17 +-
 .../eukrea_mbimxsd25-baseboard.c}                  |   10 +-
 arch/arm/mach-imx/mach-cpuimx27.c                  |   21 +-
 .../mach-eukrea_cpuimx25.c}                        |   19 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |   12 +-
 arch/arm/mach-imx/mach-imx27lite.c                 |    1 -
 arch/arm/mach-imx/mach-mx1ads.c                    |    1 -
 arch/arm/mach-imx/mach-mx21ads.c                   |   20 +-
 arch/arm/{mach-mx25 => mach-imx}/mach-mx25_3ds.c   |   34 +-
 arch/arm/mach-imx/mach-mx27_3ds.c                  |  160 ++-
 arch/arm/mach-imx/mach-mx27ads.c                   |   17 +-
 arch/arm/mach-imx/mach-mxt_td60.c                  |   11 +-
 arch/arm/mach-imx/mach-pca100.c                    |   33 +-
 arch/arm/mach-imx/mach-pcm038.c                    |   12 +-
 arch/arm/mach-imx/mach-scb9328.c                   |    1 -
 arch/arm/mach-imx/mm-imx1.c                        |    7 +-
 arch/arm/mach-imx/mm-imx21.c                       |   21 +-
 arch/arm/{mach-mx25/mm.c => mach-imx/mm-imx25.c}   |   27 +-
 arch/arm/mach-imx/mm-imx27.c                       |   21 +-
 arch/arm/mach-imx/pcm970-baseboard.c               |   12 +-
 arch/arm/mach-imx/pm-imx27.c                       |    3 +
 arch/arm/mach-mx25/Kconfig                         |   34 -
 arch/arm/mach-mx25/Makefile                        |    5 -
 arch/arm/mach-mx25/Makefile.boot                   |    3 -
 arch/arm/mach-mx25/devices-imx25.h                 |   54 -
 arch/arm/mach-mx25/devices.c                       |  308 ----
 arch/arm/mach-mx25/devices.h                       |   13 -
 arch/arm/mach-mx3/Kconfig                          |   84 +-
 arch/arm/mach-mx3/Makefile                         |    7 +-
 arch/arm/mach-mx3/clock-imx31.c                    |    4 +-
 arch/arm/mach-mx3/clock-imx35.c                    |    2 +-
 arch/arm/mach-mx3/cpu.c                            |   31 +-
 arch/arm/mach-mx3/devices-imx31.h                  |   27 +
 arch/arm/mach-mx3/devices-imx35.h                  |   41 +-
 arch/arm/mach-mx3/devices.c                        |  271 +---
 arch/arm/mach-mx3/devices.h                        |   10 -
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c       |    4 +-
 arch/arm/mach-mx3/mach-armadillo5x0.c              |   14 +-
 arch/arm/mach-mx3/mach-cpuimx35.c                  |   22 +-
 arch/arm/mach-mx3/mach-kzm_arm11_01.c              |    6 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |  124 ++-
 arch/arm/mach-mx3/mach-mx31lilly.c                 |    9 +-
 arch/arm/mach-mx3/mach-mx31lite.c                  |    5 +-
 arch/arm/mach-mx3/mach-mx31moboard.c               |   20 +-
 arch/arm/mach-mx3/mach-mx35_3ds.c                  |   40 +-
 arch/arm/mach-mx3/mach-pcm037.c                    |   23 +-
 arch/arm/mach-mx3/mach-pcm043.c                    |   48 +-
 arch/arm/mach-mx3/mm.c                             |   84 +-
 arch/arm/mach-mx3/mx31lilly-db.c                   |    5 +-
 arch/arm/mach-mx3/mx31lite-db.c                    |    8 +-
 arch/arm/mach-mx3/mx31moboard-devboard.c           |   20 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c            |   21 +-
 arch/arm/mach-mx3/mx31moboard-smartbot.c           |   16 +-
 arch/arm/mach-mx5/Kconfig                          |   63 +-
 arch/arm/mach-mx5/Makefile                         |    5 +-
 arch/arm/mach-mx5/Makefile.boot                    |   12 +-
 arch/arm/mach-mx5/board-cpuimx51.c                 |   32 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c               |   68 +-
 arch/arm/mach-mx5/board-mx50_rdp.c                 |  197 ++
 arch/arm/mach-mx5/board-mx51_3ds.c                 |    9 +-
 arch/arm/mach-mx5/board-mx51_babbage.c             |  101 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c             |  247 +++-
 arch/arm/mach-mx5/board-mx53_evk.c                 |   84 +
 .../mach-mx5/{clock-mx51.c => clock-mx51-mx53.c}   |  296 +++-
 arch/arm/mach-mx5/cpu.c                            |  118 +-
 arch/arm/mach-mx5/crm_regs.h                       |   10 +-
 arch/arm/mach-mx5/devices-imx51.h                  |   11 +-
 arch/arm/mach-mx5/devices-imx53.h                  |   13 +
 arch/arm/mach-mx5/devices-mx50.h                   |   26 +
 arch/arm/mach-mx5/devices.c                        |   51 +-
 arch/arm/mach-mx5/devices.h                        |    2 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c       |   26 +-
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c       |   17 +-
 arch/arm/mach-mx5/mm-mx50.c                        |   59 +
 arch/arm/mach-mx5/mm.c                             |   75 +-
 arch/arm/mach-mxc91231/mm.c                        |   53 +-
 arch/arm/mach-mxs/Kconfig                          |   34 +
 arch/arm/mach-mxs/Makefile                         |   10 +
 arch/arm/mach-mxs/Makefile.boot                    |    1 +
 arch/arm/mach-mxs/clock-mx23.c                     |  526 ++++++
 arch/arm/mach-mxs/clock-mx28.c                     |  734 ++++++++
 arch/arm/mach-mxs/clock.c                          |  200 ++
 arch/arm/mach-mxs/devices-mx23.h                   |   16 +
 arch/arm/mach-mxs/devices-mx28.h                   |   20 +
 arch/arm/mach-mxs/devices.c                        |   75 +
 arch/arm/mach-mxs/devices/Kconfig                  |    5 +
 arch/arm/mach-mxs/devices/Makefile                 |    2 +
 arch/arm/mach-mxs/devices/platform-duart.c         |   48 +
 arch/arm/mach-mxs/devices/platform-fec.c           |   50 +
 arch/arm/mach-mxs/gpio.c                           |  325 ++++
 arch/arm/mach-mxs/gpio.h                           |   34 +
 arch/arm/mach-mxs/icoll.c                          |   81 +
 arch/arm/mach-mxs/include/mach/clkdev.h            |    7 +
 arch/arm/mach-mxs/include/mach/clock.h             |   64 +
 arch/arm/mach-mxs/include/mach/common.h            |   31 +
 arch/arm/mach-mxs/include/mach/debug-macro.S       |   38 +
 arch/arm/mach-mxs/include/mach/devices-common.h    |   46 +
 arch/arm/mach-mxs/include/mach/entry-macro.S       |   41 +
 arch/arm/mach-mxs/include/mach/gpio.h              |   35 +
 arch/arm/mach-mxs/include/mach/hardware.h          |   29 +
 arch/arm/mach-mxs/include/mach/io.h                |   22 +
 arch/arm/mach-mxs/include/mach/iomux-mx23.h        |  355 ++++
 arch/arm/mach-mxs/include/mach/iomux-mx28.h        |  537 ++++++
 arch/arm/mach-mxs/include/mach/iomux.h             |  165 ++
 arch/arm/mach-mxs/include/mach/irqs.h              |   32 +
 arch/arm/mach-mxs/include/mach/memory.h            |   24 +
 arch/arm/mach-mxs/include/mach/mx23.h              |  145 ++
 arch/arm/mach-mxs/include/mach/mx28.h              |  188 ++
 arch/arm/mach-mxs/include/mach/mxs.h               |  105 ++
 arch/arm/mach-mxs/include/mach/system.h            |   27 +
 arch/arm/mach-mxs/include/mach/timex.h             |   21 +
 arch/arm/mach-mxs/include/mach/uncompress.h        |   76 +
 arch/arm/mach-mxs/include/mach/vmalloc.h           |   22 +
 arch/arm/mach-mxs/iomux.c                          |  101 ++
 arch/arm/mach-mxs/mach-mx23evk.c                   |   57 +
 arch/arm/mach-mxs/mach-mx28evk.c                   |  138 ++
 arch/arm/mach-mxs/mm-mx23.c                        |   45 +
 arch/arm/mach-mxs/mm-mx28.c                        |   45 +
 arch/arm/mach-mxs/regs-clkctrl-mx23.h              |  455 +++++
 arch/arm/mach-mxs/regs-clkctrl-mx28.h              |  663 +++++++
 arch/arm/mach-mxs/system.c                         |  137 ++
 arch/arm/mach-mxs/timer.c                          |  296 +++
 arch/arm/plat-mxc/Kconfig                          |   15 +-
 arch/arm/plat-mxc/Makefile                         |    5 +-
 arch/arm/plat-mxc/audmux-v2.c                      |    4 +-
 arch/arm/plat-mxc/{irq.c => avic.c}                |   32 +-
 arch/arm/plat-mxc/cpufreq.c                        |    1 -
 arch/arm/plat-mxc/devices.c                        |   23 +-
 arch/arm/plat-mxc/devices/Kconfig                  |   54 +-
 arch/arm/plat-mxc/devices/Makefile                 |   16 +-
 arch/arm/plat-mxc/devices/platform-esdhc.c         |   71 -
 arch/arm/plat-mxc/devices/platform-fec.c           |    8 +-
 arch/arm/plat-mxc/devices/platform-flexcan.c       |   48 +-
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c  |   56 +
 arch/arm/plat-mxc/devices/platform-imx-dma.c       |  127 ++-
 arch/arm/plat-mxc/devices/platform-imx-fb.c        |   52 +
 arch/arm/plat-mxc/devices/platform-imx-i2c.c       |   16 +-
 arch/arm/plat-mxc/devices/platform-imx-keypad.c    |   62 +
 arch/arm/plat-mxc/devices/platform-imx-ssi.c       |   17 +-
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |   38 +-
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c      |   68 +
 arch/arm/plat-mxc/devices/platform-imx21-hcd.c     |   41 +
 arch/arm/plat-mxc/devices/platform-imx_udc.c       |   75 +
 arch/arm/plat-mxc/devices/platform-imxdi_rtc.c     |   41 +
 arch/arm/plat-mxc/devices/platform-mx1-camera.c    |   42 +
 arch/arm/plat-mxc/devices/platform-mx2-camera.c    |   64 +
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c      |   69 +
 arch/arm/plat-mxc/devices/platform-mxc-mmc.c       |   72 +
 arch/arm/plat-mxc/devices/platform-mxc_nand.c      |   10 +-
 arch/arm/plat-mxc/devices/platform-mxc_pwm.c       |   60 +
 arch/arm/plat-mxc/devices/platform-mxc_rnga.c      |   56 +
 arch/arm/plat-mxc/devices/platform-mxc_w1.c        |   50 +
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   74 +
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |   16 +-
 arch/arm/plat-mxc/ehci.c                           |   77 +-
 arch/arm/plat-mxc/gpio.c                           |  114 ++-
 arch/arm/plat-mxc/include/mach/common.h            |    9 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |   23 +-
 arch/arm/plat-mxc/include/mach/devices-common.h    |  174 ++-
 arch/arm/plat-mxc/include/mach/entry-macro.S       |   14 +-
 arch/arm/plat-mxc/include/mach/gpio.h              |    5 +
 arch/arm/plat-mxc/include/mach/hardware.h          |   94 +-
 arch/arm/plat-mxc/include/mach/imxfb.h             |    3 +
 arch/arm/plat-mxc/include/mach/iomux-mx50.h        |  977 ++++++++++
 arch/arm/plat-mxc/include/mach/iomux-mx51.h        | 1898 ++++++++++++++++----
 arch/arm/plat-mxc/include/mach/iomux-mx53.h        |  323 ++++
 arch/arm/plat-mxc/include/mach/iomux-v3.h          |   64 +-
 arch/arm/plat-mxc/include/mach/irqs.h              |    8 +-
 arch/arm/plat-mxc/include/mach/memory.h            |    8 +-
 arch/arm/plat-mxc/include/mach/mx1.h               |  155 +--
 arch/arm/plat-mxc/include/mach/mx21.h              |   50 +-
 arch/arm/plat-mxc/include/mach/mx25.h              |   46 +-
 arch/arm/plat-mxc/include/mach/mx27.h              |  105 +-
 arch/arm/plat-mxc/include/mach/mx2x.h              |  149 --
 arch/arm/plat-mxc/include/mach/mx31.h              |   87 +-
 arch/arm/plat-mxc/include/mach/mx35.h              |   51 +-
 arch/arm/plat-mxc/include/mach/mx3x.h              |  198 +--
 arch/arm/plat-mxc/include/mach/mx50.h              |  285 +++
 arch/arm/plat-mxc/include/mach/mx51.h              |   73 +-
 arch/arm/plat-mxc/include/mach/mx53.h              |  353 ++++
 arch/arm/plat-mxc/include/mach/mxc.h               |   42 +-
 arch/arm/plat-mxc/include/mach/mxc91231.h          |   23 +-
 arch/arm/plat-mxc/include/mach/mxc_ehci.h          |    1 +
 arch/arm/plat-mxc/include/mach/sdma.h              |   46 +
 arch/arm/plat-mxc/include/mach/uncompress.h        |    8 +
 arch/arm/plat-mxc/iomux-v3.c                       |   31 +-
 arch/arm/plat-mxc/irq-common.c                     |   60 +
 arch/arm/plat-mxc/irq-common.h                     |   29 +
 arch/arm/plat-mxc/system.c                         |   10 +-
 arch/arm/plat-mxc/tzic.c                           |   46 +-
 drivers/dma/imx-sdma.c                             |  174 +-
 drivers/usb/gadget/fsl_mxc_udc.c                   |    4 +-
 drivers/usb/host/ehci-mxc.c                        |   44 +-
 drivers/watchdog/imx2_wdt.c                        |    2 +-
 210 files changed, 14123 insertions(+), 3567 deletions(-)
 rename arch/arm/{mach-mx25/clock.c => mach-imx/clock-imx25.c} (99%)
 create mode 100644 arch/arm/mach-imx/devices-imx25.h
 delete mode 100644 arch/arm/mach-imx/devices.c
 delete mode 100644 arch/arm/mach-imx/devices.h
 rename arch/arm/{mach-mx25/eukrea_mbimxsd-baseboard.c => mach-imx/eukrea_mbimxsd25-baseboard.c} (96%)
 rename arch/arm/{mach-mx25/mach-cpuimx25.c => mach-imx/mach-eukrea_cpuimx25.c} (89%)
 rename arch/arm/{mach-mx25 => mach-imx}/mach-mx25_3ds.c (86%)
 rename arch/arm/{mach-mx25/mm.c => mach-imx/mm-imx25.c} (69%)
 delete mode 100644 arch/arm/mach-mx25/Kconfig
 delete mode 100644 arch/arm/mach-mx25/Makefile
 delete mode 100644 arch/arm/mach-mx25/Makefile.boot
 delete mode 100644 arch/arm/mach-mx25/devices-imx25.h
 delete mode 100644 arch/arm/mach-mx25/devices.c
 delete mode 100644 arch/arm/mach-mx25/devices.h
 create mode 100644 arch/arm/mach-mx5/board-mx50_rdp.c
 create mode 100644 arch/arm/mach-mx5/board-mx53_evk.c
 rename arch/arm/mach-mx5/{clock-mx51.c => clock-mx51-mx53.c} (79%)
 create mode 100644 arch/arm/mach-mx5/devices-imx53.h
 create mode 100644 arch/arm/mach-mx5/devices-mx50.h
 create mode 100644 arch/arm/mach-mx5/mm-mx50.c
 create mode 100644 arch/arm/mach-mxs/Kconfig
 create mode 100644 arch/arm/mach-mxs/Makefile
 create mode 100644 arch/arm/mach-mxs/Makefile.boot
 create mode 100644 arch/arm/mach-mxs/clock-mx23.c
 create mode 100644 arch/arm/mach-mxs/clock-mx28.c
 create mode 100644 arch/arm/mach-mxs/clock.c
 create mode 100644 arch/arm/mach-mxs/devices-mx23.h
 create mode 100644 arch/arm/mach-mxs/devices-mx28.h
 create mode 100644 arch/arm/mach-mxs/devices.c
 create mode 100644 arch/arm/mach-mxs/devices/Kconfig
 create mode 100644 arch/arm/mach-mxs/devices/Makefile
 create mode 100644 arch/arm/mach-mxs/devices/platform-duart.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-fec.c
 create mode 100644 arch/arm/mach-mxs/gpio.c
 create mode 100644 arch/arm/mach-mxs/gpio.h
 create mode 100644 arch/arm/mach-mxs/icoll.c
 create mode 100644 arch/arm/mach-mxs/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-mxs/include/mach/clock.h
 create mode 100644 arch/arm/mach-mxs/include/mach/common.h
 create mode 100644 arch/arm/mach-mxs/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-mxs/include/mach/devices-common.h
 create mode 100644 arch/arm/mach-mxs/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-mxs/include/mach/gpio.h
 create mode 100644 arch/arm/mach-mxs/include/mach/hardware.h
 create mode 100644 arch/arm/mach-mxs/include/mach/io.h
 create mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx23.h
 create mode 100644 arch/arm/mach-mxs/include/mach/iomux-mx28.h
 create mode 100644 arch/arm/mach-mxs/include/mach/iomux.h
 create mode 100644 arch/arm/mach-mxs/include/mach/irqs.h
 create mode 100644 arch/arm/mach-mxs/include/mach/memory.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mx23.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mx28.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mxs.h
 create mode 100644 arch/arm/mach-mxs/include/mach/system.h
 create mode 100644 arch/arm/mach-mxs/include/mach/timex.h
 create mode 100644 arch/arm/mach-mxs/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-mxs/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-mxs/iomux.c
 create mode 100644 arch/arm/mach-mxs/mach-mx23evk.c
 create mode 100644 arch/arm/mach-mxs/mach-mx28evk.c
 create mode 100644 arch/arm/mach-mxs/mm-mx23.c
 create mode 100644 arch/arm/mach-mxs/mm-mx28.c
 create mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx23.h
 create mode 100644 arch/arm/mach-mxs/regs-clkctrl-mx28.h
 create mode 100644 arch/arm/mach-mxs/system.c
 create mode 100644 arch/arm/mach-mxs/timer.c
 rename arch/arm/plat-mxc/{irq.c => avic.c} (89%)
 delete mode 100644 arch/arm/plat-mxc/devices/platform-esdhc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-fb.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-keypad.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx2-wdt.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx21-hcd.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx_udc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imxdi_rtc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mx1-camera.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mx2-camera.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc-ehci.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc-mmc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_pwm.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_rnga.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_w1.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
 create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx50.h
 create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx53.h
 create mode 100644 arch/arm/plat-mxc/include/mach/mx50.h
 create mode 100644 arch/arm/plat-mxc/include/mach/mx53.h
 create mode 100644 arch/arm/plat-mxc/irq-common.c
 create mode 100644 arch/arm/plat-mxc/irq-common.h
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
