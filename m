From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 27 Jun 2014 18:58:49 +0200
Subject: [RFC 4/4] soc/tegra: Remove unused defines
In-Reply-To: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403888329-24755-4-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Eventually the aim is to get rid of this file because it cannot be built
on ARM64. Until it can be completely removed, eliminate unused entries
to make it easier to see which are still used.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/iomap.h | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/soc/tegra/iomap.h b/drivers/soc/tegra/iomap.h
index 52bbb5c8fe84..c2fd86a9b43f 100644
--- a/drivers/soc/tegra/iomap.h
+++ b/drivers/soc/tegra/iomap.h
@@ -28,21 +28,9 @@
 #define TEGRA_ARM_PERIF_BASE		0x50040000
 #define TEGRA_ARM_PERIF_SIZE		SZ_8K
 
-#define TEGRA_TMR1_BASE			0x60005000
-#define TEGRA_TMR1_SIZE			SZ_8
-
-#define TEGRA_TMR2_BASE			0x60005008
-#define TEGRA_TMR2_SIZE			SZ_8
-
 #define TEGRA_TMRUS_BASE		0x60005010
 #define TEGRA_TMRUS_SIZE		SZ_64
 
-#define TEGRA_TMR3_BASE			0x60005050
-#define TEGRA_TMR3_SIZE			SZ_8
-
-#define TEGRA_TMR4_BASE			0x60005058
-#define TEGRA_TMR4_SIZE			SZ_8
-
 #define TEGRA_CLK_RESET_BASE		0x60006000
 #define TEGRA_CLK_RESET_SIZE		SZ_4K
 
@@ -58,21 +46,6 @@
 #define TEGRA_APB_MISC_BASE		0x70000000
 #define TEGRA_APB_MISC_SIZE		SZ_4K
 
-#define TEGRA_UARTA_BASE		0x70006000
-#define TEGRA_UARTA_SIZE		SZ_64
-
-#define TEGRA_UARTB_BASE		0x70006040
-#define TEGRA_UARTB_SIZE		SZ_64
-
-#define TEGRA_UARTC_BASE		0x70006200
-#define TEGRA_UARTC_SIZE		SZ_256
-
-#define TEGRA_UARTD_BASE		0x70006300
-#define TEGRA_UARTD_SIZE		SZ_256
-
-#define TEGRA_UARTE_BASE		0x70006400
-#define TEGRA_UARTE_SIZE		SZ_256
-
 #define TEGRA_PMC_BASE			0x7000E400
 #define TEGRA_PMC_SIZE			SZ_256
 
@@ -91,9 +64,6 @@
 #define TEGRA124_EMC_BASE		0x7001B000
 #define TEGRA124_EMC_SIZE		SZ_2K
 
-#define TEGRA_CSITE_BASE		0x70040000
-#define TEGRA_CSITE_SIZE		SZ_256K
-
 /* On TEGRA, many peripherals are very closely packed in
  * two 256MB io windows (that actually only use about 64KB
  * at the start of each).
-- 
2.0.0
