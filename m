From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 20 Jun 2013 07:44:05 +0800
Subject: [PATCH -next] arm: remove duplicated include from process.c
Message-ID: <CAPgLHd9-sZkf8CboY9noao0GnSRRFsRCtnU0C0mtmKJRRFaC-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 7591df5..f89ff80 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -32,7 +32,6 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/cpuidle.h>
 #include <linux/leds.h>
-#include <linux/reboot.h>
 
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
