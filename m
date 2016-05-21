From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:52:29 +0200
Subject: [PATCH 0124/1529] Fix typo
Message-ID: <20160521115229.5862-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/plat-samsung/include/plat/fb-s3c2410.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/include/plat/fb-s3c2410.h b/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
index 4e5d958..1f2972a 100644
--- a/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
+++ b/arch/arm/plat-samsung/include/plat/fb-s3c2410.h
@@ -48,7 +48,7 @@ struct s3c2410fb_display {
 
 struct s3c2410fb_mach_info {
 
-	struct s3c2410fb_display *displays;	/* attached diplays info */
+	struct s3c2410fb_display *displays;	/* attached displays info */
 	unsigned num_displays;			/* number of defined displays */
 	unsigned default_display;
 
-- 
2.8.2.534.g1f66975
