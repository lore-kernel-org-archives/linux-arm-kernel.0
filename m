From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Wed, 30 Oct 2013 13:38:18 +0800
Subject: [PATCH -next] ARM: ixp4xx: remove duplicated include from
 dsmg600-setup.c
Message-ID: <CAPgLHd9U4t3K4ziGQub9fat6Wqwj2PXh0O+DDYFNnf7r5eB_2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/arm/mach-ixp4xx/dsmg600-setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 736dc69..7740e13 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -26,7 +26,6 @@
 #include <linux/reboot.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
-#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 
