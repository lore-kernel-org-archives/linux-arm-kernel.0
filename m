From: weiyi.huang@gmail.com (Huang Weiyi)
Date: Sun, 14 Mar 2010 10:56:58 +0800
Subject: [PATCH 2/3] ARM: MX3: remove duplicated #include
Message-ID: <1268535418-1992-1-git-send-email-weiyi.huang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated #include('s) in
  arch/arm/mach-mx3/mx31lite-db.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-mx3/mx31lite-db.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index ccd8742..b30664a 100644
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
