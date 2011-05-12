From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 10:11:09 +0900
Subject: [PATCH 2/7] ASoC: Remove to support sound for S5PC100
In-Reply-To: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1305162674-25860-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to removing ARCH_S5PC100, we don't need to support
sound for S5PC100.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 sound/soc/samsung/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index a3fdfb6..9ed5d11 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,6 @@
 config SND_SOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_S5P6442 || ARCH_EXYNOS4
+	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_S5P6442 || ARCH_EXYNOS4
 	select S3C64XX_DMA if ARCH_S3C64XX
 	select S3C2410_DMA if ARCH_S3C2410
 	help
-- 
1.7.1
