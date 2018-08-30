From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:44:49 +0200
Subject: [PATCH v3 01/30] mfd: Makefile: Remove build option for
 MFD:sun4i-gpadc
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-2-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we are merging the mfd driver into the sun4i-gpadc driver we need
to remove the build options for the sun4i-gpadc driver.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/mfd/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index e9fd20dba18d..c680994db988 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -220,7 +220,6 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
 
 obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
-obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
 
 obj-$(CONFIG_MFD_STM32_LPTIMER)	+= stm32-lptimer.o
 obj-$(CONFIG_MFD_STM32_TIMERS) 	+= stm32-timers.o
-- 
2.11.0
