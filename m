From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:46:54 +0200
Subject: [PATCH 2/2] phy: exynos: fix SATA phy license typo
In-Reply-To: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560433-1402630-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the license string doesn't match exactly, the module refuses
to load.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
---
 drivers/phy/phy-exynos5250-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
1.8.3.2
