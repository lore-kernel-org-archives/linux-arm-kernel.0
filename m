From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Dec 2017 17:54:19 +0100
Subject: [PATCH 2/2] cpufreq: sort the drivers in ARM part
In-Reply-To: <20171212165419.752-1-gregory.clement@free-electrons.com>
References: <20171212165419.752-1-gregory.clement@free-electrons.com>
Message-ID: <20171212165419.752-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keep the driver files alphabetically sorted.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/cpufreq/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 812f9e0d01a3..d762e76887e7 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -53,22 +53,24 @@ obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
 obj-$(CONFIG_ARM_DT_BL_CPUFREQ)		+= arm_big_little_dt.o
 
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
+obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
 obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
+obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
 obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
 obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
-obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
-obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
 obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
 obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
 obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
 obj-$(CONFIG_ARM_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
 obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
+obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
+obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
 obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
@@ -81,8 +83,6 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
 obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
-obj-$(CONFIG_ACPI_CPPC_CPUFREQ) += cppc_cpufreq.o
-obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
 
 
 ##################################################################################
-- 
2.15.1
