From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 30 Apr 2012 15:37:21 +0800
Subject: [PATCH 16/19] ARM: mach-pnx4008: remove including old leds event API
 header file
In-Reply-To: <1335771444-26361-1-git-send-email-bryan.wu@canonical.com>
References: <1335771444-26361-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1335771444-26361-17-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-pnx4008/time.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pnx4008/time.c b/arch/arm/mach-pnx4008/time.c
index 0cfe8af..47a7ae9 100644
--- a/arch/arm/mach-pnx4008/time.c
+++ b/arch/arm/mach-pnx4008/time.c
@@ -25,7 +25,6 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/leds.h>
 #include <asm/mach/time.h>
 #include <asm/errno.h>
 
-- 
1.7.9.5
