From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Mar 2012 14:00:09 +0100
Subject: [PATCH 1/6] ARM: at91: change AT91 Kconfig entry comment
Message-ID: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cabd8f5..e7043c8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -324,8 +324,8 @@ config ARCH_AT91
 	select CLKDEV_LOOKUP
 	select IRQ_DOMAIN
 	help
-	  This enables support for systems based on the Atmel AT91RM9200,
-	  AT91SAM9 processors.
+	  This enables support for systems based on Atmel
+	  AT91RM9200 and AT91SAM9* processors.
 
 config ARCH_BCMRING
 	bool "Broadcom BCMRING"
-- 
1.7.9
