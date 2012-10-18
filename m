From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 18 Oct 2012 16:26:31 +0530
Subject: [PATCH 1/5] ARM: tegra: Add slink controller base address
In-Reply-To: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
References: <1350557795-31487-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1350557795-31487-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add base address of all slink controller of Tegra20
and tegra30.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/iomap.h |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index fee3a94..0f46765 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -206,17 +206,23 @@
 #define TEGRA_DVC_BASE			0x7000D000
 #define TEGRA_DVC_SIZE			SZ_512
 
-#define TEGRA_SPI1_BASE			0x7000D400
-#define TEGRA_SPI1_SIZE			SZ_512
+#define TEGRA_SLINK1_BASE		0x7000D400
+#define TEGRA_SLINK1_SIZE		SZ_512
 
-#define TEGRA_SPI2_BASE			0x7000D600
-#define TEGRA_SPI2_SIZE			SZ_512
+#define TEGRA_SLINK2_BASE		0x7000D600
+#define TEGRA_SLINK2_SIZE		SZ_512
 
-#define TEGRA_SPI3_BASE			0x7000D800
-#define TEGRA_SPI3_SIZE			SZ_512
+#define TEGRA_SLINK3_BASE		0x7000D800
+#define TEGRA_SLINK3_SIZE		SZ_512
 
-#define TEGRA_SPI4_BASE			0x7000DA00
-#define TEGRA_SPI4_SIZE			SZ_512
+#define TEGRA_SLINK4_BASE		0x7000DA00
+#define TEGRA_SLINK4_SIZE		SZ_512
+
+#define TEGRA_SLINK5_BASE		0x7000DC00
+#define TEGRA_SLINK5_SIZE		SZ_512
+
+#define TEGRA_SLINK6_BASE		0x7000DE00
+#define TEGRA_SLINK6_SIZE		SZ_512
 
 #define TEGRA_RTC_BASE			0x7000E000
 #define TEGRA_RTC_SIZE			SZ_256
-- 
1.7.1.1
