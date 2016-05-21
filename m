From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:48:07 +0200
Subject: [PATCH 0086/1529] Fix typo
Message-ID: <20160521114807.3817-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/include/debug/samsung.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/debug/samsung.S b/arch/arm/include/debug/samsung.S
index 8d8d922..92f1bc8 100644
--- a/arch/arm/include/debug/samsung.S
+++ b/arch/arm/include/debug/samsung.S
@@ -11,7 +11,7 @@
 
 #include <linux/serial_s3c.h>
 
-/* The S5PV210/S5PC110 implementations are as belows. */
+/* The S5PV210/S5PC110 implementations are as below. */
 
 	.macro fifo_level_s5pv210 rd, rx
 		ldr	\rd, [\rx, # S3C2410_UFSTAT]
-- 
2.8.2.534.g1f66975
