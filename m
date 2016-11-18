From: geliangtang@gmail.com (Geliang Tang)
Date: Fri, 18 Nov 2016 22:21:10 +0800
Subject: [PATCH] ARM: ixp4xx: drop duplicate header gpio.h
Message-ID: <319a5803aac795e175306d4978134f0247cf87bc.1479457751.git.geliangtang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop duplicate header gpio.h from dsmg600-setup.c.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/arm/mach-ixp4xx/dsmg600-setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 43ee06d..b3bd0e1 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -26,7 +26,6 @@
 #include <linux/reboot.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
-#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 
-- 
2.9.3
