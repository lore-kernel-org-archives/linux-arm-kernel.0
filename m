From: b-cousson@ti.com (Benoit Cousson)
Date: Fri, 2 Mar 2012 17:50:14 +0100
Subject: [PATCH 02/12] mfd: twl-core: remove unneeded header
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Message-ID: <1330707024-23730-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

This driver doesn't really need <plat/cpu.h>, so remove it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/twl-core.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f28a1dc..e612678 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -45,10 +45,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-#include <plat/cpu.h>
-#endif
-
 /*
  * The TWL4030 "Triton 2" is one of a family of a multi-function "Power
  * Management and System Companion Device" chips originally designed for
-- 
1.7.0.4
