From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Mar 2012 14:00:13 +0100
Subject: [PATCH 5/6] ARM: at91/Kconfig: add AT91SAM9x5 family to
 AT91_EARLY_DBGU0 entry
In-Reply-To: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
References: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
Message-ID: <5cf97bff4110a92ed592b5e0cfe33ac35df2c591.1331816340.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 6e02b58..24da4cc 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -535,7 +535,7 @@ choice
 	prompt "Select a UART for early kernel messages"
 
 config AT91_EARLY_DBGU0
-	bool "DBGU on rm9200, 9260/9g20, 9261/9g10 and 9rl"
+	bool "DBGU on rm9200, 9260/9g20, 9261/9g10, 9rl and 9x5"
 	depends on HAVE_AT91_DBGU0
 
 config AT91_EARLY_DBGU1
-- 
1.7.9
