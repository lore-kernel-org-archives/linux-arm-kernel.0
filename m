From: bryan.wu@canonical.com (Bryan Wu)
Date: Tue,  1 May 2012 23:01:42 +0800
Subject: [PATCH 15/19] ARM: plat-samsung: remove including old leds event API
 header file
In-Reply-To: <1335884506-15370-1-git-send-email-bryan.wu@canonical.com>
References: <1335884506-15370-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1335884506-15370-16-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/plat-samsung/time.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-samsung/time.c b/arch/arm/plat-samsung/time.c
index 4dcb11c..60552e2 100644
--- a/arch/arm/plat-samsung/time.c
+++ b/arch/arm/plat-samsung/time.c
@@ -28,7 +28,6 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
-#include <asm/leds.h>
 #include <asm/mach-types.h>
 
 #include <asm/irq.h>
-- 
1.7.9.5
