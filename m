From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Mar 2012 14:00:12 +0100
Subject: [PATCH 4/6] ARM: at91/Kconfig: add clarifications to
 AT91SAM9M10G45-EK entry
In-Reply-To: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
References: <feb3f4c639fae3f01636ba2017968fac1078ddca.1331816340.git.nicolas.ferre@atmel.com>
Message-ID: <b32b4c16c5997f0df32300e5eb1762caf9c40e88.1331816340.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clarifications about the SoCs that can be found on an AT91SAM9M10G45-EK
board. Add also the web link to this board on Atmel's website.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 4a896c6..6e02b58 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -448,9 +448,10 @@ comment "AT91SAM9G45 Board Type"
 config MACH_AT91SAM9M10G45EK
 	bool "Atmel AT91SAM9M10G45-EK Evaluation Kits"
 	help
-	  Select this if you are using Atmel's AT91SAM9G45-EKES Evaluation Kit.
-	  "ES" at the end of the name means that this board is an
-	  Engineering Sample.
+	  Select this if you are using Atmel's AT91SAM9M10G45-EK Evaluation Kit.
+	  Those boards can be populated with any SoC of AT91SAM9G45 or AT91SAM9M10
+	  families: AT91SAM9G45, AT91SAM9G46, AT91SAM9M10 and AT91SAM9M11.
+	  <http://www.atmel.com/tools/SAM9M10-G45-EK.aspx>
 
 endif
 
-- 
1.7.9
