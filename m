From: robherring2@gmail.com (Rob Herring)
Date: Thu,  1 Mar 2012 21:13:26 -0600
Subject: [PATCH v3 14/30] ARM: at91: add explicit include of hardware.h to
 uncompressor
In-Reply-To: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
Message-ID: <1330658022-14559-15-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to remove mach/io.h, add explicit include of hardware.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/include/mach/uncompress.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index 0234fd9..4218647 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -23,6 +23,7 @@
 
 #include <linux/io.h>
 #include <linux/atmel_serial.h>
+#include <mach/hardware.h>
 
 #if defined(CONFIG_AT91_EARLY_DBGU0)
 #define UART_OFFSET AT91_BASE_DBGU0
-- 
1.7.5.4
