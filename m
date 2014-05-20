From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 May 2014 10:09:43 +0900
Subject: [GIT PULL 0/5] Samsung updates for 3.16
Message-ID: <014301cf73c8$2f3416b0$8d9c4410$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof and Kevin,

Here is Samsung updates for 3.16 and please pull.
If any problems please kindly let me know.

Note, new exynos SoC support and exynos-multiplatform will be sent to
arm-soc together for 3.16 soon ;-)

One more note, this pull-request is including clock stuff for new SoCs
(3250, 5260 and 5800).

Thanks,
Kukjin

---

Abhilash Kesavan (2):
      ARM: EXYNOS: Add generic cluster power control functions
      ARM: EXYNOS: Add MCPM call-back functions

Ajay Kumar (2):
      ARM: dts: Add pwmX_out pinctrl nodes to exynos5250
      ARM: dts: enable pwm backlight for exynos5250-snow

Alim Akhtar (1):
      clk: exynos5420: Add 5800 specific clocks

Andrew Bresticker (1):
      ARM: dts: add CCI node for exynos5420

Arun Kumar K (5):
      ARM: dts: Add pwmX_out pinctrl nodes to exynos5420
      ARM: dts: Add node labels to exynos5420
      ARM: dts: Add exynos5420 peach-pit board support
      clk: samsung: exynos5250: Add clocks for G3D
      clk: samsung: exynos5420: Add clock IDs needed by GPU

Chanwoo Choi (1):
      dt-bindings: add documentation for Exynos3250 clock controller

Doug Anderson (3):
      ARM: dts: add pinctrl for i2c-arbitrator of exynos5250-snow
      ARM: dts: add pinctrl for EC irq of exynos5250-snow
      ARM: dts: add tps65090 power regulator for exynos5250-snow

Heiko Stuebner (22):
      clk: samsung: add pll_6552 variant for s3c2416
      clk: samsung: add plls used by the s3c2443
      dt-bindings: add binding for clock-controller of s3c2443 and following
      clk: samsung: add clock-driver for s3c2416, s3c2443 and s3c2450
      ARM: S3C24XX: prevent conflicts between ccf and non-ccf s3c24xx-socs
      ARM: dts: add clock data for s3c2416
      ARM: S3C24XX: Convert s3c2416 and s3c2443 to common clock framework
      ARM: S3C24XX: only store clock registers when old clock code is active
      clk: samsung: add plls used by the early s3c24xx cpus
      dt-bindings: add documentation for s3c2412 clock controller
      clk: samsung: add clock controller driver for s3c2412
      ARM: S3C24XX: convert s3c2412 to common clock framework
      ARM: S3C24XX: cpufreq-utils: don't write raw values to MPLLCON when
using ccf
      clk: samsung: add clock driver for external clock outputs
      ARM: S3C24XX: enable usage of common dclk if common clock framework is
enabled
      dt-bindings: add documentation for s3c2410 clock controller
      clk: samsung: add clock controller driver for s3c2410, s3c2440 and
s3c2442
      ARM: S3C24XX: add platform code for conversion to the common clock
framework
      ARM: S3C24XX: convert s3c2440 and s3c2442 to common clock framework
      ARM: S3C24XX: convert s3c2410 to common clock framework
      ARM: S3C24XX: remove legacy clock code
      ARM: S3C24XX: remove SAMSUNG_CLOCK remnants after ccf conversion

Kukjin Kim (10):
      ARM: S3C24XX: fix merge conflict
      Merge branch 'for_3.16/exynos5260' of
git://git.kernel.org/.../tfiga/samsung-clk into v3.16-next/clk-samsung
      Merge branch 'for_3.16/clk_fixes_non_critical' of
git://git.kernel.org/.../tfiga/samsung-clk into v3.16-next/clk-samsung
      Merge branch 'for_3.16/clk_cleanup' of
git://git.kernel.org/.../tfiga/samsung-clk into v3.16-next/clk-samsung
      Merge branch 'for_3.16/exynos3250' of
git://git.kernel.org/.../tfiga/samsung-clk into v3.16-next/clk-samsung
      Merge tag 'tags/s3c24xx-clk' into for-next
      Merge tag 'tags/samsung-clk' into for-next
      Merge tag 'tags/samsung-drivers' into for-next
      Merge tag 'tags/samsung-dt' into for-next
      Merge tag 'tags/exynos-mcpm' into for-next

Leela Krishna Amudala (2):
      ARM: EXYNOS: Add generic cpu power control functions for exynos SoCs
      ARM: EXYNOS: use generic exynos cpu power control functions

Naveen Krishna Chatradhi (1):
      clk: samsung: exynos5250/5420: Add gate clock for SSS module

Pankaj Dubey (6):
      clk/samsung: add support for pll2550xx
      clk: samsung: fixed compiler warning [-Wpointer-to-int-cast]
      clk: samsung: add new Kconfig for Samsung common clock option
      ARM: select COMMON_CLK_SAMSUNG for ARCH_EXYNOS and ARCH_S3C64XX
      ARM: S3C24XX: move S3C24XX clock Kconfig options to Samsung clock
Kconfig file
      drivers: clk: use COMMON_CLK_SAMSUNG for Samsung clock support

Rahul Sharma (11):
      clk/samsung: add support for multiple clock providers
      clk/samsung: add support for pll2650xx
      clk/exynos5260: add macros and documentation for exynos5260
      clk/exynos5260: add clock file for exynos5260
      ARM: dts: enable hdmi for exynos5250 based snow board
      ARM: dts: change to correct compatible string for exynos5420 hdmi
      ARM: dts: enable hdmi for exynos5420-peach-pit board
      ARM: dts: enable fimd for exynos5250-snow board
      ARM: dts: enable dp-controller for exynos5250-snow board
      ARM: dts: enable fimd for exynos5420 based peach-pit board
      ARM: dts: enable dp-controller for exynos5420-peach-pit board

Sachin Kamat (5):
      clk: samsung: exynos5420: Fix VPLL lock offset
      ARM: EXYNOS: Map SYSRAM through generic DT bindings
      devicetree: bindings: document SYSRAM binding
      ARM: dts: Add PD entry to MFC codec on exynos5420
      ARM: dts: Add MFC memory banks to exynos5420 boards

Shaik Ameer Basha (15):
      clk: samsung: exynos5420: Rename mux parent arrays
      clk: samsung: exynos5420: add clocks for ISP block
      clk: samsung: exynos5420: update clocks for GSCL and MSCL blocks
      clk: samsung: exynos5420: fix parent clocks for mscl sysmmu
      clk: samsung: exynos5420: update clocks for G2D and G3D blocks
      clk: samsung: exynos5420: update clocks for DISP1 block
      clk: samsung: exynos5420: update clocks for PERIC block
      clk: samsung: exynos5420: update clocks for PERIS and GEN blocks
      clk: samsung: exynos5420: update clocks for WCORE block
      clk: samsung: exynos5420: update clocks for FSYS and FSYS2 blocks
      clk: samsung: exynos5420: correct sysmmu-mfc parent clocks
      clk: samsung: exynos5420: fix register offset for sclk_bpll
      clk: samsung: exynos5420: update clocks for MAU Block
      clk: samsung: exynos5420: add misc clocks
      clk: samsung: exynos5420: add more registers to restore list

Sylwester Nawrocki (3):
      ARM: dts: Update camera nodes for exynos4 and exynos4412-trats2
      ARM: dts: Add rear camera nodes for exynos4412-trats2
      clk: samsung: exynos4: Use single clock ID for CLK_MDMA gate clocks

Tomasz Figa (3):
      clk: samsung: Initialize clock table with error pointers
      ARM: S3C24XX: Remove omitted Kconfig selects and conditionals
      clk: samsung: exynos3250: Add clocks using common clock framework

Tomasz Stanislawski (3):
      ARM: dts: add missing pinctrls for I2C of exynos4
      ARM: dts: rename alias for i2c_ak8975 label for exynos4412-trats2
      clk: samsung: exynos4: export sclk_hdmiphy clock

Tushar Behera (2):
      ARM: dts: Add sound node for exynos5250-snow board
      ARM: dts: Add sound node for exynos5420-peach-pit board

Vincent Guittot (1):
      clocksource: exynos_mct: register sched_clock callback

Vivek Gautam (7):
      ARM: dts: Enable support for USB 3.0 PHY controller for exynos5420
      ARM: dts: Enable support for DWC3 controller for exynos5420
      ARM: dts: Enable support for generic USB DRD phy for exynos5250
      ARM: dts: Update DWC3 usb controller to use new phy driver for
exynos5250
      ARM: dts: Add Vbus regulator for USB 3.0 on exynos5250-snow
      ARM: dts: Add Vbus regulator for USB 3.0 on exynos5420-peach-pit
      ARM: dts: Add Vbus regulator for USB 3.0 on exynos5420-smdk5420


.../devicetree/bindings/arm/exynos/smp-sysram.txt  |   38 +
 .../devicetree/bindings/clock/exynos3250-clock.txt |   41 +
 .../devicetree/bindings/clock/exynos5260-clock.txt |  190 ++
 .../devicetree/bindings/clock/exynos5420-clock.txt |    3 +-
 .../bindings/clock/samsung,s3c2410-clock.txt       |   50 +
 .../bindings/clock/samsung,s3c2412-clock.txt       |   50 +
 .../bindings/clock/samsung,s3c2443-clock.txt       |   56 +
 arch/arm/Kconfig                                   |    5 +-
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos4.dtsi                     |   18 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   15 +
 arch/arm/boot/dts/exynos4210.dtsi                  |   18 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |   79 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |   18 +
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |    6 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |   28 +
 arch/arm/boot/dts/exynos5250-snow.dts              |  224 +++
 arch/arm/boot/dts/exynos5250.dtsi                  |   38 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    5 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  287 +++
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   28 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   51 +
 arch/arm/boot/dts/exynos5420.dtsi                  |  147 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |   13 +
 arch/arm/boot/dts/s3c2416.dtsi                     |   42 +
 arch/arm/mach-exynos/Kconfig                       |    8 +
 arch/arm/mach-exynos/Makefile                      |    2 +
 arch/arm/mach-exynos/common.h                      |    7 +
 arch/arm/mach-exynos/exynos.c                      |   64 -
 arch/arm/mach-exynos/firmware.c                    |    8 +-
 arch/arm/mach-exynos/hotplug.c                     |    2 +-
 arch/arm/mach-exynos/include/mach/map.h            |    7 -
 arch/arm/mach-exynos/mcpm-exynos.c                 |  351 ++++
 arch/arm/mach-exynos/platsmp.c                     |   65 +-
 arch/arm/mach-exynos/pm.c                          |   66 +
 arch/arm/mach-exynos/regs-pmu.h                    |   16 +-
 arch/arm/mach-s3c24xx/Kconfig                      |   42 +-
 arch/arm/mach-s3c24xx/Makefile                     |   13 +-
 arch/arm/mach-s3c24xx/clock-dclk.c                 |  195 --
 arch/arm/mach-s3c24xx/clock-s3c2410.c              |  284 ---
 arch/arm/mach-s3c24xx/clock-s3c2412.c              |  760 --------
 arch/arm/mach-s3c24xx/clock-s3c2416.c              |  171 --
 arch/arm/mach-s3c24xx/clock-s3c2440.c              |  217 ---
 arch/arm/mach-s3c24xx/clock-s3c2443.c              |  212 ---
 arch/arm/mach-s3c24xx/clock-s3c244x.c              |  141 --
 arch/arm/mach-s3c24xx/common-s3c2443.c             |  675 -------
 arch/arm/mach-s3c24xx/common.c                     |   85 +-
 arch/arm/mach-s3c24xx/common.h                     |   21 +-
 arch/arm/mach-s3c24xx/cpufreq-utils.c              |    4 +-
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h    |   18 -
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h     |    3 -
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-anubis.c                |   34 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |   10 +-
 arch/arm/mach-s3c24xx/mach-bast.c                  |   34 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |    8 +-
 arch/arm/mach-s3c24xx/mach-h1940.c                 |   10 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |    9 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |   10 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   |   12 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |   10 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |   34 +-
 arch/arm/mach-s3c24xx/mach-otom.c                  |   10 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c                |    9 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   21 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |   10 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |   38 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c              |   10 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    9 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c                |   34 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |    9 +-
 arch/arm/mach-s3c24xx/pm.c                         |   17 -
 arch/arm/mach-s3c24xx/s3c2410.c                    |   56 -
 arch/arm/mach-s3c24xx/s3c2412.c                    |   43 -
 arch/arm/mach-s3c24xx/s3c2442.c                    |  111 --
 arch/arm/mach-s3c24xx/s3c244x.c                    |   59 +-
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h |    1 +
 drivers/clk/Kconfig                                |    2 +
 drivers/clk/Makefile                               |    2 +-
 drivers/clk/samsung/Kconfig                        |   26 +
 drivers/clk/samsung/Makefile                       |    6 +
 drivers/clk/samsung/clk-exynos3250.c               |  780 ++++++++
 drivers/clk/samsung/clk-exynos4.c                  |   51 +-
 drivers/clk/samsung/clk-exynos5250.c               |   41 +-
 drivers/clk/samsung/clk-exynos5260.c               | 1980
++++++++++++++++++++
 drivers/clk/samsung/clk-exynos5260.h               |  459 +++++
 drivers/clk/samsung/clk-exynos5420.c               | 1127 +++++++----
 drivers/clk/samsung/clk-exynos5440.c               |   18 +-
 drivers/clk/samsung/clk-pll.c                      |  489 ++++-
 drivers/clk/samsung/clk-pll.h                      |    8 +
 drivers/clk/samsung/clk-s3c2410-dclk.c             |  440 +++++
 drivers/clk/samsung/clk-s3c2410.c                  |  482 +++++
 drivers/clk/samsung/clk-s3c2412.c                  |  274 +++
 drivers/clk/samsung/clk-s3c2443.c                  |  466 +++++
 drivers/clk/samsung/clk-s3c64xx.c                  |   44 +-
 drivers/clk/samsung/clk.c                          |  123 +-
 drivers/clk/samsung/clk.h                          |   72 +-
 drivers/clocksource/exynos_mct.c                   |    8 +
 drivers/cpufreq/s3c24xx-cpufreq.c                  |    1 +
 include/dt-bindings/clock/exynos3250.h             |  258 +++
 include/dt-bindings/clock/exynos4.h                |    2 +-
 include/dt-bindings/clock/exynos5250.h             |    5 +-
 include/dt-bindings/clock/exynos5260-clk.h         |  469 +++++
 include/dt-bindings/clock/exynos5420.h             |   43 +-
 include/dt-bindings/clock/s3c2410.h                |   62 +
 include/dt-bindings/clock/s3c2412.h                |   73 +
 include/dt-bindings/clock/s3c2443.h                |   92 +
 111 files changed, 9582 insertions(+), 3862 deletions(-)
