From: robherring2@gmail.com (Rob Herring)
Date: Tue, 28 Aug 2012 09:19:42 -0500
Subject: [PATCH] ARM: highbank: add a defconfig
Message-ID: <1346163582-13627-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/configs/highbank_defconfig |   39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 arch/arm/configs/highbank_defconfig

diff --git a/arch/arm/configs/highbank_defconfig b/arch/arm/configs/highbank_defconfig
new file mode 100644
index 0000000..38154be
--- /dev/null
+++ b/arch/arm/configs/highbank_defconfig
@@ -0,0 +1,39 @@
+CONFIG_EXPERIMENTAL=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_ARCH_HIGHBANK=y
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_SMP=y
+CONFIG_SCHED_MC=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+CONFIG_CMDLINE="console=ttyAMA0"
+CONFIG_CPU_IDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+CONFIG_NET=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_NETDEVICES=y
+CONFIG_NET_CALXEDA_XGMAC=y
+CONFIG_SERIAL_AMBA_PL011=y
+CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_IPMI_HANDLER=y
+CONFIG_IPMI_SI=y
+CONFIG_I2C=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_SPI=y
+CONFIG_SPI_PL022=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_PL061=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_EDAC=y
+CONFIG_EDAC_MM_EDAC=y
+CONFIG_EDAC_HIGHBANK_MC=y
+CONFIG_EDAC_HIGHBANK_L2=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PL031=y
+CONFIG_DMADEVICES=y
+CONFIG_PL330_DMA=y
-- 
1.7.9.5
