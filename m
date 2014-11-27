From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 27 Nov 2014 12:05:43 +0100
Subject: [PATCH/TRIVIAL 1/4] ARM: l2c: Grammar s/If ... if/If ... is/
Message-ID: <1417086346-23698-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mm/cache-l2x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 5e65ca8dea62cf3f..5216bfe7fd86f557 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -979,7 +979,7 @@ static int __init l2x0_cache_size_of_parse(const struct device_node *np,
 	/* All these l2 caches have the same line = block size actually */
 	if (!line_size) {
 		if (block_size) {
-			/* If linesize if not given, it is equal to blocksize */
+			/* If linesize is not given, it is equal to blocksize */
 			line_size = block_size;
 		} else {
 			/* Fall back to known size */
-- 
1.9.1
