From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Wed,  9 Dec 2009 21:08:55 +0800
Subject: [PATCH 2/3] ARM: MX3: remove duplicated #include
Message-ID: <1260364135-2320-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/mach-mx3/mx31lite-db.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-mx3/mx31lite-db.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 694611d..ccef689 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -30,7 +30,6 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
-#include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-- 
1.6.1.3
