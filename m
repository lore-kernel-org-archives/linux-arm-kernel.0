From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:17:40 +0900
Subject: [GIT PULL 0/10] Samsung stuff for v3.10
Message-ID: <516309C4.3000008@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

This is 2nd pull-request for Samsung stuff for v3.10.

If any problems, please kindly let me know.


-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.



The following changes since commit 347394370cbd68ab440564357eaf3d0a5b8bddeb:

   Merge branch 'next/pinctrl-exynos-1' into for-next-next (2013-04-09 
01:07:43 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
for-next

Abhilash Kesavan (1):
       ARM: dts: Add max77686 device tree support for CROS5250

Alexander Graf (2):
       ARM: dts: Declare the gic as a15 compatible for exynos5250
       ARM: dts: Add architected timer nodes for exynos5250

Alexander Shiyan (3):
       ARM: S3C24XX: Removed unneeded dependency on ARCH_S3C24XX for boards
       ARM: S3C24XX: Removed unneeded dependency on CPU_S3C2410
       ARM: S3C24XX: Removed unneeded dependency on CPU_S3C2412

Amit Daniel Kachhap (2):
       ARM: dts: Add PMIC node entry for Arndale board
       ARM: dts: Add cpufreq controller node for Exynos5440 SoC

Andrzej Hajda (1):
       clk: exynos4: Add missing CMU_TOP and ISP clocks

Axel Lin (1):
       clocksource: mct: Add terminating entry for exynos_mct_ids table

Byungho An (1):
       ARM: dts: Add node for GMAC for exynos5440

Chanho Park (5):
       irqchip: exynos-combiner: Add set_irq_affinity function for 
combiner_irq
       irqchip: exynos-combiner: Correct combined IRQs for exynos4
       ARM: EXYNOS: Enable PMUs for exynos4
       ARM: EXYNOS: Add arm-pmu DT binding for exynos5250
       ARM: EXYNOS: Add arm-pmu DT binding for exynos421x

Charles Keepax (2):
       ARM: S3C64XX: Clear DMA flags on channel request
       ARM: S3C64XX: Slow down mic detection rate for wm5102

Daniel Lezcano (3):
       ARM: EXYNOS: factor out the idle states
       ARM: EXYNOS: handle properly the return values
       ARM: EXYNOS: replace cpumask by the corresponding macro

Dongjin Kim (3):
       ARM: dts: Add board dts file for ODROID-X
       ARM: dts: Fix the timing property of MSHC controller for 
exynos4412-odroidx
       ARM: dts: enable RTC device node for exynos4412-odroidx

Doug Anderson (3):
       clocksource: mct: Add missing semicolons in exynos_mct.c
       ARM: dts: add usb 2.0 clock references to exynos5250 device tree
       ARM: dts: Document usb clocks in samsung,exynos4210-ehci/ohci 
bindings

Giridhar Maruthy (4):
       ARM: dts: remove disabled status from watchdog node for 
exynos5440-ssdk5440
       ARM: dts: remove disabled status from RTC node for 
exynos5440-ssdk5440
       ARM: dts: change compatible value for exynos5440 i2c
       ARM: dts: Add virtual GIC DT bindings for exynos5440

Girish K S (2):
       ARM: dts: Add initial board support file for exynos5250-arndale
       ARM: EXYNOS: force MAC ip to 32bit DMA

Heiko Stueber (1):
       clk: samsung: fix pm init on non-dt platforms

Heiko Stuebner (15):
       ARM: S3C24XX: fix redundant checks in the irq mapping function
       ARM: S3C24XX: fix irq parent check
       ARM: S3C24XX: move s3c24xx_init_irq to s3c2410_init_irq
       ARM: S3C24XX: make s3c24xx_init_intc static
       ARM: S3C24XX: add handle_irq function
       clk: samsung: register clk_div_tables for divider clocks
       clk: samsung: always allocate the clk_table
       clk: samsung: add infrastructure to add separate aliases
       ARM: S3C24XX: move irq driver to drivers/irqchip
       irqchip: s3c24xx: fix comments on some camera interrupts
       irqchip: s3c24xx: fix irqlist of second s3c2416 controller
       irqchip: s3c24xx: add irq_set_type callback for basic interrupt types
       irqchip: s3c24xx: globally keep track of the created intc instances
       irqchip: s3c24xx: make interrupt handling independent of 
irq_domain structure
       irqchip: s3c24xx: add devicetree support

Inderpal Singh (2):
       ARM: EXYNOS: Add support for rtc wakeup
       ARM: SAMSUNG: check processor type before cache restoration in resume

Jingoo Han (3):
       ARM: EXYNOS: Add AUXDATA for DP controller
       ARM: dts: Add device tree node for DP controller for exynos5250
       ARM: EXYNOS: change the name of USB ohci header

Jonathan Kliegman (2):
       ARM: EXYNOS: Remove hardcode wakeup unmask for EINT_0
       ARM: EXYNOS: Clear ENABLE_WAKEUP_SW bit when entering suspend

Kukjin Kim (17):
       ARM: dts: cleanup exynos5440.dtsi
       ARM: dts: re-organized cpu node for exynos5440
       Merge branch 'next/timer-samsung' into next/clk-exynos
       Merge branch 'next/mct-exynos' into next/clk-exynos
       ARM: SAMSUNG: change GENERIC_GPIO to ARCH_REQUIRE_GPIOLIB
       Merge branch 'next/cleanup-samsung' into for-next-next
       Merge branch 'next/irq-s3c24xx' into for-next-next
       Merge branch 'next/mct-exynos' into for-next-next
       Merge commit 'v3.9-rc5' into next/clk-exynos
       Merge branch 'next/clk-exynos' into for-next-next
       ARM: dts: add device tree file for SD5v1 board
       Merge branch 'next/dt-exynos' into for-next-next
       Merge branch 'next/pinctrl-exynos' into for-next-next
       Merge branch 'next/pmu-exynos' into for-next-next
       Merge branch 'next/secure-exynos' into for-next-next
       Merge branch 'next/timer-samsung' into for-next-next
       Merge branch 'next/devel-samsung' into for-next-next

Leela Krishna Amudala (3):
       clk: exynos5250: register display block gate clocks to common 
clock framework
       ARM: dts: Add FIMD node to exynos5
       ARM: dts: Add display timing node to exynos5250-smdk5250.dts

Lukasz Majewski (1):
       clk: exynos4: Export clocks used by exynos cpufreq drivers

Padmavathi Venna (1):
       ARM: SAMSUNG: Remove unnecessary code for dma

Paul Bolle (11):
       ARM: S3C24XX: drop "select MACH_N35"
       ARM: S3C24XX: drop "select MACH_NEO1973"
       ARM: EXYNOS: drop "select HAVE_SCHED_CLOCK"
       ARM: EXYNOS: change HAVE_SAMSUNG_KEYPAD to KEYBOARD_SAMSUNG
       ARM: SAMSUNG: remove "config S3C_BOOT_WATCHDOG"
       ARM: SAMSUNG: Remove useless Samsung GPIO related CONFIG
       ARM: S3C24XX: remove unneeded "config SMDK2440_CPU2442"
       ARM: S3C64XX: remove obsolete Makefile line
       ARM: S5P64X0: Fix typo "CONFIG_S5P64X0_SETUP_SDHCI"
       ARM: SAMSUNG: Fix typo "CONFIG_SAMSUNG_DEV_RTC"
       ARM: EXYNOS: remove "config EXYNOS_DEV_DRM"

Prasanna Kumar (1):
       ARM: dts: Set up power domain for MFC and G-scaler for exynos5250

Sachin Kamat (23):
       ARM: dts: Add vmmc regulator node in exynos4412-origen.dts
       ARM: dts: Add sdhci node for exynos4412-origen
       ARM: dts: Update MFC DT binding documentation
       ARM: dts: Add MFC codec support for EXYNOS4 DT machines
       ARM: dts: Add MFC codec support to SMDKV310 DT
       ARM: dts: Add MFC codec support to Origen DT
       ARM: dts: Add MFC codec entry to exynos4412-origen DT
       ARM: dts: Add MFC codec entry to exynos4412-smdk4412 DT
       ARM: dts: Add MSHC node for exynos4412-origen DT
       ARM: dts: Add s5m8767 PMIC node to exynos4412-origen DT
       ARM: dts: Add sdhci node for exynos4412-smdk4412
       clk: samsung: Fix compilation error
       ARM: dts: Add G2D node to exynos4210.dtsi
       ARM: dts: Add G2D node to SMDKV310
       ARM: dts: Add G2D node to exynos4210-origen
       ARM: dts: Add G2D node to exynos4x12.dtsi
       ARM: dts: Add G2D node to SMDK4412
       ARM: dts: Add G2D node to exynos4412-origen
       ARM: dts: Add Samsung G2D DT bindings documentation
       ARM: dts: Add disable-wp for card slot on exynos5250-arndale
       ARM: dts: Add vmmc regulator support for Arndale board
       ARM: dts: Add MFC codec support for Arndale board
       ARM: dts: Add HDMI HPD and regulator node for Arndale board

Subash Patel (3):
       ARM: dts: add PMU support in exynos5440
       ARM: dts: update bootargs to boot from sda2 for exynos5440-ssdk5440
       ARM: dts: add PDMA0 changes for exynos5440

Sylwester Nawrocki (7):
       ARM: SAMSUNG: Export MIPI CSIS/DSIM PHY control functions
       clk: exynos4: Correct sclk_mfc clock definition
       clk: exynos4: Add camera related clock definitions
       ARM: S3C24XX: Remove unused GPIO drive strength register definitions
       clk: exynos4: export clocks required for fimc-is
       ARM: S3C24XX: Correct NR_IRQS definition for s3c2440
       ARM: dts: Add SYSREG block node for S5P/Exynos4 SoC series

Thomas Abraham (32):
       ARM: dts: add board dts file for EXYNOS4412 based Origen board
       ARM: EXYNOS: add a register base address variable in mct 
controller driver
       ARM: EXYNOS: prepare an array of MCT interrupt numbers and use it
       ARM: EXYNOS: add device tree support for MCT controller driver
       ARM: EXYNOS: allow dt based discovery of mct controller using 
clocksource_of_init
       ARM: dts: add mct device tree node for all supported Exynos SoC's
       ARM: EXYNOS: remove static io-remapping of mct registers for Exynos5
       ARM: EXYNOS: move mct driver to drivers/clocksource
       clk: samsung: add common clock framework helper functions for 
Samsung platforms
       clk: samsung: add pll clock registration helper functions
       clk: exynos4: register clocks using common clock framework
       clk: exynos5250: register clocks using common clock framework
       clk: exynos5440: register clocks using common clock framework
       ARM: EXYNOS: Migrate clock support to common clock framework
       ARM: EXYNOS: Initialize the clocks prior to timer initialization
       ARM: EXYNOS: allow legacy board support to specify xxti and 
xusbxti clock speed
       ARM: EXYNOS: remove auxdata table from exynos4/5 dt machine file
       clocksource: mct: use fin_pll clock as the tick clock source for mct
       clocksource: mct: add support for mct clock setup
       ARM: dts: add Exynos4 and Exynos5 clock controller nodes
       ARM: dts: add clock provider information for all controllers in 
Exynos4 SoCs
       ARM: dts: add clock provider information for all controllers in 
Exynos5250 SoC
       ARM: dts: add clock provider information for all controllers in 
Exynos5440 SoC
       ARM: dts: add board specific fixed rate clock nodes for Exynos 
based platforms
       ARM: EXYNOS: fix compilation error introduced due to common clock 
migration
       pinctrl: exynos5440: fix probe failure due to missing pin-list in 
config nodes
       pinctrl: exynos5440: add gpio interrupt support
       ARM: dts: add pin state information in client nodes for Exynos4 
platforms
       ARM: dts: add pin state information in client nodes for Exynos5 
platforms
       ARM: dts: list the interrupts generated by pin-controller on 
Exynos5440
       ARM: dts: Fix gmac clock ids due to changes in Exynos5440
       ARM: EXYNOS: Add a platform bus notifier to set dma masks for 
Exynos5440

Tomasz Figa (22):
       clk: exynos4: Use mout_mpll_user_* on Exynos4x12
       clk: exynos4: Add missing mout_mipihsi clock
       clk: exynos4: Add missing sclk_audio0 clock
       clk: exynos4: Export sclk_pcm0
       clk: exynos4: Move dac and mixer to Exynos4210-specific clocks
       clk: samsung: Remove unimplemented ops for pll
       clk: exynos4: Export mout_core clock of Exynos4210
       clk: exynos4: Add G3D clocks
       clk: exynos4: Add missing mout_sata on Exynos4210
       clk: exynos4: Define {E,V}PLL registers
       clk: exynos4: Use SRC_MASK_PERIL{0,1} definitions
       clk: exynos4: Remove SoC-specific registers from save list
       clk: exynos4: Add E4210 prefix to LCD1 clock registers
       clk: exynos4: Add E4210 prefix to GATE_IP_PERIR register
       clk: exynos4: Remove E4X12 prefix from SRC_DMC register
       clk: exynos4: Add missing registers to suspend save list
       clk: exynos4: Add support for SoC-specific register save list
       ARM: Add interface for registering and calling firmware-specific 
operations
       ARM: EXYNOS: Add support for secure monitor calls
       ARM: EXYNOS: Add support for Exynos secure firmware
       ARM: EXYNOS: Add IO mapping for non-secure SYSRAM.
       ARM: EXYNOS: Add secure firmware support to secondary CPU bring-up

Tushar Behera (3):
       clk: exynos5250: Fix divider values for sclk_mmc{0,1,2,3}
       ARM: dts: Add pin-control related changes for Arndale board
       ARM: dts: Add gpio-button entries for Arndale board

Vikas Sajjan (3):
       ARM: dts: Add FIMD node to exynos4
       ARM: dts: Add FIMD node and display timing node to 
exynos4412-origen.dts
       ARM: dts: Add FIMD DT binding Documentation

Viresh Kumar (1):
       cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq

Vivek Gautam (2):
       ARM: dts: Enabling ehci-s5p driver for EXYNOS5250
       ARM: dts: Enabling ohci-exynos driver for EXYNOS5250

Wei Yongjun (1):
       ARM: EXYNOS: remove duplicated include from common.c

  Documentation/arm/firmware.txt                     |   88 ++
  .../devicetree/bindings/arm/samsung-boards.txt     |   10 +
  .../devicetree/bindings/arm/samsung/sysreg.txt     |    7 +
  .../devicetree/bindings/clock/exynos4-clock.txt    |  288 ++++
  .../devicetree/bindings/clock/exynos5250-clock.txt |  177 +++
  .../devicetree/bindings/clock/exynos5440-clock.txt |   61 +
  .../devicetree/bindings/gpu/samsung-g2d.txt        |   20 +
  .../interrupt-controller/samsung,s3c24xx-irq.txt   |   53 +
  .../devicetree/bindings/media/s5p-mfc.txt          |   21 +
  .../bindings/timer/samsung,exynos4210-mct.txt      |   68 +
  .../devicetree/bindings/usb/exynos-usb.txt         |   50 +
  .../devicetree/bindings/video/samsung-fimd.txt     |   65 +
  arch/arm/Kconfig                                   |   56 +-
  arch/arm/boot/dts/Makefile                         |    4 +
  arch/arm/boot/dts/cros5250-common.dtsi             |  189 ++-
  arch/arm/boot/dts/exynos4.dtsi                     |   85 +
  arch/arm/boot/dts/exynos4210-origen.dts            |   22 +
  arch/arm/boot/dts/exynos4210-smdkv310.dts          |   75 +-
  arch/arm/boot/dts/exynos4210-trats.dts             |   12 +
  arch/arm/boot/dts/exynos4210.dtsi                  |   43 +
  arch/arm/boot/dts/exynos4212.dtsi                  |   22 +
  arch/arm/boot/dts/exynos4412-odroidx.dts           |  109 ++
  arch/arm/boot/dts/exynos4412-origen.dts            |  451 ++++++
  arch/arm/boot/dts/exynos4412-smdk4412.dts          |   33 +
  arch/arm/boot/dts/exynos4412.dtsi                  |   26 +
  arch/arm/boot/dts/exynos4x12.dtsi                  |   13 +
  arch/arm/boot/dts/exynos5250-arndale.dts           |  452 ++++++
  arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |  783 ++++++++++
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   69 +-
  arch/arm/boot/dts/exynos5250-snow.dts              |   33 +-
  arch/arm/boot/dts/exynos5250.dtsi                  |  489 +++---
  arch/arm/boot/dts/exynos5440-sd5v1.dts             |   39 +
  arch/arm/boot/dts/exynos5440-ssdk5440.dts          |   25 +-
  arch/arm/boot/dts/exynos5440.dtsi                  |  115 +-
  arch/arm/common/Makefile                           |    2 +
  arch/arm/common/firmware.c                         |   18 +
  arch/arm/include/asm/firmware.h                    |   66 +
  arch/arm/mach-exynos/Kconfig                       |   23 +-
  arch/arm/mach-exynos/Makefile                      |   12 +-
  arch/arm/mach-exynos/clock-exynos4.c               | 1601 
-------------------
  arch/arm/mach-exynos/clock-exynos4.h               |   35 -
  arch/arm/mach-exynos/clock-exynos4210.c            |  187 ---
  arch/arm/mach-exynos/clock-exynos4212.c            |  201 ---
  arch/arm/mach-exynos/clock-exynos5.c               | 1645 
--------------------
  arch/arm/mach-exynos/common.c                      |  123 +-
  arch/arm/mach-exynos/common.h                      |   12 +-
  arch/arm/mach-exynos/cpuidle.c                     |   58 +-
  arch/arm/mach-exynos/dev-ohci.c                    |    2 +-
  arch/arm/mach-exynos/exynos-smc.S                  |   22 +
  arch/arm/mach-exynos/firmware.c                    |   70 +
  arch/arm/mach-exynos/include/mach/irqs.h           |   19 +-
  arch/arm/mach-exynos/include/mach/map.h            |    4 +-
  arch/arm/mach-exynos/include/mach/pm-core.h        |    9 +-
  arch/arm/mach-exynos/include/mach/regs-clock.h     |  107 --
  arch/arm/mach-exynos/include/mach/regs-mct.h       |   53 -
  arch/arm/mach-exynos/mach-armlex4210.c             |    3 +-
  arch/arm/mach-exynos/mach-exynos4-dt.c             |  123 +--
  arch/arm/mach-exynos/mach-exynos5-dt.c             |  165 +--
  arch/arm/mach-exynos/mach-nuri.c                   |    5 +-
  arch/arm/mach-exynos/mach-origen.c                 |    7 +-
  arch/arm/mach-exynos/mach-smdk4x12.c               |    5 +-
  arch/arm/mach-exynos/mach-smdkv310.c               |    9 +-
  arch/arm/mach-exynos/mach-universal_c210.c         |    3 +-
  arch/arm/mach-exynos/platsmp.c                     |   32 +-
  arch/arm/mach-exynos/smc.h                         |   31 +
  arch/arm/mach-s3c24xx/Kconfig                      |   84 +-
  arch/arm/mach-s3c24xx/Makefile                     |    8 +-
  arch/arm/mach-s3c24xx/common.h                     |    1 +
  arch/arm/mach-s3c24xx/include/mach/dma.h           |    1 -
  arch/arm/mach-s3c24xx/include/mach/entry-macro.S   |   70 -
  arch/arm/mach-s3c24xx/include/mach/irqs.h          |    4 +-
  arch/arm/mach-s3c24xx/{ => include/mach}/s3c2412.h |    0
  arch/arm/mach-s3c24xx/iotiming-s3c2412.c           |    2 +-
  arch/arm/mach-s3c24xx/mach-amlm5900.c              |    2 +-
  arch/arm/mach-s3c24xx/mach-bast.c                  |    2 +-
  arch/arm/mach-s3c24xx/mach-h1940.c                 |    7 +-
  arch/arm/mach-s3c24xx/mach-n30.c                   |    4 +-
  arch/arm/mach-s3c24xx/mach-otom.c                  |    2 +-
  arch/arm/mach-s3c24xx/mach-qt2410.c                |    2 +-
  arch/arm/mach-s3c24xx/mach-smdk2410.c              |    2 +-
  arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    2 +-
  arch/arm/mach-s3c24xx/mach-vr1000.c                |    2 +-
  arch/arm/mach-s3c24xx/regs-dsc.h                   |  203 +---
  arch/arm/mach-s3c64xx/Makefile                     |    1 -
  arch/arm/mach-s3c64xx/dma.c                        |    1 +
  arch/arm/mach-s3c64xx/include/mach/dma.h           |    1 -
  arch/arm/mach-s3c64xx/mach-crag6410-module.c       |    1 +
  arch/arm/plat-samsung/Kconfig                      |   18 +-
  arch/arm/plat-samsung/devs.c                       |    2 +-
  arch/arm/plat-samsung/dma-ops.c                    |   10 +-
  arch/arm/plat-samsung/include/plat/cpu-freq-core.h |   10 +-
  arch/arm/plat-samsung/include/plat/cpu-freq.h      |    6 +-
  arch/arm/plat-samsung/include/plat/cpu.h           |    1 -
  arch/arm/plat-samsung/include/plat/dma-ops.h       |    1 -
  arch/arm/plat-samsung/include/plat/dma-pl330.h     |    1 -
  arch/arm/plat-samsung/include/plat/map-s5p.h       |    1 +
  arch/arm/plat-samsung/include/plat/rtc-core.h      |    2 +-
  arch/arm/plat-samsung/include/plat/sdhci.h         |    4 +-
  arch/arm/plat-samsung/s5p-sleep.S                  |    9 +
  arch/arm/plat-samsung/setup-mipiphy.c              |    3 +
  drivers/clk/Makefile                               |    1 +
  drivers/clk/samsung/Makefile                       |    8 +
  drivers/clk/samsung/clk-exynos4.c                  | 1091 +++++++++++++
  drivers/clk/samsung/clk-exynos5250.c               |  523 +++++++
  drivers/clk/samsung/clk-exynos5440.c               |  139 ++
  drivers/clk/samsung/clk-pll.c                      |  419 +++++
  drivers/clk/samsung/clk-pll.h                      |   41 +
  drivers/clk/samsung/clk.c                          |  320 ++++
  drivers/clk/samsung/clk.h                          |  289 ++++
  drivers/clocksource/Kconfig                        |    5 +
  drivers/clocksource/Makefile                       |    1 +
  .../mct.c => drivers/clocksource/exynos_mct.c      |  210 ++-
  drivers/cpufreq/Kconfig.arm                        |   58 +
  drivers/cpufreq/Makefile                           |    9 +-
  .../cpufreq/s3c2410-cpufreq.c                      |    0
  .../cpufreq/s3c2412-cpufreq.c                      |    3 +-
  .../cpufreq/s3c2440-cpufreq.c                      |    0
  .../cpufreq/s3c24xx-cpufreq-debugfs.c              |    0
  .../cpufreq.c => drivers/cpufreq/s3c24xx-cpufreq.c |    0
  drivers/irqchip/Makefile                           |    1 +
  drivers/irqchip/exynos-combiner.c                  |   80 +-
  .../irq.c => drivers/irqchip/irq-s3c24xx.c         |  523 +++++--
  drivers/pinctrl/pinctrl-exynos5440.c               |  151 ++-
  drivers/usb/host/ohci-exynos.c                     |    3 +-
  .../{usb-exynos.h => usb-ohci-exynos.h}            |    0
  125 files changed, 7801 insertions(+), 5249 deletions(-)
  create mode 100644 Documentation/arm/firmware.txt
  create mode 100644 
Documentation/devicetree/bindings/arm/samsung/sysreg.txt
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos4-clock.txt
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos5250-clock.txt
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos5440-clock.txt
  create mode 100644 Documentation/devicetree/bindings/gpu/samsung-g2d.txt
  create mode 100644 
Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
  create mode 100644 
Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
  create mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt
  create mode 100644 
Documentation/devicetree/bindings/video/samsung-fimd.txt
  create mode 100644 arch/arm/boot/dts/exynos4412-odroidx.dts
  create mode 100644 arch/arm/boot/dts/exynos4412-origen.dts
  create mode 100644 arch/arm/boot/dts/exynos5250-arndale.dts
  create mode 100644 arch/arm/boot/dts/exynos5250-pinctrl.dtsi
  create mode 100644 arch/arm/boot/dts/exynos5440-sd5v1.dts
  create mode 100644 arch/arm/common/firmware.c
  create mode 100644 arch/arm/include/asm/firmware.h
  delete mode 100644 arch/arm/mach-exynos/clock-exynos4.c
  delete mode 100644 arch/arm/mach-exynos/clock-exynos4.h
  delete mode 100644 arch/arm/mach-exynos/clock-exynos4210.c
  delete mode 100644 arch/arm/mach-exynos/clock-exynos4212.c
  delete mode 100644 arch/arm/mach-exynos/clock-exynos5.c
  create mode 100644 arch/arm/mach-exynos/exynos-smc.S
  create mode 100644 arch/arm/mach-exynos/firmware.c
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-mct.h
  create mode 100644 arch/arm/mach-exynos/smc.h
  delete mode 100644 arch/arm/mach-s3c24xx/include/mach/entry-macro.S
  rename arch/arm/mach-s3c24xx/{ => include/mach}/s3c2412.h (100%)
  create mode 100644 drivers/clk/samsung/Makefile
  create mode 100644 drivers/clk/samsung/clk-exynos4.c
  create mode 100644 drivers/clk/samsung/clk-exynos5250.c
  create mode 100644 drivers/clk/samsung/clk-exynos5440.c
  create mode 100644 drivers/clk/samsung/clk-pll.c
  create mode 100644 drivers/clk/samsung/clk-pll.h
  create mode 100644 drivers/clk/samsung/clk.c
  create mode 100644 drivers/clk/samsung/clk.h
  rename arch/arm/mach-exynos/mct.c => drivers/clocksource/exynos_mct.c 
(64%)
  rename arch/arm/mach-s3c24xx/cpufreq-s3c2410.c => 
drivers/cpufreq/s3c2410-cpufreq.c (100%)
  rename arch/arm/mach-s3c24xx/cpufreq-s3c2412.c => 
drivers/cpufreq/s3c2412-cpufreq.c (99%)
  rename arch/arm/mach-s3c24xx/cpufreq-s3c2440.c => 
drivers/cpufreq/s3c2440-cpufreq.c (100%)
  rename arch/arm/mach-s3c24xx/cpufreq-debugfs.c => 
drivers/cpufreq/s3c24xx-cpufreq-debugfs.c (100%)
  rename arch/arm/mach-s3c24xx/cpufreq.c => 
drivers/cpufreq/s3c24xx-cpufreq.c (100%)
  rename arch/arm/mach-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c (75%)
  rename include/linux/platform_data/{usb-exynos.h => usb-ohci-exynos.h} 
(100%)
