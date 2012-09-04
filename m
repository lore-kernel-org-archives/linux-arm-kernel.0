From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 04 Sep 2012 10:50:07 +0200
Subject: [PATCH v2 3/5] ARM: Exynos4: Add OF compatibility lookups for Exynos4
 i2c adapters
In-Reply-To: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
Message-ID: <1346748609-11115-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-exynos4-dt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 8dad4ec..5f805b4 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -55,6 +55,20 @@ static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
 				"exynos4-sdhci.3", NULL),
 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(0),
 				"s3c2440-i2c.0", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(1),
+				"s3c2440-i2c.1", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(2),
+				"s3c2440-i2c.2", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(3),
+				"s3c2440-i2c.3", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(4),
+				"s3c2440-i2c.4", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(5),
+				"s3c2440-i2c.5", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(6),
+				"s3c2440-i2c.6", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(7),
+				"s3c2440-i2c.7", NULL),
 	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS4_PA_SPI0,
 				"exynos4210-spi.0", NULL),
 	OF_DEV_AUXDATA("samsung,exynos4210-spi", EXYNOS4_PA_SPI1,
-- 
1.7.12
