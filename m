From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:51:16 +0200
Subject: [PATCH 0115/1529] Fix typo
Message-ID: <20160521115116.5387-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-rpc/include/mach/acornfb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/include/mach/acornfb.h b/arch/arm/mach-rpc/include/mach/acornfb.h
index 395d762..f447d27 100644
--- a/arch/arm/mach-rpc/include/mach/acornfb.h
+++ b/arch/arm/mach-rpc/include/mach/acornfb.h
@@ -21,7 +21,7 @@ acornfb_valid_pixrate(struct fb_var_screeninfo *var)
 		return 0;
 
 	/*
-	 * Limits below are taken from RISC OS bandwidthlimit file
+	 * Limits below are taken from RISC OS bandwidth limit file
 	 */
 	if (current_par.using_vram) {
 		if (current_par.vram_half_sam == 2048)
-- 
2.8.2.534.g1f66975
