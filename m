From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 30 Jan 2017 13:38:22 +0100
Subject: [PATCH v3 1/7] soc: smasung: pmu: Add register defines for pad
 retention control
In-Reply-To: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
References: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130123837eucas1p1056a57f23b1e3bf089e5bc55bb2cf2d4@eucas1p1.samsung.com>
Message-ID: <1485779908-32147-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PMU defines related to pad retention control. Will be later used
by the Exynos pin controller driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/soc/samsung/exynos-regs-pmu.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 9786c62d7159..49df0a01a2cc 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -631,4 +631,20 @@
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI2  \
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
 
+/* For EXYNOS5433 */
+#define EXYNOS5433_PAD_RETENTION_AUD_OPTION			(0x3028)
+#define EXYNOS5433_PAD_RETENTION_MMC2_OPTION			(0x30C8)
+#define EXYNOS5433_PAD_RETENTION_TOP_OPTION			(0x3108)
+#define EXYNOS5433_PAD_RETENTION_UART_OPTION			(0x3128)
+#define EXYNOS5433_PAD_RETENTION_MMC0_OPTION			(0x3148)
+#define EXYNOS5433_PAD_RETENTION_MMC1_OPTION			(0x3168)
+#define EXYNOS5433_PAD_RETENTION_EBIA_OPTION			(0x3188)
+#define EXYNOS5433_PAD_RETENTION_EBIB_OPTION			(0x31A8)
+#define EXYNOS5433_PAD_RETENTION_SPI_OPTION			(0x31C8)
+#define EXYNOS5433_PAD_RETENTION_MIF_OPTION			(0x31E8)
+#define EXYNOS5433_PAD_RETENTION_USBXTI_OPTION			(0x3228)
+#define EXYNOS5433_PAD_RETENTION_BOOTLDO_OPTION			(0x3248)
+#define EXYNOS5433_PAD_RETENTION_UFS_OPTION			(0x3268)
+#define EXYNOS5433_PAD_RETENTION_FSYSGENIO_OPTION		(0x32A8)
+
 #endif /* __LINUX_SOC_EXYNOS_REGS_PMU_H */
-- 
1.9.1
