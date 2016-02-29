From: david@lechnology.com (David Lechner)
Date: Mon, 29 Feb 2016 16:33:25 -0600
Subject: [PATCH 2/3] arm: davinci: remove unused DA8XX_NUM_UARTS
In-Reply-To: <1456785206-2280-1-git-send-email-david@lechnology.com>
References: <1456785206-2280-1-git-send-email-david@lechnology.com>
Message-ID: <1456785206-2280-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DA8X_NUM_UARTS not used in the code anywhere and should be determined
by DT anyway.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/da8xx-dt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 358ab34..08880e7 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -18,8 +18,6 @@
 #include "cp_intc.h"
 #include <mach/da8xx.h>
 
-#define DA8XX_NUM_UARTS	3
-
 static const struct of_device_id const da8xx_irq_match[] __initconst = {
 	{ .compatible = "ti,cp-intc", .data = cp_intc_of_init, },
 	{ }
-- 
1.9.1
