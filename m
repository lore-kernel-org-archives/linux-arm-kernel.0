From: dianders@chromium.org (Doug Anderson)
Date: Tue, 20 Nov 2012 14:22:35 -0800
Subject: [PATCH] ARM: exynos: dt: add all i2c busses to auxdata
Message-ID: <1353450155-1663-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>

Needed to match device ids for clocks, etc.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Doug Anderson <dianders@chromium.org>

---
 arch/arm/mach-exynos/mach-exynos5-dt.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index ed37273..e1491f7 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -52,6 +52,16 @@ static const struct of_dev_auxdata exynos5250_auxdata_lookup[] __initconst = {
 				"s3c2440-i2c.1", NULL),
 	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(2),
 				"s3c2440-i2c.2", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(3),
+				"s3c2440-i2c.3", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(4),
+				"s3c2440-i2c.4", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(5),
+				"s3c2440-i2c.5", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(6),
+				"s3c2440-i2c.6", NULL),
+	OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS5_PA_IIC(7),
+				"s3c2440-i2c.7", NULL),
 	OF_DEV_AUXDATA("samsung,s3c2440-hdmiphy-i2c", EXYNOS5_PA_IIC(8),
 				"s3c2440-hdmiphy-i2c", NULL),
 	OF_DEV_AUXDATA("samsung,exynos5250-dw-mshc", EXYNOS5_PA_DWMCI0,
-- 
1.7.7.3
