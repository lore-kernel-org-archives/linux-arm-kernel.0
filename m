From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Fri, 3 Dec 2010 20:35:47 +0530
Subject: [PATCH 14/20] plat-nomadik/gpio: add expander gpio pins enumeration
In-Reply-To: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <1291388753-14662-15-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/mach-ux500/include/mach/gpio.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/gpio.h b/arch/arm/mach-ux500/include/mach/gpio.h
index d548a62..f28da77 100644
--- a/arch/arm/mach-ux500/include/mach/gpio.h
+++ b/arch/arm/mach-ux500/include/mach/gpio.h
@@ -8,6 +8,34 @@
 #define ARCH_NR_GPIOS	350
 
 #include <plat/gpio.h>
+#include <mach/irqs.h>
+
+enum {
+	EGPIO_PIN_0 = NOMADIK_NR_GPIO,
+	EGPIO_PIN_1,
+	EGPIO_PIN_2,
+	EGPIO_PIN_3,
+	EGPIO_PIN_4,
+	EGPIO_PIN_5,
+	EGPIO_PIN_6,
+	EGPIO_PIN_7,
+	EGPIO_PIN_8,
+	EGPIO_PIN_9,
+	EGPIO_PIN_10,
+	EGPIO_PIN_11,
+	EGPIO_PIN_12,
+	EGPIO_PIN_13,
+	EGPIO_PIN_14,
+	EGPIO_PIN_15,
+	EGPIO_PIN_16,
+	EGPIO_PIN_17,
+	EGPIO_PIN_18,
+	EGPIO_PIN_19,
+	EGPIO_PIN_20,
+	EGPIO_PIN_21,
+	EGPIO_PIN_22,
+	EGPIO_PIN_23,
+};
 
 #define __GPIO_RESOURCE(soc, block)					\
 	{								\
-- 
1.7.2.dirty
