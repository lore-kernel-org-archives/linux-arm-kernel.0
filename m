From: js07.lee@gmail.com (Jungseung Lee)
Date: Thu,  5 May 2016 23:33:10 +0900
Subject: [PATCH] ARM: iop: Fix indentation
Message-ID: <1462458790-5927-1-git-send-email-js07.lee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix indentation in iop_3xx_std_desc

Signed-off-by: Jungseung Lee <js07.lee@gmail.com>
---
 arch/arm/plat-iop/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-iop/setup.c b/arch/arm/plat-iop/setup.c
index 5b217f4..8151bde 100644
--- a/arch/arm/plat-iop/setup.c
+++ b/arch/arm/plat-iop/setup.c
@@ -20,12 +20,12 @@
  * the IOP3xx OCCDR must be mapped uncached and unbuffered.
  */
 static struct map_desc iop3xx_std_desc[] __initdata = {
-	 {	/* mem mapped registers */
+	{	/* mem mapped registers */
 		.virtual	= IOP3XX_PERIPHERAL_VIRT_BASE,
 		.pfn		= __phys_to_pfn(IOP3XX_PERIPHERAL_PHYS_BASE),
 		.length		= IOP3XX_PERIPHERAL_SIZE,
 		.type		= MT_UNCACHED,
-	 },
+	},
 };
 
 void __init iop3xx_map_io(void)
-- 
1.9.1
