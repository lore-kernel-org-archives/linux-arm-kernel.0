From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:50:49 +0200
Subject: [PATCH 0111/1529] Fix typo
Message-ID: <20160521115049.5125-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-pxa/pcm027.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/pcm027.h b/arch/arm/mach-pxa/pcm027.h
index 047cdf2..7c884db 100644
--- a/arch/arm/mach-pxa/pcm027.h
+++ b/arch/arm/mach-pxa/pcm027.h
@@ -79,8 +79,8 @@
 /*
  * This CPU module needs a baseboard to work. After basic initializing
  * its own devices, it calls baseboard's init function.
- * TODO: Add your own basebaord init function and call it from
- * inside pcm027_init(). This example here is for the developmen board.
+ * TODO: Add your own baseboard init function and call it from
+ * inside pcm027_init(). This example here is for the development board.
  * Refer pcm990-baseboard.c
  */
 extern void pcm990_baseboard_init(void);
-- 
2.8.2.534.g1f66975
