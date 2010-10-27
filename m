From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 28 Oct 2010 08:37:55 +0900
Subject: [GIT PULL] Samsung S5P for 2.6.37 merge window
In-Reply-To: <025a01cb74fc$0d9c7890$28d569b0$%kim@samsung.com>
References: <025a01cb74fc$0d9c7890$28d569b0$%kim@samsung.com>
Message-ID: <003a01cb762f$fcf50e50$f6df2af0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I can't find merge of my branch in your tree.

Please check below again.
And if any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

Russell King - ARM Linux wrote:
> 
> Hi Russell,
> 
> Please pull Samsung S5P updates from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> for-rmk
> 
> These things are for 2.6.37 and include already merged items into your
tree
> like S5P64X0 support patches when you requested 'Last call for new machine
> support'.
> 
> If any problems, please let me know.
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> The following changes since commit
cd07202cc8262e1669edff0d97715f3dd9260917
> 
>   Linux 2.6.36-rc8
> 
> are available in the git repository at:
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> for-rmk
> 
> Abhilash Kesavan (2):
>       ARM: S5P64X0: Replace the 6440 system device class definition with
> 64x0
>       ARM: S3C2416: Add Power Management support for SMDK2416
> 
> Atul Dahiya (4):
>       ARM: S5P64X0: Fix GPIO rbank support
>       ARM: S3C24XX: Fix nand partition table for s3c24XX
>       ARM: SAMSUNG: Add setname core function for S3C24XX NAND
>       ARM: S3C2416: Change S3C2416 NAND platform device name
> 
> Ben Dooks (15):
>       ARM: SAMSUNG: Add GPIO configuration for a range of pins
>       ARM: S3C64XX: Change dev-audio.c to use S3C_GPIO_SFN() for special
> functions
>       ARM: S3C64XX: Change to using s3c_gpio_cfgpin_range()
>       ARM: S5P6442: Change to using s3c_gpio_cfgpin_range()
>       ARM: S5P64X0: Change to using s3c_gpio_cfgpin_range()
>       ARM: S5PC100: Change to using s3c_gpio_cfgpin_range()
>       ARM: S5PV210: Change to using s3c_gpio_cfgpin_range()
>       ARM: SAMSUNG: Add s3c_gpio_cfgall_range() function
>       ARM: S3C64XX: Change to using s3c_gpio_cfgall_range()
>       ARM: S5PC100: Change to using s3c_gpio_cfgall_range()
>       ARM: S5PV210: Change to using s3c_gpio_cfgall_range()
>       ARM: SAMSUNG: Add s3c_gpio_cfgrange_nopull() helper
>       ARM: S3C64XX: Change to using s3c_gpio_cfgrange_nopull()
>       ARM: S5PC100: Change to using s3c_gpio_cfgrange_nopull()
>       ARM: S5PV210: Change to using s3c_gpio_cfgrange_nopull()
> 
> Boojin Kim (1):
>       ARM: S5PV310: Fix physical address of System Controller Register
> 
> Changhwan Youn (3):
>       ARM: S5PV310: Add CPU hotplug support for S5PV310
>       ARM: S5PV310: Add support RTC
>       ARM: S5PV310: Optimize interrupt source searching code
> 
> Chanwoo Choi (3):
>       ARM: S5PV210: Add i2c information to Goni and Aquila board
>       ARM: S5PV210: Add init code of audio to Goni and Auqila board
>       ARM: S5PV210: Add voltage consumer of WM8994 to the regulator
> framework
> 
> Daein Moon (3):
>       ARM: SAMSUNG: Add the missed s3c_gpio_getpull() API
>       ARM: S5PV310: Add support SROMC
>       ARM: S5PV310: Support ethernet for SMDKV310 and SMDKC210
> 
> Darius Augulis (9):
>       ARM: S3C64XX: add frame buffer support for mach-real6410
>       ARM: S3C64XX: add nand support for mach-real6410
>       ARM: S3C64XX: add touchscreen support for mach-real6410
>       ARM: S3C64XX: add USB host support for mach-real6410
>       ARM: S3C64XX: add support for mach-mini6410
>       ARM: S3C64XX: add nand support for mach-mini6410
>       ARM: S3C64XX: add frame buffer support for mach-mini6410
>       ARM: S3C64XX: add backlight control for mach-mini6410
>       ARM: S3C64XX: add touchscreen support for mach-mini6410
> 
> Hyuk Lee (4):
>       ARM: S5PV310: Add support HSMMC and SDHCI configuration
>       ARM: S5PV310: Add HSMMC platform data
>       ARM: S5PV310: Add support HSMMC on SMDKV310 and SMDKC210
>       ARM: SAMSUNG: Modified to change of bus width and host caps
> 
> Jaecheol Lee (7):
>       ARM: S5PV310: Fix clkset_moutcore_list
>       ARM: S5PV210: Add DMC map_desc table for supporting DMC access
>       ARM: S5PV210: Add struct clk_ops for clk_fout_apll
>       ARM: S5PV210: Add MOUT_DMC0 and SCLK_DMC0 clocks
>       ARM: S5PV210: Add Register definition for CMU
>       ARM: S5PV210: Add support CPUFREQ
>       ARM: S5PV210: Update Kconfig and Makefile for supporting CPUFREQ
> driver
> 
> Jassi Brar (1):
>       ARM: S5PC100: Fix Audio, Keypad and ADC clock sources
> 
> Jemings Ko (1):
>       ARM: S5PV310: Add support Watchdog Timer
> 
> Jeongbae Seo (1):
>       ARM: SAMSUNG: Add clock types into platform data
> 
> Jongpill Lee (11):
>       ARM: S5PV310: Adds clk_sclk_usbphy0, _usbphy1, and _hdmiphy
>       ARM: S5PV310: Adds printing ACLK200, ACLK100, ACLK160 and ACLK133
>       ARM: S5PV310: Adds enable and ctrlbit for clk_vpllsrc
>       ARM: S5PV310: Adds SDMMC clock for S5PV310
>       ARM: S5PV310: Add various clocks
>       ARM: S5PV310: Add video clocks
>       ARM: S5PV310: Adds various special clocks
>       ARM: S5PV210: Add Power Management Support
>       ARM: S5PV310: Update MAX_COMBINER_NR
>       ARM: S5P: Add initial map for GPIO2 and GPIO3
>       ARM: S5PV310: Add support GPIOlib
> 
> Jongsun Han (2):
>       ARM: S5PV310: Add the definition for external interrupt
>       ARM: S5PV310: Add support External Interrupt
> 
> Joonyoung Shim (4):
>       ARM: S5PV210: Add keypad device to the GONI board
>       ARM: S5PC100: Use generic S5P GPIO Interrupt interface
>       ARM: S5PC100: Move External Interrupt definitions
>       ARM: SAMSUNG: Add common samsung_gpiolib_to_irq function
> 
> Kukjin Kim (44):
>       ARM: S5P: Move OneNAND device definitions in plat-s5p
>       ARM: S5P: Moves initial map for merging S5P64X0
>       ARM: S5P64X0: Update Kconfig and Makefile
>       ARM: S5P64X0: Add S5P64X0(S5P6440 and S5P6450) initialization
support
>       ARM: S5P64X0: Update Clock for S5P6440 and S5P6450
>       ARM: S5P64X0: Update IRQ support
>       ARM: S5P64X0: Update Timer support
>       ARM: S5P64X0: Update Audio support
>       ARM: S5P64X0: Move DMA support for S5P64X0
>       ARM: S5P64X0: Add S5P6450 I2C support
>       ARM: S5P64X0: Move GPIO support files for merge S5P64X0
>       ARM: S5P64X0: Move SMDK6440 board file and Add SMDK6450 board file
>       ARM: S5P64X0: Add UART serial support for S5P6450
>       ARM: s5p64x0_defconfig: Update for support S5P6440 and S5P6450
>       ARM: S5PV310: Fix build error on GPIO map
>       ARM: S5PV310: Add SMDKC210 board support file
>       ARM: S5PV310: update S5PV310 Kconfig for supporting multiple
machines
>       ARM: S5PV310: Adds clock addresses for S5PV310
>       ARM: S5PV310: Removed unused clock
>       ARM: S5PV310: Adds clkset_aclk for removing clkset_aclk_xxx
>       ARM: SAMSUNG: Change the 3rd HSMMC interrupt name for compatibility
>       ARM: S5P64XX: Remove redundant selection PLAT_S5P.
>       ARM: S5P64X0: 2nd Change to using s3c_gpio_cfgpin_range()
>       ARM: S5PV310: Change to using s3c_gpio_cfgpin_range()
>       ARM: S5P6442: Change to using s3c_gpio_cfgall_range()
>       ARM: S5P64X0: Change to using s3c_gpio_cfgall_range()
>       ARM: S5PV310: Change to using s3c_gpio_cfgall_range()
>       ARM: S3C64XX: 2nd Change to using s3c_gpio_cfgall_range()
>       ARM: S5P64X0: 2nd Change to using s3c_gpio_cfgall_range()
>       ARM: S5PC100: 2nd Change to using s3c_gpio_cfgall_range()
>       ARM: S5PV210: 2nd Change to using s3c_gpio_cfgall_range()
>       ARM: S3C64XX: 2nd Change to using s3c_gpio_cfgrange_nopull()
>       ARM: S5PC100: 2nd Change to using s3c_gpio_cfgrange_nopull()
>       ARM: S5PV210: 2nd Change to using s3c_gpio_cfgrange_nopull()
>       ARM: S5P: Fix missed IRQ_EINT_BIT()
>       Merge branch 'next-gpio-update' into for-next
>       ARM: S5PC100: Cleanup the GPIOlib code
>       ARM: S5P: Cleanup the S5P SoCs' VA address mapping
>       ARM: S5PC100: Change I2C2 and I2C3 IRQ names
>       Merge branch 'next-s3c24xx' into for-next
>       Merge branch 'next-s3c64xx' into for-next
>       ARM: SAMSUNG: Move the start address of Samsung SoCs' VA space
>       ARM: S3C: Change VMALLOC_END to use more vmalloc()/ioremap() area
>       ARM: S5P: Change VMALLOC_END to use more vmalloc()/ioremap() area
> 
> Kyuho Choi (1):
>       ARM: S5PV210: Add Torbreck board support
> 
> Kyungmin Park (12):
>       ARM: S5PV310: Add GPIO keys at Universal board
>       ARM: S5PV210: Place the common SPARSEMEM at ARCH_S5PV210
>       ARM: S5PV310: Place the common SPARSEMEM at ARCH_S5PV310
>       ARM: S5P: Remove redundant selection PLAT_S5P for S5PC100, S5PV210
and
> S5PV310
>       ARM: S5PV310: Universal OneNAND support
>       ARM: S5PV310: I2C0/1 devices support on Universal board
>       ARM: S5PV210: Fix wrong interrupt I2C2 and I2C3 number
>       ARM: S5PV310: Define address & interrupt for all I2C blocks
>       ARM: S5PV310: Add I2C channel 3, 4, 5, 6, and 7 device support
>       ARM: Add L2X0 PREFETCH and POWER control register
>       ARM: S5PV310: Remove L2 cache init in machine
>       ARM: S5PV310: Add L2 cache init function in cpu.c
> 
> Marek Szyprowski (11):
>       ARM: S5PV210: update framebuffer setup information for GONI
>       ARM: S5PV210: fb setup for GONI - remove pixel clock
>       ARM: S5PV210: Add Support for OTG USB Gadget on GONI board
>       ARM: S5PV210: Add Support for MMC regulators on GONI board
>       ARM: S5PV210: Enable USB HSOTG gadget build
>       ARM: S5P: Add common S5P GPIO Interrupt support
>       ARM: S5PV210: Add support for GPIO Interrupt
>       ARM: S5P: Unify defines for both gpio interrupt types
>       ARM: S5PV210: Add support for S6E63M0 LCD controller on GONI board
>       ARM: S5PV210: Add si470x radio device to the GONI board
>       ARM: S5PV210: GONI: Add support for QT602240 TS driver
> 
> Mark Brown (3):
>       ARM: S3C64XX: Fix special function for IISv4 port
>       ARM: S3C64XX: Ensure samsung_keypad_cfg_gpio() is prototyped
>       ARM: S3C64XX: Ensure s3c64xx_ide_setup_gpio() is prototyped
> 
> Naveen Krishna Ch (1):
>       ARM: S5P64X0: FIX typo in the ADC device name
> 
> Sangbeom Kim (1):
>       ARM: S5PV210: Fix build error on pm debug
> 
> SeungChull Suh (1):
>       ARM: S5P64X0: Bug fix on errors of build with CONFIG_PREEMPT_NONE
> 
> Seungwhan Youn (15):
>       ARM: S5PC100: Add S/PDIF platform device
>       ARM: S5PC100: Modify SCLK_AUDIO{0,1,2} clock as sysclks
>       ARM: S5PC100: Add SCLK_SPDIF clock
>       ARM: S5PV210: Add S/PDIF platform device
>       ARM: S5PV210: Add SCLK_SPDIF clock
>       ARM: S5PV210: Add audio clocks as sysclk
>       ARM: S5P: Reduce duplicated EPLL control codes
>       ARM: S5PV210: Fix wrong EPLL rate getting on setup clocks
>       ARM: S5PV210: Add EPLL clock operations
>       ARM: S5P: Add EPLL rate change warning
>       ARM: S5P6442: Add DMA operation clock
>       ARM: S5PV210: Add DMA operation clock
>       ARM: S5P64X0: Set DMA clock disable as default
>       ARM: S5P: Reorder DMA platform device id
>       ARM: SAMSUNG: Move DMA clock enable into S3C PL330 driver
> 
> Thomas Abraham (1):
>       ARM: S5P: Remove the unused clk_arm clock from plat-s5p
> 
> Yauhen Kharuzhy (1):
>       ARM: S3C24XX: Fix gpiolib support for ports K..M
> 
>  arch/arm/Kconfig                                   |   17 +-
>  arch/arm/Makefile                                  |    2 +-
>  .../{s5p6440_defconfig => s5p64x0_defconfig}       |    3 +-
>  arch/arm/include/asm/hardware/cache-l2x0.h         |    4 +
>  arch/arm/mach-s3c2410/include/mach/gpio.h          |   10 +-
>  .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    2 +
>  arch/arm/mach-s3c2410/include/mach/vmalloc.h       |    2 +-
>  arch/arm/mach-s3c2412/s3c2412.c                    |    3 +-
>  arch/arm/mach-s3c2416/Kconfig                      |    6 +
>  arch/arm/mach-s3c2416/Makefile                     |    2 +-
>  arch/arm/mach-s3c2416/irq.c                        |    2 +
>  arch/arm/mach-s3c2416/pm.c                         |   84 ++
>  arch/arm/mach-s3c2416/s3c2416.c                    |    3 +-
>  arch/arm/mach-s3c2440/s3c244x.c                    |    3 +-
>  arch/arm/mach-s3c2443/s3c2443.c                    |    3 +-
>  arch/arm/mach-s3c24a0/include/mach/vmalloc.h       |    2 +-
>  arch/arm/mach-s3c64xx/Kconfig                      |   21 +
>  arch/arm/mach-s3c64xx/Makefile                     |    1 +
>  arch/arm/mach-s3c64xx/dev-audio.c                  |   64 +--
>  arch/arm/mach-s3c64xx/gpiolib.c                    |    8 +-
>  arch/arm/mach-s3c64xx/include/mach/vmalloc.h       |    2 +-
>  arch/arm/mach-s3c64xx/mach-mini6410.c              |  357 +++++++++
>  arch/arm/mach-s3c64xx/mach-real6410.c              |  198 +++++-
>  arch/arm/mach-s3c64xx/setup-fb-24bpp.c             |   13 +-
>  arch/arm/mach-s3c64xx/setup-ide.c                  |   11 +-
>  arch/arm/mach-s3c64xx/setup-keypad.c               |   16 +-
>  arch/arm/mach-s3c64xx/setup-sdhci-gpio.c           |   41 +-
>  arch/arm/mach-s5p6440/Kconfig                      |   33 -
>  arch/arm/mach-s5p6440/Makefile                     |   25 -
>  arch/arm/mach-s5p6440/clock.c                      |  846
> --------------------
>  arch/arm/mach-s5p6440/cpu.c                        |  117 ---
>  arch/arm/mach-s5p6440/dev-audio.c                  |  127 ---
>  arch/arm/mach-s5p6440/dev-spi.c                    |  176 ----
>  arch/arm/mach-s5p6440/include/mach/debug-macro.S   |   37 -
>  arch/arm/mach-s5p6440/include/mach/gpio.h          |   80 --
>  arch/arm/mach-s5p6440/include/mach/io.h            |   18 -
>  arch/arm/mach-s5p6440/include/mach/map.h           |   86 --
>  arch/arm/mach-s5p6440/include/mach/regs-clock.h    |  130 ---
>  arch/arm/mach-s5p6440/include/mach/spi-clocks.h    |   17 -
>  arch/arm/mach-s5p6440/include/mach/uncompress.h    |   24 -
>  arch/arm/mach-s5p6440/init.c                       |   52 --
>  arch/arm/mach-s5p6440/setup-i2c0.c                 |   30 -
>  arch/arm/mach-s5p6440/setup-i2c1.c                 |   30 -
>  arch/arm/mach-s5p6442/Kconfig                      |    1 -
>  arch/arm/mach-s5p6442/clock.c                      |   28 +
>  arch/arm/mach-s5p6442/cpu.c                        |   27 +-
>  arch/arm/mach-s5p6442/dev-audio.c                  |   30 +-
>  arch/arm/mach-s5p6442/dev-spi.c                    |    6 +-
>  arch/arm/mach-s5p6442/dma.c                        |    2 +-
>  arch/arm/mach-s5p6442/include/mach/map.h           |    6 -
>  arch/arm/mach-s5p6442/include/mach/regs-clock.h    |    1 +
>  arch/arm/mach-s5p6442/include/mach/vmalloc.h       |    2 +-
>  arch/arm/mach-s5p64x0/Kconfig                      |   55 ++
>  arch/arm/mach-s5p64x0/Makefile                     |   30 +
>  .../{mach-s5p6440 => mach-s5p64x0}/Makefile.boot   |    0
>  arch/arm/mach-s5p64x0/clock-s5p6440.c              |  629 +++++++++++++++
>  arch/arm/mach-s5p64x0/clock-s5p6450.c              |  658 +++++++++++++++
>  arch/arm/mach-s5p64x0/clock.c                      |  235 ++++++
>  arch/arm/mach-s5p64x0/cpu.c                        |  209 +++++
>  arch/arm/mach-s5p64x0/dev-audio.c                  |  152 ++++
>  arch/arm/mach-s5p64x0/dev-spi.c                    |  222 +++++
>  arch/arm/{mach-s5p6440 => mach-s5p64x0}/dma.c      |   86 ++-
>  arch/arm/{mach-s5p6440 => mach-s5p64x0}/gpio.c     |  104 ++--
>  arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |   33 +
>  .../include/mach/dma.h                             |    0
>  .../include/mach/entry-macro.S                     |    8 +-
>  arch/arm/mach-s5p64x0/include/mach/gpio.h          |  139 ++++
>  .../include/mach/hardware.h                        |    8 +-
>  arch/arm/mach-s5p64x0/include/mach/i2c.h           |   17 +
>  arch/arm/mach-s5p64x0/include/mach/io.h            |   25 +
>  .../include/mach/irqs.h                            |   48 +-
>  arch/arm/mach-s5p64x0/include/mach/map.h           |   83 ++
>  .../include/mach/memory.h                          |   12 +-
>  .../include/mach/pwm-clock.h                       |   10 +-
>  arch/arm/mach-s5p64x0/include/mach/regs-clock.h    |   65 ++
>  .../include/mach/regs-gpio.h                       |   28 +-
>  .../include/mach/regs-irq.h                        |    8 +-
>  arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h |   46 ++
>  arch/arm/mach-s5p64x0/include/mach/spi-clocks.h    |   20 +
>  .../include/mach/system.h                          |    8 +-
>  .../include/mach/tick.h                            |   13 +-
>  .../include/mach/timex.h                           |    7 +-
>  arch/arm/mach-s5p64x0/include/mach/uncompress.h    |  212 +++++
>  .../include/mach/vmalloc.h                         |    7 +-
>  arch/arm/mach-s5p64x0/init.c                       |   73 ++
>  .../{mach-s5p6440 => mach-s5p64x0}/mach-smdk6440.c |   87 ++-
>  arch/arm/mach-s5p64x0/mach-smdk6450.c              |  182 +++++
>  arch/arm/mach-s5p64x0/setup-i2c0.c                 |   38 +
>  arch/arm/mach-s5p64x0/setup-i2c1.c                 |   38 +
>  arch/arm/mach-s5pc100/Kconfig                      |    1 -
>  arch/arm/mach-s5pc100/Makefile                     |    2 +-
>  arch/arm/mach-s5pc100/clock.c                      |  174 +++--
>  arch/arm/mach-s5pc100/cpu.c                        |   25 +-
>  arch/arm/mach-s5pc100/dev-audio.c                  |   86 ++-
>  arch/arm/mach-s5pc100/dev-spi.c                    |   22 +-
>  arch/arm/mach-s5pc100/dma.c                        |    4 +-
>  arch/arm/mach-s5pc100/gpiolib.c                    |  216 ++----
>  arch/arm/mach-s5pc100/include/mach/gpio.h          |    7 -
>  arch/arm/mach-s5pc100/include/mach/irqs.h          |   13 +-
>  arch/arm/mach-s5pc100/include/mach/map.h           |   13 +-
>  arch/arm/mach-s5pc100/include/mach/regs-gpio.h     |   49 +-
>  arch/arm/mach-s5pc100/include/mach/vmalloc.h       |    2 +-
>  arch/arm/mach-s5pc100/irq-gpio.c                   |  266 ------
>  arch/arm/mach-s5pc100/mach-smdkc100.c              |    4 +
>  arch/arm/mach-s5pc100/setup-fb-24bpp.c             |   30 +-
>  arch/arm/mach-s5pc100/setup-i2c0.c                 |    6 +-
>  arch/arm/mach-s5pc100/setup-i2c1.c                 |    6 +-
>  arch/arm/mach-s5pc100/setup-ide.c                  |   41 +-
>  arch/arm/mach-s5pc100/setup-keypad.c               |   15 +-
>  arch/arm/mach-s5pc100/setup-sdhci-gpio.c           |   35 +-
>  arch/arm/mach-s5pv210/Kconfig                      |   46 +-
>  arch/arm/mach-s5pv210/Makefile                     |    4 +-
>  arch/arm/mach-s5pv210/clock.c                      |  207 +++++-
>  arch/arm/mach-s5pv210/cpu.c                        |   37 +-
>  arch/arm/mach-s5pv210/cpufreq.c                    |  484 +++++++++++
>  arch/arm/mach-s5pv210/dev-audio.c                  |   86 ++-
>  arch/arm/mach-s5pv210/dev-spi.c                    |   19 +-
>  arch/arm/mach-s5pv210/dma.c                        |    4 +-
>  arch/arm/mach-s5pv210/gpiolib.c                    |   14 +-
>  arch/arm/mach-s5pv210/include/mach/irqs.h          |   12 +-
>  arch/arm/mach-s5pv210/include/mach/map.h           |   23 +-
>  arch/arm/mach-s5pv210/include/mach/pm-core.h       |   43 +
>  arch/arm/mach-s5pv210/include/mach/regs-clock.h    |   39 +-
>  arch/arm/mach-s5pv210/include/mach/regs-gpio.h     |    7 -
>  arch/arm/mach-s5pv210/include/mach/regs-sys.h      |   19 +
>  arch/arm/mach-s5pv210/include/mach/vmalloc.h       |    2 +-
>  arch/arm/mach-s5pv210/mach-aquila.c                |  171 ++++-
>  arch/arm/mach-s5pv210/mach-goni.c                  |  383 +++++++++-
>  arch/arm/mach-s5pv210/mach-smdkc110.c              |    4 +
>  arch/arm/mach-s5pv210/mach-smdkv210.c              |    4 +
>  arch/arm/mach-s5pv210/mach-torbreck.c              |  131 +++
>  arch/arm/mach-s5pv210/pm.c                         |  166 ++++
>  arch/arm/mach-s5pv210/setup-fb-24bpp.c             |   34 +-
>  arch/arm/mach-s5pv210/setup-i2c0.c                 |    6 +-
>  arch/arm/mach-s5pv210/setup-i2c1.c                 |    6 +-
>  arch/arm/mach-s5pv210/setup-i2c2.c                 |    6 +-
>  arch/arm/mach-s5pv210/setup-ide.c                  |   49 +-
>  arch/arm/mach-s5pv210/setup-keypad.c               |   14 +-
>  arch/arm/mach-s5pv210/setup-sdhci-gpio.c           |   57 +-
>  arch/arm/mach-s5pv210/sleep.S                      |  170 ++++
>  arch/arm/mach-s5pv310/Kconfig                      |   95 ++-
>  arch/arm/mach-s5pv310/Makefile                     |   10 +-
>  arch/arm/mach-s5pv310/clock.c                      |  635 +++++++++++++--
>  arch/arm/mach-s5pv310/cpu.c                        |   71 ++-
>  arch/arm/mach-s5pv310/gpiolib.c                    |  304 +++++++
>  arch/arm/mach-s5pv310/hotplug.c                    |  144 ++++
>  arch/arm/mach-s5pv310/include/mach/irqs.h          |   46 +-
>  arch/arm/mach-s5pv310/include/mach/map.h           |   26 +-
>  arch/arm/mach-s5pv310/include/mach/regs-clock.h    |   32 +-
>  arch/arm/mach-s5pv310/include/mach/regs-gpio.h     |   42 +
>  arch/arm/mach-s5pv310/include/mach/regs-srom.h     |   50 ++
>  arch/arm/mach-s5pv310/include/mach/vmalloc.h       |    2 +-
>  arch/arm/mach-s5pv310/irq-combiner.c               |    6 +-
>  arch/arm/mach-s5pv310/irq-eint.c                   |  228 ++++++
>  arch/arm/mach-s5pv310/mach-smdkc210.c              |  202 +++++
>  arch/arm/mach-s5pv310/mach-smdkv310.c              |  121 +++-
>  arch/arm/mach-s5pv310/mach-universal_c210.c        |   81 ++-
>  arch/arm/mach-s5pv310/setup-i2c0.c                 |    6 +-
>  arch/arm/mach-s5pv310/setup-i2c1.c                 |    6 +-
>  arch/arm/mach-s5pv310/setup-i2c2.c                 |    6 +-
>  arch/arm/mach-s5pv310/setup-i2c3.c                 |   23 +
>  arch/arm/mach-s5pv310/setup-i2c4.c                 |   23 +
>  arch/arm/mach-s5pv310/setup-i2c5.c                 |   23 +
>  arch/arm/mach-s5pv310/setup-i2c6.c                 |   23 +
>  arch/arm/mach-s5pv310/setup-i2c7.c                 |   23 +
>  arch/arm/mach-s5pv310/setup-sdhci-gpio.c           |  152 ++++
>  arch/arm/mach-s5pv310/setup-sdhci.c                |   69 ++
>  arch/arm/plat-s3c24xx/common-smdk.c                |    2 +-
>  arch/arm/plat-s3c24xx/gpiolib.c                    |    8 +-
>  arch/arm/plat-s5p/Kconfig                          |   14 +-
>  arch/arm/plat-s5p/Makefile                         |    4 +
>  arch/arm/plat-s5p/clock.c                          |   48 +-
>  arch/arm/plat-s5p/cpu.c                            |   34 +-
>  arch/arm/{mach-s5pv210 => plat-s5p}/dev-onenand.c  |   28 +-
>  arch/arm/plat-s5p/dev-uart.c                       |   58 ++
>  arch/arm/plat-s5p/include/plat/irqs.h              |   18 +
>  arch/arm/plat-s5p/include/plat/map-s5p.h           |   40 +-
>  arch/arm/plat-s5p/include/plat/pll.h               |    7 +
>  arch/arm/plat-s5p/include/plat/s5p-clock.h         |   12 +-
>  arch/arm/plat-s5p/include/plat/s5p6440.h           |    7 +-
>  arch/arm/plat-s5p/include/plat/s5p6450.h           |   36 +
>  arch/arm/plat-s5p/irq-eint.c                       |   10 +-
>  arch/arm/plat-s5p/irq-gpioint.c                    |  237 ++++++
>  arch/arm/plat-s5p/irq-pm.c                         |   93 +++
>  arch/arm/plat-s5p/pm.c                             |   52 ++
>  arch/arm/plat-samsung/Kconfig                      |   25 +
>  arch/arm/plat-samsung/Makefile                     |    5 +
>  arch/arm/plat-samsung/dev-hsmmc.c                  |    8 +-
>  arch/arm/plat-samsung/dev-hsmmc1.c                 |    8 +-
>  arch/arm/plat-samsung/dev-hsmmc2.c                 |    8 +-
>  arch/arm/plat-samsung/dev-hsmmc3.c                 |   12 +-
>  arch/arm/plat-samsung/dev-i2c2.c                   |    4 +-
>  arch/arm/plat-samsung/dev-i2c3.c                   |   68 ++
>  arch/arm/plat-samsung/dev-i2c4.c                   |   68 ++
>  arch/arm/plat-samsung/dev-i2c5.c                   |   68 ++
>  arch/arm/plat-samsung/dev-i2c6.c                   |   68 ++
>  arch/arm/plat-samsung/dev-i2c7.c                   |   68 ++
>  arch/arm/plat-samsung/gpio-config.c                |   50 ++
>  arch/arm/plat-samsung/gpio.c                       |    8 +
>  arch/arm/plat-samsung/include/plat/audio.h         |    9 +
>  arch/arm/plat-samsung/include/plat/cpu.h           |    2 +-
>  arch/arm/plat-samsung/include/plat/devs.h          |   14 +-
>  .../plat-samsung/include/plat/gpio-cfg-helpers.h   |    6 +
>  arch/arm/plat-samsung/include/plat/gpio-cfg.h      |   56 ++
>  arch/arm/plat-samsung/include/plat/gpio-core.h     |   15 +
>  arch/arm/plat-samsung/include/plat/iic.h           |   10 +
>  arch/arm/plat-samsung/include/plat/map-base.h      |    4 +-
>  arch/arm/plat-samsung/include/plat/nand-core.h     |   28 +
>  arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h |   20 +
>  arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |    2 +-
>  arch/arm/plat-samsung/include/plat/sdhci.h         |   64 ++
>  arch/arm/plat-samsung/pm-gpio.c                    |    4 +-
>  arch/arm/plat-samsung/s3c-pl330.c                  |   34 +-
>  drivers/serial/Kconfig                             |    7 +-
>  drivers/serial/samsung.c                           |    2 +-
>  215 files changed, 10257 insertions(+), 3315 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe
linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
