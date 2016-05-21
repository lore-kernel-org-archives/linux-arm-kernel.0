From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:51:36 +0200
Subject: [PATCH 0118/1529] Fix typo
Message-ID: <20160521115136.5547-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-s3c24xx/mach-n30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 171c1f1..070a0d0 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -522,7 +522,7 @@ static void __init n30_hwinit(void)
 	 *
 	 * The pull ups for H6/H7 are enabled on N30 but not on the
 	 * N35/PiN.  I suppose is useful for a budget model of the N30
-	 * with no bluetooh.  It doesn't hurt to have the pull ups
+	 * with no bluetooth.  It doesn't hurt to have the pull ups
 	 * enabled on the N35, so leave them enabled for all models.
 	 */
 	__raw_writel(0x0028aaaa, S3C2410_GPHCON);
-- 
2.8.2.534.g1f66975
