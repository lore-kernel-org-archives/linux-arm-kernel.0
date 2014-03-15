From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Mar 2014 10:37:12 +0100
Subject: [PATCH] PHY: Exynos: fix SATA phy license typo
Message-ID: <201403151037.12694.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the license string doesn't match exactly, the module refuses to load.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/phy/phy-exynos5250-sata.c b/drivers/phy/phy-exynos5250-sata.c
index c9361b7..0568945 100644
--- a/drivers/phy/phy-exynos5250-sata.c
+++ b/drivers/phy/phy-exynos5250-sata.c
@@ -246,6 +246,6 @@ static struct platform_driver exynos_sata_phy_driver = {
 module_platform_driver(exynos_sata_phy_driver);
 
 MODULE_DESCRIPTION("Samsung SerDes PHY driver");
-MODULE_LICENSE("GPL V2");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Girish K S <ks.giri@samsung.com>");
 MODULE_AUTHOR("Yuvaraj C D <yuvaraj.cd@samsung.com>");
