From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:51:43 +0200
Subject: [PATCH 0119/1529] Fix typo
Message-ID: <20160521115143.5598-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index ce2db23..262ab07 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -143,7 +143,7 @@ static int osiris_dvs_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/* the CONFIG_PM block is so small, it isn't worth actaully compiling it
+/* the CONFIG_PM block is so small, it isn't worth actually compiling it
  * out if the configuration isn't set. */
 
 static int osiris_dvs_suspend(struct device *dev)
-- 
2.8.2.534.g1f66975
