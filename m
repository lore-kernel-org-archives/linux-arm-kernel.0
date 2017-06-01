From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 22:52:10 +0200
Subject: [PATCH 5/5] ARM: OMAP1: Fix a typo in a comment line
In-Reply-To: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
References: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
Message-ID: <664000ee-e49f-17cf-19fb-ec639833deab@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 22:17:03 +0200

Adjust a line in this description for the software module.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap1/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index 637f8c9d9f10..8fb1ec6fa999 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -3,7 +3,7 @@
  *
  * Contains first level initialization routines which internally
  * generates timer device information and registers with linux
- * device model. It also has low level function to chnage the timer
+ * device model. It also has a low level function to change the timer
  * input clock source.
  *
  * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
-- 
2.13.0
