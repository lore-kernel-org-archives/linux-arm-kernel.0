From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 23 Aug 2016 15:18:18 +0000
Subject: [PATCH -next] ARM: pxa: remove duplicated include from spitz.c
Message-ID: <1471965498-7824-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated include.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 arch/arm/mach-pxa/spitz.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 2c150bf..67d66c7 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -31,7 +31,6 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
-#include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/memblock.h>
 
