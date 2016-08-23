From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 23 Aug 2016 15:18:57 +0000
Subject: [PATCH -next] ARM: pxa: remove duplicated include from corgi.c
Message-ID: <1471965537-7960-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated include.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 arch/arm/mach-pxa/corgi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 10bfdb1..183cd34 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -35,7 +35,6 @@
 #include <linux/mtd/sharpsl.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio_keys.h>
-#include <linux/module.h>
 #include <linux/memblock.h>
 #include <video/w100fb.h>
 
