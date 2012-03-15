From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Mar 2012 14:00:11 +0100
Subject: [PATCH 3/6] ARM: at91/Kconfig: add comment to at91sam9x5 family entry
In-Reply-To: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
References: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
Message-ID: <ab6ff7bf84cdf0b77dd5402a4988aa9810fe1ecc.1331816340.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add comment to make it clear that several SoC are supported by
this generic entry.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 5f0fe11..4a896c6 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -113,6 +113,12 @@ config ARCH_AT91SAM9X5
 	select HAVE_NET_MACB
 	select HAVE_AT91_DBGU0
 	select AT91_SAM9G45_RESET
+	help
+	  Select this if you are using one of Atmel's AT91SAM9x5 family SoC.
+	  This means that your SAM9 name finishes with a '5' (except if it is
+	  AT91SAM9G45!).
+	  This support covers AT91SAM9G15, AT91SAM9G25, AT91SAM9X25, AT91SAM9G35
+	  and AT91SAM9X35.
 
 config ARCH_AT91X40
 	bool "AT91x40"
-- 
1.7.9
