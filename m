From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 22 Mar 2015 12:36:47 +0200
Subject: [PATCH] ARM: remove duplicate reboot.h include in process.c
Message-ID: <3093e9eafb72eae28fe83b350ddb88d2cd5c99d8.1427020607.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes: 7b6d864b48d ('reboot: arm: change reboot_mode to use enum reboot_mode')
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fdfa3a78ec8c..7989a9063fea 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -31,7 +31,6 @@
 #include <linux/random.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/leds.h>
-#include <linux/reboot.h>
 
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
-- 
2.1.4
