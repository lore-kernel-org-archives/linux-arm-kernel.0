From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 3 Apr 2013 11:25:03 +0200
Subject: [PATCH] ARM: at91: remove unused dbgu_readl() macro
Message-ID: <1364981103-22980-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91_dbgu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_dbgu.h b/arch/arm/mach-at91/include/mach/at91_dbgu.h
index 2aa0c5e..3b59485 100644
--- a/arch/arm/mach-at91/include/mach/at91_dbgu.h
+++ b/arch/arm/mach-at91/include/mach/at91_dbgu.h
@@ -16,9 +16,6 @@
 #ifndef AT91_DBGU_H
 #define AT91_DBGU_H
 
-#define dbgu_readl(dbgu, field) \
-	__raw_readl(AT91_VA_BASE_SYS + dbgu + AT91_DBGU_ ## field)
-
 #if !defined(CONFIG_ARCH_AT91X40)
 #define AT91_DBGU_CR		(0x00)	/* Control Register */
 #define AT91_DBGU_MR		(0x04)	/* Mode Register */
-- 
1.8.0
