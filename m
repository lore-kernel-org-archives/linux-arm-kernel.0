From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Nov 2012 12:22:54 +0100
Subject: [PATCH 10/10] arm: at91: move at91rm9200 rtc header in drivers/rtc
In-Reply-To: <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121107111235.GH20063@game.jcrosoft.org>
 <1352287374-25176-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1352287374-25176-10-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: rtc-linux at googlegroups.com
---
 drivers/rtc/rtc-at91rm9200.c                                         |    2 +-
 .../include/mach/at91_rtc.h => drivers/rtc/rtc-at91rm9200.h          |    0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/mach-at91/include/mach/at91_rtc.h => drivers/rtc/rtc-at91rm9200.h (100%)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index fca9790..b6469e2 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -31,7 +31,7 @@
 
 #include <asm/uaccess.h>
 
-#include <mach/at91_rtc.h>
+#include "rtc-at91rm9200.h"
 
 #define at91_rtc_read(field) \
 	__raw_readl(at91_rtc_regs + field)
diff --git a/arch/arm/mach-at91/include/mach/at91_rtc.h b/drivers/rtc/rtc-at91rm9200.h
similarity index 100%
rename from arch/arm/mach-at91/include/mach/at91_rtc.h
rename to drivers/rtc/rtc-at91rm9200.h
-- 
1.7.10.4
