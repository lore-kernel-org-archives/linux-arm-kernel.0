From: wanlong.gao@gmail.com (Wanlong Gao)
Date: Sun, 24 Jul 2011 11:39:09 +0800
Subject: [PATCH] ARM:mach-s3c2410:remove the dup include file leds.h
Message-ID: <1311478749-6323-1-git-send-email-wanlong.gao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wanlong Gao <gaowanlong@cn.fujitsu.com>

linux/leds.h has been included twice in h1940-bluetooth.c.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 arch/arm/mach-s3c2410/h1940-bluetooth.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2410/h1940-bluetooth.c b/arch/arm/mach-s3c2410/h1940-bluetooth.c
index 2c126bb..a5eeb62 100644
--- a/arch/arm/mach-s3c2410/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c2410/h1940-bluetooth.c
@@ -18,7 +18,6 @@
 #include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/rfkill.h>
-#include <linux/leds.h>
 
 #include <mach/regs-gpio.h>
 #include <mach/hardware.h>
-- 
1.7.4.1
