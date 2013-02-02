From: girishks2000@gmail.com (girishks2000 at gmail.com)
Date: Fri,  1 Feb 2013 17:56:24 -0800
Subject: [PATCH 1/2] ahci: sata: add support for exynos5440 sata
Message-ID: <510c7282.a4d1440a.7061.2697@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Girish K S <ks.giri@samsung.com>

This patch adds the compatible string of the exynos5440 sata controller
compliant with the ahci 1.3 and sata 3.0 specification.

Signed-off-by: Girish K S <ks.giri@samsung.com>
---
 drivers/ata/ahci_platform.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 7a8a284..c06f021 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -327,6 +327,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
 
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
+	{ .compatible = "samsung,exynos5440-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.7.10.4
