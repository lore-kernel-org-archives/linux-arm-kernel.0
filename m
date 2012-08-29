From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:50:00 -0500
Subject: [PATCH 6/6] ARM: update defconfigs
In-Reply-To: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346280600-29395-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Converted with this script:

sed -i -e 's/\(CONFIG_ARCH_.*\)=/\1_CHOICE=/' -- arch/arm/configs/*

and then fixup all the duplicates.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/configs/acs5k_defconfig           |    2 +-
 arch/arm/configs/acs5k_tiny_defconfig      |    2 +-
 arch/arm/configs/afeb9260_defconfig        |    2 +-
 arch/arm/configs/ag5evm_defconfig          |    2 +-
 arch/arm/configs/am200epdkit_defconfig     |    2 +-
 arch/arm/configs/ap4evb_defconfig          |    2 +-
 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 arch/arm/configs/assabet_defconfig         |    2 +-
 arch/arm/configs/at91_dt_defconfig         |    2 +-
 arch/arm/configs/at91rm9200_defconfig      |    2 +-
 arch/arm/configs/at91sam9260_defconfig     |    2 +-
 arch/arm/configs/at91sam9261_defconfig     |    2 +-
 arch/arm/configs/at91sam9263_defconfig     |    2 +-
 arch/arm/configs/at91sam9g20_defconfig     |    2 +-
 arch/arm/configs/at91sam9g45_defconfig     |    2 +-
 arch/arm/configs/at91sam9rl_defconfig      |    2 +-
 arch/arm/configs/at91x40_defconfig         |    2 +-
 arch/arm/configs/badge4_defconfig          |    2 +-
 arch/arm/configs/bcmring_defconfig         |    2 +-
 arch/arm/configs/bonito_defconfig          |    2 +-
 arch/arm/configs/cam60_defconfig           |    2 +-
 arch/arm/configs/cerfcube_defconfig        |    2 +-
 arch/arm/configs/cm_x2xx_defconfig         |    2 +-
 arch/arm/configs/cm_x300_defconfig         |    2 +-
 arch/arm/configs/cns3420vb_defconfig       |    2 +-
 arch/arm/configs/colibri_pxa270_defconfig  |    2 +-
 arch/arm/configs/colibri_pxa300_defconfig  |    2 +-
 arch/arm/configs/collie_defconfig          |    2 +-
 arch/arm/configs/corgi_defconfig           |    2 +-
 arch/arm/configs/cpu9260_defconfig         |    2 +-
 arch/arm/configs/cpu9g20_defconfig         |    2 +-
 arch/arm/configs/da8xx_omapl_defconfig     |    2 +-
 arch/arm/configs/davinci_all_defconfig     |    2 +-
 arch/arm/configs/dove_defconfig            |    2 +-
 arch/arm/configs/ebsa110_defconfig         |    2 +-
 arch/arm/configs/edb7211_defconfig         |    2 +-
 arch/arm/configs/em_x270_defconfig         |    2 +-
 arch/arm/configs/ep93xx_defconfig          |    2 +-
 arch/arm/configs/eseries_pxa_defconfig     |    2 +-
 arch/arm/configs/exynos4_defconfig         |    2 +-
 arch/arm/configs/exynos_defconfig          |    4 ++--
 arch/arm/configs/ezx_defconfig             |    2 +-
 arch/arm/configs/footbridge_defconfig      |    2 +-
 arch/arm/configs/fortunet_defconfig        |    2 +-
 arch/arm/configs/g3evm_defconfig           |    2 +-
 arch/arm/configs/g4evm_defconfig           |    2 +-
 arch/arm/configs/h3600_defconfig           |    2 +-
 arch/arm/configs/h5000_defconfig           |    2 +-
 arch/arm/configs/h7201_defconfig           |    2 +-
 arch/arm/configs/h7202_defconfig           |    2 +-
 arch/arm/configs/hackkit_defconfig         |    2 +-
 arch/arm/configs/imote2_defconfig          |    2 +-
 arch/arm/configs/imx_v4_v5_defconfig       |    2 +-
 arch/arm/configs/imx_v6_v7_defconfig       |    2 +-
 arch/arm/configs/integrator_defconfig      |    2 +-
 arch/arm/configs/iop13xx_defconfig         |    2 +-
 arch/arm/configs/iop32x_defconfig          |    2 +-
 arch/arm/configs/iop33x_defconfig          |    2 +-
 arch/arm/configs/ixp4xx_defconfig          |    2 +-
 arch/arm/configs/jornada720_defconfig      |    2 +-
 arch/arm/configs/kirkwood_defconfig        |    2 +-
 arch/arm/configs/kota2_defconfig           |    2 +-
 arch/arm/configs/ks8695_defconfig          |    2 +-
 arch/arm/configs/kzm9d_defconfig           |    2 +-
 arch/arm/configs/kzm9g_defconfig           |    2 +-
 arch/arm/configs/lart_defconfig            |    2 +-
 arch/arm/configs/lpc32xx_defconfig         |    2 +-
 arch/arm/configs/lpd270_defconfig          |    2 +-
 arch/arm/configs/lubbock_defconfig         |    2 +-
 arch/arm/configs/mackerel_defconfig        |    2 +-
 arch/arm/configs/magician_defconfig        |    2 +-
 arch/arm/configs/mainstone_defconfig       |    2 +-
 arch/arm/configs/marzen_defconfig          |    2 +-
 arch/arm/configs/mini2440_defconfig        |    2 +-
 arch/arm/configs/mmp2_defconfig            |    2 +-
 arch/arm/configs/msm_defconfig             |    2 +-
 arch/arm/configs/mv78xx0_defconfig         |    2 +-
 arch/arm/configs/mvebu_defconfig           |    2 +-
 arch/arm/configs/mxs_defconfig             |    2 +-
 arch/arm/configs/neponset_defconfig        |    2 +-
 arch/arm/configs/netwinder_defconfig       |    2 +-
 arch/arm/configs/netx_defconfig            |    2 +-
 arch/arm/configs/nhk8815_defconfig         |    2 +-
 arch/arm/configs/nuc910_defconfig          |    2 +-
 arch/arm/configs/nuc950_defconfig          |    2 +-
 arch/arm/configs/nuc960_defconfig          |    2 +-
 arch/arm/configs/omap1_defconfig           |    2 +-
 arch/arm/configs/omap2plus_defconfig       |    2 +-
 arch/arm/configs/orion5x_defconfig         |    2 +-
 arch/arm/configs/palmz72_defconfig         |    2 +-
 arch/arm/configs/pcm027_defconfig          |    2 +-
 arch/arm/configs/pleb_defconfig            |    2 +-
 arch/arm/configs/pnx4008_defconfig         |    2 +-
 arch/arm/configs/prima2_defconfig          |    2 +-
 arch/arm/configs/pxa168_defconfig          |    2 +-
 arch/arm/configs/pxa255-idp_defconfig      |    2 +-
 arch/arm/configs/pxa3xx_defconfig          |    2 +-
 arch/arm/configs/pxa910_defconfig          |    2 +-
 arch/arm/configs/qil-a9260_defconfig       |    2 +-
 arch/arm/configs/raumfeld_defconfig        |    2 +-
 arch/arm/configs/realview-smp_defconfig    |    2 +-
 arch/arm/configs/realview_defconfig        |    2 +-
 arch/arm/configs/rpc_defconfig             |    2 +-
 arch/arm/configs/s3c2410_defconfig         |    2 +-
 arch/arm/configs/s3c6400_defconfig         |    2 +-
 arch/arm/configs/s5p64x0_defconfig         |    2 +-
 arch/arm/configs/s5pc100_defconfig         |    2 +-
 arch/arm/configs/s5pv210_defconfig         |    2 +-
 arch/arm/configs/sam9_l9260_defconfig      |    2 +-
 arch/arm/configs/shannon_defconfig         |    2 +-
 arch/arm/configs/shark_defconfig           |    2 +-
 arch/arm/configs/simpad_defconfig          |    2 +-
 arch/arm/configs/socfpga_defconfig         |    2 +-
 arch/arm/configs/spear13xx_defconfig       |    2 +-
 arch/arm/configs/spear6xx_defconfig        |    2 +-
 arch/arm/configs/spitz_defconfig           |    2 +-
 arch/arm/configs/stamp9g20_defconfig       |    2 +-
 arch/arm/configs/tct_hammer_defconfig      |    2 +-
 arch/arm/configs/tegra_defconfig           |    2 +-
 arch/arm/configs/trizeps4_defconfig        |    2 +-
 arch/arm/configs/u300_defconfig            |    2 +-
 arch/arm/configs/u8500_defconfig           |    2 +-
 arch/arm/configs/usb-a9260_defconfig       |    2 +-
 arch/arm/configs/vexpress_defconfig        |    2 +-
 arch/arm/configs/viper_defconfig           |    2 +-
 arch/arm/configs/xcep_defconfig            |    2 +-
 arch/arm/configs/zeus_defconfig            |    2 +-
 127 files changed, 128 insertions(+), 128 deletions(-)

diff --git a/arch/arm/configs/acs5k_defconfig b/arch/arm/configs/acs5k_defconfig
index 92b0f90..7543bef 100644
--- a/arch/arm/configs/acs5k_defconfig
+++ b/arch/arm/configs/acs5k_defconfig
@@ -11,7 +11,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_KS8695=y
+CONFIG_ARCH_KS8695_CHOICE=y
 CONFIG_MACH_KS8695=y
 CONFIG_MACH_DSM320=y
 CONFIG_MACH_ACS5K=y
diff --git a/arch/arm/configs/acs5k_tiny_defconfig b/arch/arm/configs/acs5k_tiny_defconfig
index 2a27a14..89de2f2 100644
--- a/arch/arm/configs/acs5k_tiny_defconfig
+++ b/arch/arm/configs/acs5k_tiny_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_KS8695=y
+CONFIG_ARCH_KS8695_CHOICE=y
 CONFIG_MACH_ACS5K=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/afeb9260_defconfig b/arch/arm/configs/afeb9260_defconfig
index 2afdf67..0f0389c 100644
--- a/arch/arm/configs/afeb9260_defconfig
+++ b/arch/arm/configs/afeb9260_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9260=y
 CONFIG_MACH_AFEB9260=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
diff --git a/arch/arm/configs/ag5evm_defconfig b/arch/arm/configs/ag5evm_defconfig
index 212ead3..afe2f08 100644
--- a/arch/arm/configs/ag5evm_defconfig
+++ b/arch/arm/configs/ag5evm_defconfig
@@ -15,7 +15,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_AG5EVM=y
 CONFIG_MEMORY_SIZE=0x10000000
diff --git a/arch/arm/configs/am200epdkit_defconfig b/arch/arm/configs/am200epdkit_defconfig
index f0dea52..7069340 100644
--- a/arch/arm/configs/am200epdkit_defconfig
+++ b/arch/arm/configs/am200epdkit_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_ARCH_GUMSTIX=y
 CONFIG_PCCARD=y
 CONFIG_PREEMPT=y
diff --git a/arch/arm/configs/ap4evb_defconfig b/arch/arm/configs/ap4evb_defconfig
index 2eef85e..8b82ed3 100644
--- a/arch/arm/configs/ap4evb_defconfig
+++ b/arch/arm/configs/ap4evb_defconfig
@@ -8,7 +8,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_ARCH_SH7372=y
 CONFIG_MACH_AP4EVB=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 7d87184..46072fd 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_MACH_ARMADILLO800EVA=y
 # CONFIG_SH_TIMER_TMU is not set
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index 558ecd8..b2deaf9 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_ASSABET=y
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 67bc571..fb42cd3 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_SOC_AT91SAM9260=y
 CONFIG_SOC_AT91SAM9263=y
 CONFIG_SOC_AT91SAM9G45=y
diff --git a/arch/arm/configs/at91rm9200_defconfig b/arch/arm/configs/at91rm9200_defconfig
index d54e2ac..cfde6c2 100644
--- a/arch/arm/configs/at91rm9200_defconfig
+++ b/arch/arm/configs/at91rm9200_defconfig
@@ -13,7 +13,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91RM9200=y
 CONFIG_MACH_ONEARM=y
 CONFIG_ARCH_AT91RM9200DK=y
diff --git a/arch/arm/configs/at91sam9260_defconfig b/arch/arm/configs/at91sam9260_defconfig
index 505b376..8206d1c 100644
--- a/arch/arm/configs/at91sam9260_defconfig
+++ b/arch/arm/configs/at91sam9260_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9260=y
 CONFIG_ARCH_AT91SAM9260_SAM9XE=y
 CONFIG_MACH_AT91SAM9260EK=y
diff --git a/arch/arm/configs/at91sam9261_defconfig b/arch/arm/configs/at91sam9261_defconfig
index ade6b2f..2e2e559 100644
--- a/arch/arm/configs/at91sam9261_defconfig
+++ b/arch/arm/configs/at91sam9261_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9261=y
 CONFIG_MACH_AT91SAM9261EK=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
diff --git a/arch/arm/configs/at91sam9263_defconfig b/arch/arm/configs/at91sam9263_defconfig
index 1cf9626..287de20 100644
--- a/arch/arm/configs/at91sam9263_defconfig
+++ b/arch/arm/configs/at91sam9263_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9263=y
 CONFIG_MACH_AT91SAM9263EK=y
 CONFIG_MACH_USB_A9263=y
diff --git a/arch/arm/configs/at91sam9g20_defconfig b/arch/arm/configs/at91sam9g20_defconfig
index 994d331..fbe6f40 100644
--- a/arch/arm/configs/at91sam9g20_defconfig
+++ b/arch/arm/configs/at91sam9g20_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9G20=y
 CONFIG_MACH_AT91SAM9G20EK=y
 CONFIG_MACH_AT91SAM9G20EK_2MMC=y
diff --git a/arch/arm/configs/at91sam9g45_defconfig b/arch/arm/configs/at91sam9g45_defconfig
index 606d48f..85f2743 100644
--- a/arch/arm/configs/at91sam9g45_defconfig
+++ b/arch/arm/configs/at91sam9g45_defconfig
@@ -15,7 +15,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9G45=y
 CONFIG_MACH_AT91SAM9M10G45EK=y
 CONFIG_MACH_AT91SAM_DT=y
diff --git a/arch/arm/configs/at91sam9rl_defconfig b/arch/arm/configs/at91sam9rl_defconfig
index ad562ee..0f8f9b3 100644
--- a/arch/arm/configs/at91sam9rl_defconfig
+++ b/arch/arm/configs/at91sam9rl_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9RL=y
 CONFIG_MACH_AT91SAM9RLEK=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
diff --git a/arch/arm/configs/at91x40_defconfig b/arch/arm/configs/at91x40_defconfig
index c55e921..42acdab 100644
--- a/arch/arm/configs/at91x40_defconfig
+++ b/arch/arm/configs/at91x40_defconfig
@@ -13,7 +13,7 @@ CONFIG_SLAB=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91X40=y
 CONFIG_MACH_AT91EB01=y
 CONFIG_AT91_EARLY_USART0=y
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index 5b54abb..e657c9e 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -3,7 +3,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_BADGE4=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/configs/bcmring_defconfig b/arch/arm/configs/bcmring_defconfig
index 9e6a8fe..7fabe55 100644
--- a/arch/arm/configs/bcmring_defconfig
+++ b/arch/arm/configs/bcmring_defconfig
@@ -20,7 +20,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_BCMRING=y
+CONFIG_ARCH_BCMRING_CHOICE=y
 CONFIG_BCM_ZRELADDR=0x8000
 CONFIG_CPU_32v6K=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/bonito_defconfig b/arch/arm/configs/bonito_defconfig
index 5457108..c1bf7ba 100644
--- a/arch/arm/configs/bonito_defconfig
+++ b/arch/arm/configs/bonito_defconfig
@@ -17,7 +17,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_MACH_BONITO=y
 # CONFIG_SH_TIMER_TMU is not set
diff --git a/arch/arm/configs/cam60_defconfig b/arch/arm/configs/cam60_defconfig
index cedc92e..f692e00 100644
--- a/arch/arm/configs/cam60_defconfig
+++ b/arch/arm/configs/cam60_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9260=y
 CONFIG_MACH_CAM60=y
 CONFIG_ZBOOT_ROM_BSS=0x20004000
diff --git a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
index dce912d..f728b36 100644
--- a/arch/arm/configs/cerfcube_defconfig
+++ b/arch/arm/configs/cerfcube_defconfig
@@ -5,7 +5,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_CERF=y
 CONFIG_SA1100_CERF_FLASH_16MB=y
 CONFIG_PCCARD=m
diff --git a/arch/arm/configs/cm_x2xx_defconfig b/arch/arm/configs/cm_x2xx_defconfig
index a93ff8d..069fe65 100644
--- a/arch/arm/configs/cm_x2xx_defconfig
+++ b/arch/arm/configs/cm_x2xx_defconfig
@@ -13,7 +13,7 @@ CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_ARMCORE=y
 CONFIG_PCI=y
 CONFIG_PCCARD=m
diff --git a/arch/arm/configs/cm_x300_defconfig b/arch/arm/configs/cm_x300_defconfig
index f4b7672..65be1f6 100644
--- a/arch/arm/configs/cm_x300_defconfig
+++ b/arch/arm/configs/cm_x300_defconfig
@@ -11,7 +11,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_MACH_CM_X300=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/cns3420vb_defconfig b/arch/arm/configs/cns3420vb_defconfig
index 313627a..eeefbdd 100644
--- a/arch/arm/configs/cns3420vb_defconfig
+++ b/arch/arm/configs/cns3420vb_defconfig
@@ -19,7 +19,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_IOSCHED_CFQ=m
-CONFIG_ARCH_CNS3XXX=y
+CONFIG_ARCH_CNS3XXX_CHOICE=y
 CONFIG_MACH_CNS3420VB=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 2ef2c5e..7e543e1 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -17,7 +17,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_COLIBRI=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/colibri_pxa300_defconfig b/arch/arm/configs/colibri_pxa300_defconfig
index b985334..44b61a595 100644
--- a/arch/arm/configs/colibri_pxa300_defconfig
+++ b/arch/arm/configs/colibri_pxa300_defconfig
@@ -2,7 +2,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_COLIBRI300=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="console=ttyS0,115200 rw"
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 6c56ad0..2efaad1 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -10,7 +10,7 @@ CONFIG_EXPERT=y
 CONFIG_SLOB=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_COLLIE=y
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index e53c475..9a925e8 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -11,7 +11,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_POODLE=y
 CONFIG_MACH_CORGI=y
diff --git a/arch/arm/configs/cpu9260_defconfig b/arch/arm/configs/cpu9260_defconfig
index bbf729e..93b387d 100644
--- a/arch/arm/configs/cpu9260_defconfig
+++ b/arch/arm/configs/cpu9260_defconfig
@@ -8,7 +8,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9260=y
 CONFIG_MACH_CPU9260=y
 # CONFIG_ARM_THUMB is not set
diff --git a/arch/arm/configs/cpu9g20_defconfig b/arch/arm/configs/cpu9g20_defconfig
index e7d7942..544b25d 100644
--- a/arch/arm/configs/cpu9g20_defconfig
+++ b/arch/arm/configs/cpu9g20_defconfig
@@ -8,7 +8,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9G20=y
 CONFIG_MACH_CPU9G20=y
 # CONFIG_ARM_THUMB is not set
diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index 88ccde0..f546dba 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_DAVINCI=y
+CONFIG_ARCH_DAVINCI_CHOICE=y
 CONFIG_ARCH_DAVINCI_DA830=y
 CONFIG_ARCH_DAVINCI_DA850=y
 CONFIG_MACH_MITYOMAPL138=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 67b5abb6..aeed63e 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_DAVINCI=y
+CONFIG_ARCH_DAVINCI_CHOICE=y
 CONFIG_ARCH_DAVINCI_DM644x=y
 CONFIG_ARCH_DAVINCI_DM355=y
 CONFIG_ARCH_DAVINCI_DM646x=y
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 40db34c..24988f7 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -6,7 +6,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_DOVE=y
+CONFIG_ARCH_DOVE_CHOICE=y
 CONFIG_MACH_DOVE_DB=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/configs/ebsa110_defconfig b/arch/arm/configs/ebsa110_defconfig
index 14559db..016261c 100644
--- a/arch/arm/configs/ebsa110_defconfig
+++ b/arch/arm/configs/ebsa110_defconfig
@@ -4,7 +4,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
-CONFIG_ARCH_EBSA110=y
+CONFIG_ARCH_EBSA110_CHOICE=y
 CONFIG_PCCARD=m
 CONFIG_I82365=m
 CONFIG_LEDS=y
diff --git a/arch/arm/configs/edb7211_defconfig b/arch/arm/configs/edb7211_defconfig
index d52ded35..5dc3398 100644
--- a/arch/arm/configs/edb7211_defconfig
+++ b/arch/arm/configs/edb7211_defconfig
@@ -4,7 +4,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_HOTPLUG is not set
-CONFIG_ARCH_CLPS711X=y
+CONFIG_ARCH_CLPS711X_CHOICE=y
 CONFIG_ARCH_EDB7211=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/configs/em_x270_defconfig b/arch/arm/configs/em_x270_defconfig
index 60a21e0..1ae64d2 100644
--- a/arch/arm/configs/em_x270_defconfig
+++ b/arch/arm/configs/em_x270_defconfig
@@ -13,7 +13,7 @@ CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_EM_X270=y
 CONFIG_MACH_EXEDA=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 8e97b2f..2e74fae 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -11,7 +11,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_EP93XX=y
+CONFIG_ARCH_EP93XX_CHOICE=y
 CONFIG_CRUNCH=y
 CONFIG_MACH_ADSSPHERE=y
 CONFIG_MACH_EDB9301=y
diff --git a/arch/arm/configs/eseries_pxa_defconfig b/arch/arm/configs/eseries_pxa_defconfig
index d68ac67..ded7fd6 100644
--- a/arch/arm/configs/eseries_pxa_defconfig
+++ b/arch/arm/configs/eseries_pxa_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_ARCH_PXA_ESERIES=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_IWMMXT=y
diff --git a/arch/arm/configs/exynos4_defconfig b/arch/arm/configs/exynos4_defconfig
index bffe68e..dd1d584 100644
--- a/arch/arm/configs/exynos4_defconfig
+++ b/arch/arm/configs/exynos4_defconfig
@@ -4,7 +4,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_EXYNOS_CHOICE=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_MACH_SMDKC210=y
 CONFIG_MACH_ARMLEX4210=y
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index e40b435..cd76c19 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -8,10 +8,10 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_EFI_PARTITION=y
-CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_EXYNOS_CHOICE=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_S3C24XX_PWM=y
-CONFIG_ARCH_EXYNOS5=y
+CONFIG_ARCH_EXYNOS5_CHOICE=y
 CONFIG_MACH_EXYNOS4_DT=y
 CONFIG_MACH_EXYNOS5_DT=y
 CONFIG_SMP=y
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index d95763d..c33b4d0 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -17,7 +17,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_PXA_EZX=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 038518a..557867a 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -6,7 +6,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_HOTPLUG is not set
 CONFIG_MODULES=y
-CONFIG_ARCH_FOOTBRIDGE=y
+CONFIG_ARCH_FOOTBRIDGE_CHOICE=y
 CONFIG_ARCH_CATS=y
 CONFIG_ARCH_PERSONAL_SERVER=y
 CONFIG_ARCH_EBSA285_HOST=y
diff --git a/arch/arm/configs/fortunet_defconfig b/arch/arm/configs/fortunet_defconfig
index 840fced..aa5652b 100644
--- a/arch/arm/configs/fortunet_defconfig
+++ b/arch/arm/configs/fortunet_defconfig
@@ -4,7 +4,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_HOTPLUG is not set
-CONFIG_ARCH_CLPS711X=y
+CONFIG_ARCH_CLPS711X_CHOICE=y
 CONFIG_ARCH_FORTUNET=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/g3evm_defconfig b/arch/arm/configs/g3evm_defconfig
index 4a336ab..4299600 100644
--- a/arch/arm/configs/g3evm_defconfig
+++ b/arch/arm/configs/g3evm_defconfig
@@ -8,7 +8,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_ARCH_SH7367=y
 CONFIG_MACH_G3EVM=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/g4evm_defconfig b/arch/arm/configs/g4evm_defconfig
index 21c6d03..e5fa444 100644
--- a/arch/arm/configs/g4evm_defconfig
+++ b/arch/arm/configs/g4evm_defconfig
@@ -8,7 +8,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_ARCH_SH7377=y
 CONFIG_MACH_G4EVM=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 317960f..65009de 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -7,7 +7,7 @@ CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_H3600=y
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
diff --git a/arch/arm/configs/h5000_defconfig b/arch/arm/configs/h5000_defconfig
index 37903e3..94cc67d 100644
--- a/arch/arm/configs/h5000_defconfig
+++ b/arch/arm/configs/h5000_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_H5000=y
 CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/h7201_defconfig b/arch/arm/configs/h7201_defconfig
index bee94d2..8404e5e 100644
--- a/arch/arm/configs/h7201_defconfig
+++ b/arch/arm/configs/h7201_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
-CONFIG_ARCH_H720X=y
+CONFIG_ARCH_H720X_CHOICE=y
 CONFIG_ARCH_H7201=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/configs/h7202_defconfig b/arch/arm/configs/h7202_defconfig
index 69405a7..768f654 100644
--- a/arch/arm/configs/h7202_defconfig
+++ b/arch/arm/configs/h7202_defconfig
@@ -2,7 +2,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_MODULES=y
-CONFIG_ARCH_H720X=y
+CONFIG_ARCH_H720X_CHOICE=y
 CONFIG_ARCH_H7202=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
index bed8047..7d2c376 100644
--- a/arch/arm/configs/hackkit_defconfig
+++ b/arch/arm/configs/hackkit_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_HACKKIT=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
diff --git a/arch/arm/configs/imote2_defconfig b/arch/arm/configs/imote2_defconfig
index fd996bb..6b574fd 100644
--- a/arch/arm/configs/imote2_defconfig
+++ b/arch/arm/configs/imote2_defconfig
@@ -16,7 +16,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_INTELMOTE2=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 78ed575..21fdab3 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -17,7 +17,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_MXC=y
+CONFIG_ARCH_MXC_CHOICE=y
 CONFIG_ARCH_IMX_V4_V5=y
 CONFIG_ARCH_MX1ADS=y
 CONFIG_MACH_SCB9328=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3c9f32f..cf959d2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -16,7 +16,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MXC=y
+CONFIG_ARCH_MXC_CHOICE=y
 CONFIG_MACH_MX31LILLY=y
 CONFIG_MACH_MX31LITE=y
 CONFIG_MACH_PCM037=y
diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index a8314c3..c3cfc4b 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -7,7 +7,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_ARCH_INTEGRATOR=y
+CONFIG_ARCH_INTEGRATOR_CHOICE=y
 CONFIG_ARCH_INTEGRATOR_AP=y
 CONFIG_ARCH_INTEGRATOR_CP=y
 CONFIG_CPU_ARM720T=y
diff --git a/arch/arm/configs/iop13xx_defconfig b/arch/arm/configs/iop13xx_defconfig
index 4fa94a1..5c0b6ec 100644
--- a/arch/arm/configs/iop13xx_defconfig
+++ b/arch/arm/configs/iop13xx_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_IOP13XX=y
+CONFIG_ARCH_IOP13XX_CHOICE=y
 CONFIG_MACH_IQ81340SC=y
 CONFIG_MACH_IQ81340MC=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index 4f2ec3a..92ba2c7 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -8,7 +8,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_IOP32X=y
+CONFIG_ARCH_IOP32X_CHOICE=y
 CONFIG_MACH_GLANTANK=y
 CONFIG_ARCH_IQ80321=y
 CONFIG_ARCH_IQ31244=y
diff --git a/arch/arm/configs/iop33x_defconfig b/arch/arm/configs/iop33x_defconfig
index aa36128..ea381ec 100644
--- a/arch/arm/configs/iop33x_defconfig
+++ b/arch/arm/configs/iop33x_defconfig
@@ -8,7 +8,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_IOP33X=y
+CONFIG_ARCH_IOP33X_CHOICE=y
 CONFIG_ARCH_IQ80331=y
 CONFIG_MACH_IQ80332=y
 # CONFIG_ARM_THUMB is not set
diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 063e2ab..663f522 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -7,7 +7,7 @@ CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_IXP4XX=y
+CONFIG_ARCH_IXP4XX_CHOICE=y
 CONFIG_MACH_NSLU2=y
 CONFIG_MACH_AVILA=y
 CONFIG_MACH_LOFT=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index ea80e7e..83e38b1 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -4,7 +4,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_JORNADA720=y
 CONFIG_SA1100_JORNADA720_SSP=y
 CONFIG_PCCARD=y
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index aeb3af5..accc8db 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -7,7 +7,7 @@ CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_KIRKWOOD=y
+CONFIG_ARCH_KIRKWOOD_CHOICE=y
 CONFIG_MACH_DB88F6281_BP=y
 CONFIG_MACH_RD88F6192_NAS=y
 CONFIG_MACH_RD88F6281=y
diff --git a/arch/arm/configs/kota2_defconfig b/arch/arm/configs/kota2_defconfig
index b7735d6..3b73777 100644
--- a/arch/arm/configs/kota2_defconfig
+++ b/arch/arm/configs/kota2_defconfig
@@ -17,7 +17,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_KOTA2=y
diff --git a/arch/arm/configs/ks8695_defconfig b/arch/arm/configs/ks8695_defconfig
index 47c4883..f795954 100644
--- a/arch/arm/configs/ks8695_defconfig
+++ b/arch/arm/configs/ks8695_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_KS8695=y
+CONFIG_ARCH_KS8695_CHOICE=y
 CONFIG_MACH_KS8695=y
 CONFIG_MACH_DSM320=y
 # CONFIG_ARM_THUMB is not set
diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
index 26146ff..5ce2ba4 100644
--- a/arch/arm/configs/kzm9d_defconfig
+++ b/arch/arm/configs/kzm9d_defconfig
@@ -12,7 +12,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_MACH_KZM9D=y
 CONFIG_MEMORY_START=0x40000000
diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 2388c86..5490470 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -21,7 +21,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_KZM9G=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index faa2865..68e03f9 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_LART=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index e42a0e3..d219a20 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -17,7 +17,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
-CONFIG_ARCH_LPC32XX=y
+CONFIG_ARCH_LPC32XX_CHOICE=y
 CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/lpd270_defconfig b/arch/arm/configs/lpd270_defconfig
index 1c8c9ee..12ee552 100644
--- a/arch/arm/configs/lpd270_defconfig
+++ b/arch/arm/configs/lpd270_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SLAB=y
 CONFIG_MODULES=y
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_LOGICPD_PXA270=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/lubbock_defconfig b/arch/arm/configs/lubbock_defconfig
index c4ba274..617271e 100644
--- a/arch/arm/configs/lubbock_defconfig
+++ b/arch/arm/configs/lubbock_defconfig
@@ -2,7 +2,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_MODULES=y
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_ARCH_LUBBOCK=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_PCCARD=y
diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 306a2e2..7ca4ffa 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_ARCH_SH7372=y
 CONFIG_MACH_MACKEREL=y
 CONFIG_MEMORY_SIZE=0x10000000
diff --git a/arch/arm/configs/magician_defconfig b/arch/arm/configs/magician_defconfig
index a691ef4..2e402f4 100644
--- a/arch/arm/configs/magician_defconfig
+++ b/arch/arm/configs/magician_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_H4700=y
 CONFIG_MACH_MAGICIAN=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/mainstone_defconfig b/arch/arm/configs/mainstone_defconfig
index 04efa1b..e90b18e 100644
--- a/arch/arm/configs/mainstone_defconfig
+++ b/arch/arm/configs/mainstone_defconfig
@@ -2,7 +2,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_MODULES=y
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_MAINSTONE=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_LEDS=y
diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 864f9a5..46c2a50 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -8,7 +8,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
 # CONFIG_BLOCK is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_CHOICE=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_MACH_MARZEN=y
 CONFIG_MEMORY_START=0x60000000
diff --git a/arch/arm/configs/mini2440_defconfig b/arch/arm/configs/mini2440_defconfig
index 082175c..828a920 100644
--- a/arch/arm/configs/mini2440_defconfig
+++ b/arch/arm/configs/mini2440_defconfig
@@ -13,7 +13,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_BLK_DEV_INTEGRITY=y
-CONFIG_ARCH_S3C24XX=y
+CONFIG_ARCH_S3C24XX_CHOICE=y
 # CONFIG_CPU_S3C2410 is not set
 CONFIG_CPU_S3C2440=y
 CONFIG_S3C_ADC=y
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 5a58452..c5e0355 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -7,7 +7,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MMP=y
+CONFIG_ARCH_MMP_CHOICE=y
 CONFIG_MACH_BROWNSTONE=y
 CONFIG_MACH_FLINT=y
 CONFIG_MACH_MARVELL_JASPER=y
diff --git a/arch/arm/configs/msm_defconfig b/arch/arm/configs/msm_defconfig
index 2b8f7af..77218bd 100644
--- a/arch/arm/configs/msm_defconfig
+++ b/arch/arm/configs/msm_defconfig
@@ -6,7 +6,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_MSM=y
+CONFIG_ARCH_MSM_CHOICE=y
 CONFIG_MACH_HALIBUT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 7305ebd..f2200bc 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -11,7 +11,7 @@ CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MV78XX0=y
+CONFIG_ARCH_MV78XX0_CHOICE=y
 CONFIG_MACH_DB78X00_BP=y
 CONFIG_MACH_RD78X00_MASA=y
 CONFIG_MACH_TERASTATION_WXL=y
diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 2e86b31..76f2486 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -8,7 +8,7 @@ CONFIG_EXPERT=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_ARCH_MVEBU=y
+CONFIG_ARCH_MVEBU_CHOICE=y
 CONFIG_MACH_ARMADA_370_XP=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 4edcfb4..a64a406 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -21,7 +21,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_BLK_DEV_INTEGRITY=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_MXS=y
+CONFIG_ARCH_MXS_CHOICE=y
 CONFIG_MACH_MXS_DT=y
 CONFIG_MACH_MX23EVK=y
 CONFIG_MACH_MX28EVK=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index d7dc992..ee6b316 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -4,7 +4,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_ASSABET=y
 CONFIG_ASSABET_NEPONSET=y
 CONFIG_PCCARD=y
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index 25ed772..e9bcdc3 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -1,7 +1,7 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_ARCH_FOOTBRIDGE=y
+CONFIG_ARCH_FOOTBRIDGE_CHOICE=y
 CONFIG_ARCH_NETWINDER=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
diff --git a/arch/arm/configs/netx_defconfig b/arch/arm/configs/netx_defconfig
index 9c0ad79..4d036c9 100644
--- a/arch/arm/configs/netx_defconfig
+++ b/arch/arm/configs/netx_defconfig
@@ -8,7 +8,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_ARCH_NETX=y
+CONFIG_ARCH_NETX_CHOICE=y
 CONFIG_MACH_NXDKN=y
 CONFIG_MACH_NXDB500=y
 CONFIG_MACH_NXEB500HMI=y
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index bf123c5..2e327e0 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -13,7 +13,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_NOMADIK=y
+CONFIG_ARCH_NOMADIK_CHOICE=y
 CONFIG_MACH_NOMADIK_8815NHK=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/nuc910_defconfig b/arch/arm/configs/nuc910_defconfig
index 10180cf..4d05295 100644
--- a/arch/arm/configs/nuc910_defconfig
+++ b/arch/arm/configs/nuc910_defconfig
@@ -8,7 +8,7 @@ CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
-CONFIG_ARCH_W90X900=y
+CONFIG_ARCH_W90X900_CHOICE=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/ram0 console=ttyS0,115200n8 rdinit=/sbin/init mem=64M"
diff --git a/arch/arm/configs/nuc950_defconfig b/arch/arm/configs/nuc950_defconfig
index 27aa873..846fd11 100644
--- a/arch/arm/configs/nuc950_defconfig
+++ b/arch/arm/configs/nuc950_defconfig
@@ -8,7 +8,7 @@ CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
-CONFIG_ARCH_W90X900=y
+CONFIG_ARCH_W90X900_CHOICE=y
 # CONFIG_MACH_W90P910EVB is not set
 CONFIG_MACH_W90P950EVB=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/nuc960_defconfig b/arch/arm/configs/nuc960_defconfig
index 56fd7ad..3ec4197 100644
--- a/arch/arm/configs/nuc960_defconfig
+++ b/arch/arm/configs/nuc960_defconfig
@@ -8,7 +8,7 @@ CONFIG_USER_NS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_SLAB=y
-CONFIG_ARCH_W90X900=y
+CONFIG_ARCH_W90X900_CHOICE=y
 # CONFIG_MACH_W90P910EVB is not set
 CONFIG_MACH_W90N960EVB=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index dde2a1a..43e9487 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -22,7 +22,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_OMAP=y
+CONFIG_ARCH_OMAP_CHOICE=y
 CONFIG_ARCH_OMAP1=y
 CONFIG_OMAP_RESET_CLOCKS=y
 # CONFIG_OMAP_MUX is not set
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index e58edc3..7d959cd 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -20,7 +20,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_OMAP=y
+CONFIG_ARCH_OMAP_CHOICE=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_ARM_THUMBEE=y
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index a288d70..cad9bd5 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -10,7 +10,7 @@ CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_ORION5X=y
+CONFIG_ARCH_ORION5X_CHOICE=y
 CONFIG_MACH_DB88F5281=y
 CONFIG_MACH_RD88F5182=y
 CONFIG_MACH_KUROBOX_PRO=y
diff --git a/arch/arm/configs/palmz72_defconfig b/arch/arm/configs/palmz72_defconfig
index 4baa83c..67cff48 100644
--- a/arch/arm/configs/palmz72_defconfig
+++ b/arch/arm/configs/palmz72_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_ARCH_PXA_PALM=y
 # CONFIG_MACH_PALMTX is not set
 CONFIG_PREEMPT=y
diff --git a/arch/arm/configs/pcm027_defconfig b/arch/arm/configs/pcm027_defconfig
index 2f136c3..521caef 100644
--- a/arch/arm/configs/pcm027_defconfig
+++ b/arch/arm/configs/pcm027_defconfig
@@ -16,7 +16,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_PCM027=y
 CONFIG_MACH_PCM990_BASEBOARD=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/pleb_defconfig b/arch/arm/configs/pleb_defconfig
index cb08cc5..703751e 100644
--- a/arch/arm/configs/pleb_defconfig
+++ b/arch/arm/configs/pleb_defconfig
@@ -9,7 +9,7 @@ CONFIG_EXPERT=y
 CONFIG_MODULES=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_PLEB=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/configs/pnx4008_defconfig b/arch/arm/configs/pnx4008_defconfig
index 35a31cc..87e705d 100644
--- a/arch/arm/configs/pnx4008_defconfig
+++ b/arch/arm/configs/pnx4008_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_ARCH_PNX4008=y
+CONFIG_ARCH_PNX4008_CHOICE=y
 CONFIG_PREEMPT=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
index c328ac6..e23ebd2 100644
--- a/arch/arm/configs/prima2_defconfig
+++ b/arch/arm/configs/prima2_defconfig
@@ -8,7 +8,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_ARCH_PRIMA2=y
+CONFIG_ARCH_PRIMA2_CHOICE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index 74d7e01..f479d22 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -7,7 +7,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MMP=y
+CONFIG_ARCH_MMP_CHOICE=y
 CONFIG_MACH_ASPENITE=y
 CONFIG_MACH_ZYLONITE2=y
 CONFIG_MACH_AVENGERS_LITE=y
diff --git a/arch/arm/configs/pxa255-idp_defconfig b/arch/arm/configs/pxa255-idp_defconfig
index 917a070..e836371 100644
--- a/arch/arm/configs/pxa255-idp_defconfig
+++ b/arch/arm/configs/pxa255-idp_defconfig
@@ -2,7 +2,7 @@ CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_MODULES=y
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_ARCH_PXA_IDP=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_LEDS=y
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index 1677a06..0da136d 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -7,7 +7,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_LITTLETON=y
 CONFIG_MACH_TAVOREVB=y
 CONFIG_MACH_SAAR=y
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 1cd381e..73a3c23 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -8,7 +8,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_MMP=y
+CONFIG_ARCH_MMP_CHOICE=y
 CONFIG_MACH_TAVOREVB=y
 CONFIG_MACH_TTC_DKB=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/qil-a9260_defconfig b/arch/arm/configs/qil-a9260_defconfig
index 9160f3b..446403b 100644
--- a/arch/arm/configs/qil-a9260_defconfig
+++ b/arch/arm/configs/qil-a9260_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9260=y
 CONFIG_MACH_QIL_A9260=y
 CONFIG_AT91_SLOW_CLOCK=y
diff --git a/arch/arm/configs/raumfeld_defconfig b/arch/arm/configs/raumfeld_defconfig
index f7caa90..062fbcd 100644
--- a/arch/arm/configs/raumfeld_defconfig
+++ b/arch/arm/configs/raumfeld_defconfig
@@ -5,7 +5,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_RAUMFELD_RC=y
 CONFIG_MACH_RAUMFELD_CONNECTOR=y
 CONFIG_MACH_RAUMFELD_SPEAKER=y
diff --git a/arch/arm/configs/realview-smp_defconfig b/arch/arm/configs/realview-smp_defconfig
index abe61bf..8080936 100644
--- a/arch/arm/configs/realview-smp_defconfig
+++ b/arch/arm/configs/realview-smp_defconfig
@@ -8,7 +8,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_REALVIEW=y
+CONFIG_ARCH_REALVIEW_CHOICE=y
 CONFIG_MACH_REALVIEW_EB=y
 CONFIG_REALVIEW_EB_ARM11MP=y
 CONFIG_MACH_REALVIEW_PB11MP=y
diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 7079cbe..4114be5 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -8,7 +8,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_REALVIEW=y
+CONFIG_ARCH_REALVIEW_CHOICE=y
 CONFIG_MACH_REALVIEW_EB=y
 CONFIG_REALVIEW_EB_ARM11MP=y
 CONFIG_MACH_REALVIEW_PB11MP=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index 00515ef..e57d7af 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -7,7 +7,7 @@ CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_RPC=y
+CONFIG_ARCH_RPC_CHOICE=y
 CONFIG_CPU_SA110=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index 193448f..80b7757 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -11,7 +11,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_ARCH_S3C24XX=y
+CONFIG_ARCH_S3C24XX_CHOICE=y
 CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_S3C_ADC=y
 CONFIG_S3C24XX_PWM=y
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index ba6a515..72cd97a 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -5,7 +5,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_S3C64XX=y
+CONFIG_ARCH_S3C64XX_CHOICE=y
 CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_MACH_SMDK6400=y
 CONFIG_MACH_ANW6410=y
diff --git a/arch/arm/configs/s5p64x0_defconfig b/arch/arm/configs/s5p64x0_defconfig
index ad6b61b..32edf95 100644
--- a/arch/arm/configs/s5p64x0_defconfig
+++ b/arch/arm/configs/s5p64x0_defconfig
@@ -5,7 +5,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_S5P64X0=y
+CONFIG_ARCH_S5P64X0_CHOICE=y
 CONFIG_S3C_BOOT_ERROR_RESET=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_MACH_SMDK6440=y
diff --git a/arch/arm/configs/s5pc100_defconfig b/arch/arm/configs/s5pc100_defconfig
index 41bafc9..eb6dbd7 100644
--- a/arch/arm/configs/s5pc100_defconfig
+++ b/arch/arm/configs/s5pc100_defconfig
@@ -5,7 +5,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_S5PC100=y
+CONFIG_ARCH_S5PC100_CHOICE=y
 CONFIG_MACH_SMDKC100=y
 CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/mtdblock2 rootfstype=cramfs init=/linuxrc console=ttySAC2,115200 mem=128M"
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index fa98990..5176dac59 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -5,7 +5,7 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_S5PV210=y
+CONFIG_ARCH_S5PV210_CHOICE=y
 CONFIG_S3C_LOWLEVEL_UART_PORT=1
 CONFIG_S3C_DEV_FB=y
 CONFIG_S5PV210_SETUP_FB_24BPP=y
diff --git a/arch/arm/configs/sam9_l9260_defconfig b/arch/arm/configs/sam9_l9260_defconfig
index ecf2531..18d831b 100644
--- a/arch/arm/configs/sam9_l9260_defconfig
+++ b/arch/arm/configs/sam9_l9260_defconfig
@@ -9,7 +9,7 @@ CONFIG_LOG_BUF_SHIFT=15
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9260=y
 CONFIG_MACH_SAM9_L9260=y
 CONFIG_MTD_AT91_DATAFLASH_CARD=y
diff --git a/arch/arm/configs/shannon_defconfig b/arch/arm/configs/shannon_defconfig
index b0b9694..b64afb0 100644
--- a/arch/arm/configs/shannon_defconfig
+++ b/arch/arm/configs/shannon_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_SHANNON=y
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
diff --git a/arch/arm/configs/shark_defconfig b/arch/arm/configs/shark_defconfig
index caa07db..6579d28 100644
--- a/arch/arm/configs/shark_defconfig
+++ b/arch/arm/configs/shark_defconfig
@@ -8,7 +8,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_SHARK=y
+CONFIG_ARCH_SHARK_CHOICE=y
 CONFIG_LEDS=y
 CONFIG_LEDS_TIMER=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/simpad_defconfig b/arch/arm/configs/simpad_defconfig
index d335815..e3bbdf9 100644
--- a/arch/arm/configs/simpad_defconfig
+++ b/arch/arm/configs/simpad_defconfig
@@ -6,7 +6,7 @@ CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
 CONFIG_MODULES=y
-CONFIG_ARCH_SA1100=y
+CONFIG_ARCH_SA1100_CHOICE=y
 CONFIG_SA1100_SIMPAD=y
 CONFIG_PCCARD=y
 CONFIG_PCMCIA_SA1100=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 0ac1293..89023b6 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -15,7 +15,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SOCFPGA=y
+CONFIG_ARCH_SOCFPGA_CHOICE=y
 CONFIG_MACH_SOCFPGA_CYCLONE5=y
 CONFIG_ARM_THUMBEE=y
 # CONFIG_CACHE_L2X0 is not set
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 1fdb826..ea4069c 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -7,7 +7,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PLAT_SPEAR=y
-CONFIG_ARCH_SPEAR13XX=y
+CONFIG_ARCH_SPEAR13XX_CHOICE=y
 CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
 # CONFIG_SWP_EMULATE is not set
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index a2a1265..a82ba96 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -7,7 +7,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_PLAT_SPEAR=y
-CONFIG_ARCH_SPEAR6XX=y
+CONFIG_ARCH_SPEAR6XX_CHOICE=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 7015827..35667a0 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -11,7 +11,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
diff --git a/arch/arm/configs/stamp9g20_defconfig b/arch/arm/configs/stamp9g20_defconfig
index d5e260b..23da280 100644
--- a/arch/arm/configs/stamp9g20_defconfig
+++ b/arch/arm/configs/stamp9g20_defconfig
@@ -11,7 +11,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9G20=y
 CONFIG_MACH_PORTUXG20=y
 CONFIG_MACH_STAMP9G20=y
diff --git a/arch/arm/configs/tct_hammer_defconfig b/arch/arm/configs/tct_hammer_defconfig
index 71277a1..d618ae2 100644
--- a/arch/arm/configs/tct_hammer_defconfig
+++ b/arch/arm/configs/tct_hammer_defconfig
@@ -14,7 +14,7 @@ CONFIG_SLOB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_S3C24XX=y
+CONFIG_ARCH_S3C24XX_CHOICE=y
 CONFIG_MACH_TCT_HAMMER=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index db22453..24c16fa 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -23,7 +23,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_EFI_PARTITION=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_TEGRA=y
+CONFIG_ARCH_TEGRA_CHOICE=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_MACH_HARMONY=y
diff --git a/arch/arm/configs/trizeps4_defconfig b/arch/arm/configs/trizeps4_defconfig
index 3162173..7433db3 100644
--- a/arch/arm/configs/trizeps4_defconfig
+++ b/arch/arm/configs/trizeps4_defconfig
@@ -15,7 +15,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_TRIZEPS_PXA=y
 CONFIG_MACH_TRIZEPS4=y
 CONFIG_PCCARD=y
diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index 374000e..2a0b97d 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -11,7 +11,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_U300=y
+CONFIG_ARCH_U300_CHOICE=y
 CONFIG_MACH_U300=y
 CONFIG_MACH_U300_BS335=y
 CONFIG_MACH_U300_SPIDUMMY=y
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 2d4f661..35aa6dc 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -7,7 +7,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARCH_U8500=y
+CONFIG_ARCH_U8500_CHOICE=y
 CONFIG_MACH_HREFV60=y
 CONFIG_MACH_SNOWBALL=y
 CONFIG_MACH_U5500=y
diff --git a/arch/arm/configs/usb-a9260_defconfig b/arch/arm/configs/usb-a9260_defconfig
index 2e39f38..d2c5d90 100644
--- a/arch/arm/configs/usb-a9260_defconfig
+++ b/arch/arm/configs/usb-a9260_defconfig
@@ -10,7 +10,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_AT91=y
+CONFIG_ARCH_AT91_CHOICE=y
 CONFIG_ARCH_AT91SAM9260=y
 CONFIG_MACH_USB_A9260=y
 CONFIG_AT91_SLOW_CLOCK=y
diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index f2de51f..75c85ad 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -21,7 +21,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_VEXPRESS=y
+CONFIG_ARCH_VEXPRESS_CHOICE=y
 CONFIG_ARCH_VEXPRESS_CA9X4=y
 # CONFIG_SWP_EMULATE is not set
 CONFIG_SMP=y
diff --git a/arch/arm/configs/viper_defconfig b/arch/arm/configs/viper_defconfig
index 1d01ddd..2e9d898 100644
--- a/arch/arm/configs/viper_defconfig
+++ b/arch/arm/configs/viper_defconfig
@@ -11,7 +11,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_ARCH_VIPER=y
 CONFIG_IWMMXT=y
 CONFIG_PCCARD=m
diff --git a/arch/arm/configs/xcep_defconfig b/arch/arm/configs/xcep_defconfig
index 721832f..3136636 100644
--- a/arch/arm/configs/xcep_defconfig
+++ b/arch/arm/configs/xcep_defconfig
@@ -20,7 +20,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLOCK is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_XCEP=y
 CONFIG_IWMMXT=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/zeus_defconfig b/arch/arm/configs/zeus_defconfig
index 547a3c1..4a1b536 100644
--- a/arch/arm/configs/zeus_defconfig
+++ b/arch/arm/configs/zeus_defconfig
@@ -6,7 +6,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_PXA=y
+CONFIG_ARCH_PXA_CHOICE=y
 CONFIG_MACH_ARCOM_ZEUS=y
 CONFIG_PCCARD=m
 CONFIG_PCMCIA_PXA2XX=m
-- 
1.7.9.5
